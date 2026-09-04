{
  eval,
  pkgs,
  lib,
}:
let
  inherit (builtins) tryEval;
  inherit (lib) hasInfix;

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

  can-output-string =
    let
      config.profiles.apn.managed = {
        enable = true;
        DefaultsDomainName = "com.apple.managedCarrier";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.managedCarrier</string>" plist;
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
    assert hasInfix "<integer>631</integer>" plist;
    pkgs.runCommand "can-output-int" { } "touch $out";

  can-output-float =
    let
      config.profiles.applicationaccess = {
        enable = true;
        safariAcceptCookies = 1.5;
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<real>1.5</real>" plist;
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
    assert hasInfix "<true/>" plist1;
    assert hasInfix "<false/>" plist2;
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
    assert hasInfix "<array>" plist;
    assert hasInfix "<string>Device1</string>" plist;
    assert hasInfix "<string>Device2</string>" plist;
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
    assert hasInfix "<data>" plist;
    assert hasInfix "cGFzc3dvcmQ=" plist; # base64 of "password"
    pkgs.runCommand "can-output-data" { } "touch $out";

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
    assert hasInfix "<dict>" plist;
    assert hasInfix "<key>apn</key>" plist;
    pkgs.runCommand "can-output-dictionary" { } "touch $out";
}
