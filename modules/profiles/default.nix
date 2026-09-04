{
  lib,
  utils,
  config,
  ...
}:
let
  inherit (builtins)
    head
    tail
    filter
    elem
    ;
  inherit (lib)
    attrsToList
    mapAttrsToList
    mergeAttrsList
    pipe
    attrByPath
    concatStringsSep
    flatten
    trim
    ;
  inherit (utils) profileConfigToPlist;

  generatedConfigs = {
    setupAssistant.managed = {
      name = "com.apple.SetupAssistant.managed";
      uuid = "a99ded28-9c3a-40f2-97f5-ab89b6b1b2c9";
    };
  };

  profileOptions = mergeAttrsList (map (config: toNestedAttrs config.path config.options) configs);
  defaultProfileConfig = mergeAttrsList (map toDefaultProfileConfig configs);

  # convert generatedConfigs to list and import each generated config
  configs = map (config: config // (get-generated config.name)) (nestedAttrsToList generatedConfigs);

  toDefaultProfileConfig = config: toNestedAttrs config.path { PayloadUUID = config.uuid; };

  getProfileConfigValues = pconfig: attrByPath pconfig.path { } config.profiles;
  profileConfigPlists = pipe configs [
    (map (config: getProfileConfigValues config))
    (filter hasAnyValueSet)
    (map (
      config:
      profileConfigToPlist {
        inherit config;
        indent = 3;
      }
    ))
    (map trim)
    (concatStringsSep "\n")
  ];

  nonValueKeys = [
    "PayloadType"
    "PayloadIdentifier"
    "PayloadUUID"
    "PayloadVersion"
  ];

  hasAnyValueSet =
    config:
    pipe config [
      attrsToList
      (filter ({ name, value }: !(elem name nonValueKeys) && value != null))
      (values: values != [ ])
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
in
{
  _class = "manage-ios";

  options.profiles = {
    plist = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      description = "The generated profiles.mobileconfig file content.";
    };
  }
  // profileOptions;

  config = {
    profiles = {
      plist = # xml
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
    }
    // defaultProfileConfig;
  };
}
