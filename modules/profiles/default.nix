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
    foldl'
    ;
  inherit (lib)
    mkOption
    mkDefault
    types
    mapAttrsToList
    recursiveUpdate
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
      id = "ios-configurations.setupAssistant.managed";
      uuid = "a99ded28-9c3a-40f2-97f5-ab89b6b1b2c9";
    };
    airplay = {
      name = "com.apple.airplay";
      id = "ios-configurations.airplay";
      uuid = "abe2d54a-44a8-4263-92ab-0e58d83435db";
    };
    airprint = {
      name = "com.apple.airprint";
      id = "ios-configurations.airprint";
      uuid = "aa75f447-fea6-4427-8a28-4341b3c199e4";
    };
    apn.managed = {
      name = "com.apple.apn.managed";
      id = "ios-configurations.apn.managed";
      uuid = "a9ace15f-ac9e-46ac-8ec7-bfc4cb39bda2";
    };
    app.lock = {
      name = "com.apple.app.lock";
      id = "ios-configurations.app.lock";
      uuid = "393b6d18-f734-47e7-87b1-c114bd60c1d7";
    };
    applicationaccess = {
      name = "com.apple.applicationaccess";
      id = "ios-configurations.applicationaccess";
      uuid = "1d287fe8-20d9-46a3-9e27-0a7f6a3375d4";
    };
    caldav.account = {
      name = "com.apple.caldav.account";
      id = "ios-configurations.caldav.account";
      uuid = "ebffc740-0f3c-477f-be37-d16f92a56e93";
    };
    carddav.account = {
      name = "com.apple.carddav.account";
      id = "ios-configurations.carddav.account";
      uuid = "51468e28-f09e-4d80-a4fd-62704a04326f";
    };
    cellular = {
      name = "com.apple.cellular";
      id = "ios-configurations.cellular";
      uuid = "1350b652-696e-44e5-abf0-72755107aac2";
    };
    cellularprivatenetwork.managed = {
      name = "com.apple.cellularprivatenetwork.managed";
      id = "ios-configurations.cellularprivatenetwork.managed";
      uuid = "e12476cd-0f8b-4270-bc34-073e96f01a23";
    };
    declarations = {
      name = "com.apple.declarations";
      id = "ios-configurations.declarations";
      uuid = "09f09d9b-eb1f-4576-b89c-576056b44647";
    };
    dnsProxy.managed = {
      name = "com.apple.dnsProxy.managed";
      id = "ios-configurations.dnsProxy.managed";
      uuid = "a019cd59-aff2-41c2-909c-e8f88d25de33";
    };
    dnsSettings.managed = {
      name = "com.apple.dnsSettings.managed";
      id = "ios-configurations.dnsSettings.managed";
      uuid = "779ac0cc-142a-4cb9-9f13-cc7912a49949";
    };
    domains = {
      name = "com.apple.domains";
      id = "ios-configurations.domains";
      uuid = "687c4b8d-dbf7-4142-86ff-f56578e06c86";
    };
    eas.account = {
      name = "com.apple.eas.account";
      id = "ios-configurations.eas.account";
      uuid = "42da894c-81f3-46b9-b641-b8a3f94e7e0b";
    };
    education = {
      name = "com.apple.education";
      id = "ios-configurations.education";
      uuid = "3d55bf6c-4871-48e2-8e3f-d048c96a17db";
    };
    extensiblesso-kerberos = {
      name = "com.apple.extensiblesso(kerberos)";
      id = "ios-configurations.extensiblesso-kerberos";
      uuid = "218d7ec2-33c7-4654-b01b-018bace9478d";
    };
    extensiblesso = {
      name = "com.apple.extensiblesso";
      id = "ios-configurations.extensiblesso";
      uuid = "15d99c00-f9e9-4308-ae29-bf9058e83c36";
    };
    font = {
      name = "com.apple.font";
      id = "ios-configurations.font";
      uuid = "33ca8f74-6b73-47f9-adfb-08de15252654";
    };
    globalethernet.managed = {
      name = "com.apple.globalethernet.managed";
      id = "ios-configurations.globalethernet.managed";
      uuid = "0efdacde-25dd-4334-a2a2-e9cc2289d0c0";
    };
    google-oauth = {
      name = "com.apple.google-oauth";
      id = "ios-configurations.google-oauth";
      uuid = "26b6a0d7-ae27-461a-8df3-89cca859015c";
    };
    homescreenlayout = {
      name = "com.apple.homescreenlayout";
      id = "ios-configurations.homescreenlayout";
      uuid = "8478fa79-7865-490f-a8d3-5454366b9db7";
    };
    ldap.account = {
      name = "com.apple.ldap.account";
      id = "ios-configurations.ldap.account";
      uuid = "20759187-0478-44d6-a1c0-9a438169d16a";
    };
    mail.managed = {
      name = "com.apple.mail.managed";
      id = "ios-configurations.mail.managed";
      uuid = "fb293e3d-928b-4d23-9bc3-78e9bc81f493";
    };
    mdm = {
      name = "com.apple.mdm";
      id = "ios-configurations.mdm";
      uuid = "92b9a0d2-c387-4357-8d6f-5ccd6f43c9ff";
    };
    mobiledevice.passwordpolicy = {
      name = "com.apple.mobiledevice.passwordpolicy";
      id = "ios-configurations.mobiledevice.passwordpolicy";
      uuid = "f4f5f27c-e2c4-40ea-9b51-96e8a69c260e";
    };
    networkusagerules = {
      name = "com.apple.networkusagerules";
      id = "ios-configurations.networkusagerules";
      uuid = "e565c4a7-e032-45b4-adaf-c81ed1e2fa5d";
    };
    notificationsettings = {
      name = "com.apple.notificationsettings";
      id = "ios-configurations.notificationsettings";
      uuid = "86ad6aba-c82f-497c-9686-a97e37972dfc";
    };
    osxserver.account = {
      name = "com.apple.osxserver.account";
      id = "ios-configurations.osxserver.account";
      uuid = "2c5f10f6-5303-462a-b55f-57ca6403849f";
    };
    profileRemovalPassword = {
      name = "com.apple.profileRemovalPassword";
      id = "ios-configurations.profileRemovalPassword";
      uuid = "88a3507e-117e-4537-8846-576727215805";
    };
    proxy.http.global = {
      name = "com.apple.proxy.http.global";
      id = "ios-configurations.proxy.http.global";
      uuid = "3f5d8e47-1252-4136-a5a3-56882ec56b6a";
    };
    relay.managed = {
      name = "com.apple.relay.managed";
      id = "ios-configurations.relay.managed";
      uuid = "85f8dbce-22ff-427e-9dcb-b646c338ec3f";
    };
    security.acme = {
      name = "com.apple.security.acme";
      id = "ios-configurations.security.acme";
      uuid = "87cacd1d-a747-41bc-9dc9-26069563415d";
    };
    security.certificaterevocation = {
      name = "com.apple.security.certificaterevocation";
      id = "ios-configurations.security.certificaterevocation";
      uuid = "61328cd0-28ca-468d-9f93-4ed7b769275b";
    };
    security.certificatetransparency = {
      name = "com.apple.security.certificatetransparency";
      id = "ios-configurations.security.certificatetransparency";
      uuid = "11adfdbc-42e0-4791-991f-d640a442dde2";
    };
    security.pem = {
      name = "com.apple.security.pem";
      id = "ios-configurations.security.pem";
      uuid = "97edda38-ecae-4239-a6b9-0947451169d5";
    };
    security.pkcs1 = {
      name = "com.apple.security.pkcs1";
      id = "ios-configurations.security.pkcs1";
      uuid = "606a33dc-3bee-4487-9a6e-468f3545e3db";
    };
    security.pkcs12 = {
      name = "com.apple.security.pkcs12";
      id = "ios-configurations.security.pkcs12";
      uuid = "219c4b2b-2c0c-488f-8633-dbc2a521703f";
    };
    security.root = {
      name = "com.apple.security.root";
      id = "ios-configurations.security.root";
      uuid = "c5727443-cadb-4e90-979e-37601df8c1f2";
    };
    security.scep = {
      name = "com.apple.security.scep";
      id = "ios-configurations.security.scep";
      uuid = "52594027-0288-4fd8-83e3-87092231a4a3";
    };
    shareddeviceconfiguration = {
      name = "com.apple.shareddeviceconfiguration";
      id = "ios-configurations.shareddeviceconfiguration";
      uuid = "5bcbf601-6b30-4f07-8795-4fc04fcb1064";
    };
    sso = {
      name = "com.apple.sso";
      id = "ios-configurations.sso";
      uuid = "c92728c2-5c7f-47e7-bc2a-001dac912d8c";
    };
    subscribedcalendar.account = {
      name = "com.apple.subscribedcalendar.account";
      id = "ios-configurations.subscribedcalendar.account";
      uuid = "08f53aac-be8d-407f-b974-6cf493d9f2e9";
    };
    tvremote = {
      name = "com.apple.tvremote";
      id = "ios-configurations.tvremote";
      uuid = "7960604e-6471-417d-9a06-abccfd7d7280";
    };
    vpn.managed-applayer = {
      name = "com.apple.vpn.managed.applayer";
      id = "ios-configurations.vpn.managed-applayer";
      uuid = "6ed914ba-283f-462f-b697-93f56fe9f6f4";
    };
    vpn.managed = {
      name = "com.apple.vpn.managed";
      id = "ios-configurations.vpn.managed";
      uuid = "efcc0043-14c8-49cc-9d8d-976a6a4ff093";
    };
    webClip.managed = {
      name = "com.apple.webClip.managed";
      id = "ios-configurations.webClip.managed";
      uuid = "cb9d9ff1-255b-4d07-b7a0-04245c5bb511";
    };
    webcontent-filter = {
      name = "com.apple.webcontent-filter";
      id = "ios-configurations.webcontent-filter";
      uuid = "9c8d98a4-7f31-4425-9836-ef7112ef04b4";
    };
    wifi.managed = {
      name = "com.apple.wifi.managed";
      id = "ios-configurations.wifi.managed";
      uuid = "3d3ddc64-1742-4a01-9cbc-8356ab5299c6";
    };
  };

  mergeAttrs = foldl' recursiveUpdate { };

  profileOptions = mergeAttrs (map toProfileOption configs);
  defaultProfileConfig = mergeAttrs (map toDefaultProfileConfig configs);
  profileAssertions = concatMap toProfileAssertions configs;

  # convert generatedConfigs to list and import each generated config
  configs = map (config: config // (get-generated config.name)) (nestedAttrsToList generatedConfigs);

  toProfileOption =
    config:
    toNestedAttrs config.path (mkOption {
      type = utils.subopts config.options;
      description = config.description;
    });

  toDefaultProfileConfig =
    config:
    toNestedAttrs config.path {
      PayloadIdentifier = mkDefault config.id;
      PayloadUUID = mkDefault config.uuid;
    };

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
  _class = "ios";

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
                <string>Config from iosConfigurations.nix</string>
                <key>PayloadIdentifier</key>
                <string>ios-configurations</string>
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
