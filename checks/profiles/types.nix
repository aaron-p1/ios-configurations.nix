{
  eval,
  pkgs,
  lib,
  testUtils,
}:
let
  inherit (builtins) tryEval;
  inherit (testUtils) assertContains assertDoesNotContain;

  evalGetPlist = config: (eval { inherit config; }).config.profiles.plist;
  tryEvalGetPlist = config: tryEval (evalGetPlist config);
in
{
  options-can-be-required =
    let
      config.profiles.airplay = {
        enable = true;
        Passwords = [ { DeviceName = "Name"; } ];
      };
      # this should throw an error because Password is required
      result = tryEvalGetPlist config;
    in
    assert result.success == false;
    pkgs.runCommand "options-can-be-required" { } "touch $out";

  checks-if-int-in-range =
    let
      gen-config = port: {
        profiles.airprint = {
          enable = true;
          AirPrint = [
            {
              IPAddress = "127.0.0.1";
              ResourcePath = "ipp/print";
              Port = port;
            }
          ];
        };
      };
      # this should throw an error because Password is required to be a string
      result1 = tryEvalGetPlist (gen-config 100000);
      result2 = tryEvalGetPlist (gen-config (-1));
      result3 = tryEvalGetPlist (gen-config 631);
    in
    assert result1.success == false;
    assert result2.success == false;
    assert result3.success == true;
    pkgs.runCommand "checks-if-int-in-range" { } "touch $out";

  checks-if-float-in-range =
    let
      gen-config = value: {
        profiles.cellularprivatenetwork.managed = {
          enable = true;
          Geofences = [
            {
              Longitude = value;
              Latitude = 0.0;
              Radius = 100.0;
              GeofenceId = "geofence1";
            }
          ];
          DataSetName = "Name";
          VersionNumber = "1.0";
        };
      };
      result1 = tryEvalGetPlist (gen-config (-1000.0));
      result2 = tryEvalGetPlist (gen-config (-100.0));
      result3 = tryEvalGetPlist (gen-config 100.0);
      result4 = tryEvalGetPlist (gen-config 1000.0);
    in
    assert result1.success == false;
    assert result2.success == true;
    assert result3.success == true;
    assert result4.success == false;
    pkgs.runCommand "checks-if-float-in-range" { } "touch $out";

  checks-if-str-has-format =
    let
      gen-config = name: {
        profiles.airplay = {
          enable = true;
          AllowList = [ { DeviceID = name; } ];
        };
      };
      result1 = tryEvalGetPlist (gen-config "invalid-mac-address");
      result2 = tryEvalGetPlist (gen-config "00:11:22:33:44:55");
    in
    assert result1.success == false;
    assert result2.success == true;
    pkgs.runCommand "checks-if-str-has-format" { } "touch $out";

  checks-enum-values =
    let
      gen-config = name: {
        profiles.apn.managed = {
          enable = true;
          DefaultsDomainName = name;
        };
      };
      result1 = tryEvalGetPlist (gen-config "invalid-domain-name");
      result2 = tryEvalGetPlist (gen-config "com.apple.managedCarrier");
    in
    assert result1.success == false;
    assert result2.success == true;
    pkgs.runCommand "checks-enum-values" { } "touch $out";

  supports-any-attrs =
    let
      config.profiles.dnsProxy.managed = {
        enable = true;
        AppBundleIdentifier = "com.example.dnsproxy";
        ProviderConfiguration = {
          CustomKey = [ "value1" ];
        };
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<key>ProviderConfiguration</key>" plist;
    assert assertContains "<key>CustomKey</key>" plist;
    assert assertContains "<array>" plist;
    assert assertContains "<string>value1</string>" plist;
    pkgs.runCommand "supports-any-attrs" { } "touch $out";

  can-output-string =
    let
      config.profiles.apn.managed = {
        enable = true;
        DefaultsDomainName = "com.apple.managedCarrier";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.managedCarrier</string>" plist;
    pkgs.runCommand "can-output-string" { } "touch $out";

  can-output-int =
    let
      config.profiles.airprint = {
        enable = true;
        AirPrint = [
          {
            IPAddress = "127.0.0.1";
            ResourcePath = "ipp/print";
            Port = 631;
          }
        ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<integer>631</integer>" plist;
    pkgs.runCommand "can-output-int" { } "touch $out";

  can-output-float =
    let
      config.profiles.applicationaccess = {
        enable = true;
        safariAcceptCookies = 1.5;
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<real>1.5</real>" plist;
    pkgs.runCommand "can-output-float" { } "touch $out";

  can-output-bool =
    let
      gen-config = flag: {
        profiles.airprint = {
          enable = true;
          AirPrint = [
            {
              IPAddress = "127.0.0.1";
              ResourcePath = "ipp/print";
              ForceTLS = flag;
            }
          ];
        };
      };
      plist1 = evalGetPlist (gen-config true);
      plist2 = evalGetPlist (gen-config false);
    in
    assert assertContains "<true/>" plist1;
    assert assertContains "<false/>" plist2;
    pkgs.runCommand "can-output-bool" { } "touch $out";

  can-output-array =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [
          "Device1"
          "Device2"
        ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<array>" plist;
    assert assertContains "<string>Device1</string>" plist;
    assert assertContains "<string>Device2</string>" plist;
    pkgs.runCommand "can-output-array" { } "touch $out";

  can-output-data =
    let
      config.profiles.apn.managed = {
        enable = true;
        DefaultsData.apns = [
          {
            apn = "internet";
            username = "user";
            password = "password";
          }
        ];
        DefaultsDomainName = "com.apple.managedCarrier";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<data>" plist;
    assert assertContains "cGFzc3dvcmQ=" plist; # base64 of "password"
    pkgs.runCommand "can-output-data" { } "touch $out";

  can-output-file-as-data =
    let
      config.profiles.apn.managed = {
        enable = true;
        DefaultsData.apns = [
          {
            apn = "as-derivation";
            password = pkgs.writeText "test-password.txt" "password";
          }
          {
            apn = "as-path";
            password = ./data-file.txt;
          }
        ];
        DefaultsDomainName = "com.apple.managedCarrier";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<data>" plist;
    assert assertContains "cGFzc3dvcmQ=" plist; # base64 of "password"
    assert assertContains "VGhpcyBmaWxlIGNhbiBiZSB1c2VkIGluIGRhd" plist; # base64 of data-file.txt content
    pkgs.runCommand "can-output-file-as-data" { } "touch $out";

  can-output-dictionary =
    let
      config.profiles.apn.managed = {
        enable = true;
        DefaultsData.apns = [
          {
            apn = "internet";
            username = "user";
            password = "password";
          }
        ];
        DefaultsDomainName = "com.apple.managedCarrier";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<dict>" plist;
    assert assertContains "<key>apn</key>" plist;
    pkgs.runCommand "can-output-dictionary" { } "touch $out";

  can-define-custom-attributes-with-settings =
    let
      config.profiles.globalethernet.managed = {
        enable = true;
        settings.EthernetMACAddress = "00:11:22:33:44:55";
      };
      plist = evalGetPlist config;
    in
    assert assertDoesNotContain "settings" plist;
    assert assertContains "<key>EthernetMACAddress</key>" plist;
    assert assertContains "<string>00:11:22:33:44:55</string>" plist;
    pkgs.runCommand "can-define-custom-attributes-with-settings" { } "touch $out";

  can-merge-custom-attributes-with-settings =
    let
      config1.profiles.globalethernet.managed = {
        enable = true;
        settings.EthernetMACAddress = "00:11:22:33:44:55";
      };
      config2.profiles.globalethernet.managed = {
        settings.EthernetMTU = 1500;
        settings.nested.subkey = true;
      };
      configs = [
        { config = config1; }
        { config = config2; }
      ];

      plist = (eval configs).config.profiles.plist;
    in
    assert assertDoesNotContain "settings" plist;
    assert assertContains "<key>EthernetMACAddress</key>" plist;
    assert assertContains "<string>00:11:22:33:44:55</string>" plist;
    assert assertContains "<key>EthernetMTU</key>" plist;
    assert assertContains "<integer>1500</integer>" plist;
    assert assertContains "<key>nested</key>" plist;
    assert assertContains "<key>subkey</key>" plist;
    pkgs.runCommand "can-merge-custom-attributes-with-settings" { } "touch $out";
}
