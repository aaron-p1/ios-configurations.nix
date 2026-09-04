{
  lib,
  utils,
  config,
  pkgs,
  ...
}:
let
  inherit (builtins)
    head
    tail
    filter
    removeAttrs
    concatMap
    ;
  inherit (lib)
    mkOption
    types
    mapAttrsToList
    mergeAttrsList
    pipe
    attrByPath
    concatStringsSep
    flatten
    trim
    optional
    versionAtLeast
    versionOlder
    attrsToList
    splitString
    ;
  inherit (utils) profileConfigToPlist;

  generatedConfigs = {
    setupAssistant.managed = {
      name = "com.apple.SetupAssistant.managed";
      uuid = "a99ded28-9c3a-40f2-97f5-ab89b6b1b2c9";
    };
    airplay = {
      name = "com.apple.airplay";
      uuid = "abe2d54a-44a8-4263-92ab-0e58d83435db";
    };
    airprint = {
      name = "com.apple.airprint";
      uuid = "aa75f447-fea6-4427-8a28-4341b3c199e4";
    };
    apn.managed = {
      name = "com.apple.apn.managed";
      uuid = "a9ace15f-ac9e-46ac-8ec7-bfc4cb39bda2";
    };
  };

  profileOptions = mergeAttrsList (map (config: toNestedAttrs config.path config.options) configs);

  defaultProfileConfig = mergeAttrsList (map toDefaultProfileConfig configs);

  profileAssertions = concatMap toProfileAssertions configs;

  # convert generatedConfigs to list and import each generated config
  configs = map (config: config // (get-generated config.name)) (nestedAttrsToList generatedConfigs);

  toDefaultProfileConfig = config: toNestedAttrs config.path { PayloadUUID = config.uuid; };

  toProfileAssertions =
    pConfig:
    if (getProfileConfigValues pConfig).enable then
      genAssertions pConfig.supportData (getProfileConfigValues pConfig) pConfig.path [ ]
    else
      [ ];

  genAssertions =
    supportData: configValue: path: prevKeys:
    concatMap (
      { name, value }:
      if name == "*" then
        throw "wc"
      else
        genAssertionsSingleKey {
          inherit path prevKeys;
          key = name;
          supportData = value;
          configValue = configValue."${name}";
        }
    ) (attrsToList supportData);

  iosVersion = config.targetData.version;
  isSupervised = config.targetData.isSupervised;

  # Currently not checking keys that are attrs, because checking if empty is elaborate.
  # This only causes the assertion message to be not as clear.
  genAssertionsSingleKey =
    {
      key,
      supportData,
      configValue,
      path,
      prevKeys,
    }:
    let
      keys = (prevKeys ++ [ key ]);
      propPathString = concatStringsSep "." (path ++ keys);

      listAssertions =
        if supportData ? "*" then
          concatMap (elem: genAssertions supportData."*" elem path (keys ++ [ "*" ])) configValue
        else
          [ ];

      assertions =
        (optional (iosVersion != null && supportData.minIos != null) {
          assertion = versionAtLeast iosVersion supportData.minIos;
          message = ''
            `${propPathString}` is not supported on iOS ${iosVersion}.
            Minimum required version is ${supportData.minIos}.
          '';
        })
        ++ (optional (iosVersion != null && supportData.maxIos != null) {
          assertion = versionOlder iosVersion supportData.maxIos;
          message = ''
            `${propPathString}` is not supported on iOS ${iosVersion}.
            It was removed in version ${supportData.maxIos}.
          '';
        })
        ++ (optional (isSupervised != null && supportData.supervised != null) {
          assertion = !supportData.supervised || isSupervised;
          message = ''
            `${propPathString}` requires the device to be supervised.
          '';
        });
    in
    if supportData ? minIos then
      if configValue == null || key == "enable" && !configValue then
        [ ]
      else
        (assertions ++ listAssertions)
    else
      genAssertions supportData configValue path keys;

  getProfileConfigValues = pconfig: attrByPath pconfig.path { } cfg;
  profileConfigPlists = pipe configs [
    (map (config: getProfileConfigValues config))
    (filter (config: config.enable))
    (map (
      config:
      profileConfigToPlist {
        inherit pkgs;
        config = removeAttrs config [ "enable" ];
        indent = 3;
      }
    ))
    (map trim)
    (concatStringsSep "\n")
  ];

  # converts nested attrs to [{path = ["a", "b"]; value = ...;} ...]
  nestedAttrsToList = attrs: flatten (nestedAttrsToList' attrs [ ]);
  nestedAttrsToList' =
    attrs: path:
    if attrs ? name then
      attrs // { inherit path; }
    else
      mapAttrsToList (name: value: nestedAttrsToList' value (path ++ [ name ])) attrs;

  # puts value at path
  toNestedAttrs =
    path: value: if path == [ ] then value else { ${head path} = toNestedAttrs (tail path) value; };

  get-generated = name: import ./generated/${name}.nix { inherit lib utils; };

  cfg = config.profiles;
in
{
  _class = "manage-ios";

  options.profiles = {
    plist = mkOption {
      type = types.str;
      readOnly = true;
      description = "The generated profiles.mobileconfig file content.";
    };

    assertions = mkOption {
      internal = true;
      default = [ ];
      type = types.listOf (
        types.submodule {
          options = {
            assertion = mkOption { type = types.bool; };
            message = mkOption { type = types.str; };
          };
        }
      );
    };
  }
  // profileOptions;

  config = {
    profiles = {
      plist =
        let
          failedAssertions = map (a: a.message) (filter (a: !a.assertion) cfg.assertions);
          formatMsg =
            m:
            let
              lines = splitString "\n" m;
              first_line = "- ${head lines}";
              rest = map (l: "  ${l}") (tail lines);
            in
            concatStringsSep "\n" ([ first_line ] ++ rest);
          failedAssertionsText = concatStringsSep "\n" (map formatMsg failedAssertions);
        in
        if failedAssertions != [ ] then
          throw "Failed assertions:\n${failedAssertionsText}"
        else
          # xml
          ''
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
              <dict>
                <key>PayloadDisplayName</key>
                <string>Config from manage-ios.nix</string>
                <key>PayloadIdentifier</key>
                <string>com.example.manage-ios</string>
                <key>PayloadUUID</key>
                <string>7bbadd94-97f8-4c3e-82e1-9ac51cb23ae6</string>
                <key>PayloadType</key>
                <string>Configuration</string>
                <key>PayloadVersion</key>
                <integer>1</integer>
                <key>PayloadContent</key>
                <array>
                  ${profileConfigPlists}
                </array>
              </dict>
            </plist>
          '';
      assertions = profileAssertions;
    }
    // defaultProfileConfig;
  };
}
