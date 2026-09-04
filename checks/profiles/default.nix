{
  eval,
  pkgs,
  lib,
}:
let
  inherit (builtins) tryEval;
  inherit (lib) hasInfix;
in
{
  valid-xml =
    pkgs.runCommand "valid-xml"
      {
        buildInputs = [ pkgs.libxml2 ];
        content = (eval { }).config.profiles.plist;
      }
      ''
        echo "$content" > profiles.plist
        xmllint --noout profiles.plist

        touch $out
      '';

  generates-boilerplate =
    let
      plist = (eval { }).config.profiles.plist;
    in
    assert hasInfix "PayloadContent" plist;
    assert hasInfix "PayloadDisplayName" plist;
    assert hasInfix "PayloadIdentifier" plist;
    assert hasInfix "<string>com.example.manage-ios</string>" plist;
    assert hasInfix "PayloadUUID" plist;
    assert hasInfix "PayloadType" plist;
    assert hasInfix "PayloadVersion" plist;
    pkgs.runCommand "generates-boilerplate" { } "touch $out";

  does-not-gen-disabled-profile =
    let
      config.profiles.setupAssistant.managed.enable = false;
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert !hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "does-not-gen-disabled-profile" { } "touch $out";

  can-gen-enabled-empty-profile =
    let
      config.profiles.setupAssistant.managed.enable = true;
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-enabled-empty-profile" { } "touch $out";

  does-not-set-empty-props =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ ];
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    assert !hasInfix "SkipSetupItems" plist;
    pkgs.runCommand "does-not-set-empty-props" { } "touch $out";

  empty-list-counts-as-empty-prop =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ ];
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert !hasInfix "SkipSetupItems" plist;
    pkgs.runCommand "empty-list-counts-as-empty-prop" { } "touch $out";

  can-gen-setupassistant-managed =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ "SkipValue" ];
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    # test with indentation to not match the global keys
    assert hasInfix "        <key>PayloadType</key>" plist;
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    assert hasInfix "        <key>PayloadVersion</key>" plist;
    assert hasInfix "        <key>PayloadIdentifier</key>" plist;
    assert hasInfix "<string>com.example.manage-ios.SetupAssistant.managed</string>" plist;
    assert hasInfix "        <key>PayloadUUID</key>" plist;
    assert hasInfix "<string>SkipValue</string>" plist;
    pkgs.runCommand "can-gen-setupassistant-managed" { } "touch $out";

  can-gen-airplay =
    let
      config.profiles.airplay = {
        enable = true;
        AllowList = [
          {
            DeviceID = "00:11:22:33:44:55";
            DeviceName = "My AirPlay Device";
          }
        ];
        Passwords = [
          {
            DeviceName = "My AirPlay Device Password";
            Password = "MyPassword";
          }
        ];
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.airplay</string>" plist;
    assert hasInfix "<string>00:11:22:33:44:55</string>" plist;
    assert hasInfix "<string>My AirPlay Device</string>" plist;
    assert hasInfix "<string>My AirPlay Device Password</string>" plist;
    assert hasInfix "<string>MyPassword</string>" plist;
    pkgs.runCommand "can-gen-airplay" { } "touch $out";

  options-can-be-required =
    let
      config.profiles.airplay = {
        enable = true;
        Passwords = [ { DeviceName = "Name"; } ];
      };
      # this should throw an error because Password is required
      result = tryEval (eval { inherit config; }).config.profiles.plist;
    in
    assert result.success == false;
    pkgs.runCommand "options-can-be-required" { } "touch $out";

  can-gen-airprint =
    let
      config.profiles.airprint = {
        enable = true;
        AirPrint = [
          {
            IPAddress = "127.0.0.1";
            ResourcePath = "ipp/print";
            Port = 631;
            ForceTLS = true;
          }
        ];
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.airprint</string>" plist;
    assert hasInfix "<string>127.0.0.1</string>" plist;
    assert hasInfix "<string>ipp/print</string>" plist;
    assert hasInfix "<integer>631</integer>" plist;
    assert hasInfix "<true/>" plist;
    pkgs.runCommand "can-gen-airprint" { } "touch $out";

  can-gen-apn-managed =
    let
      config.profiles.apn.managed = {
        enable = true;
        DefaultsData.apns = [
          {
            apn = "internet";
            username = "user";
            password = "password";
            proxy = "proxy.example.com";
            proxyPort = 8080;
          }
        ];
        DefaultsDomainName = "com.apple.managedCarrier";
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.apn.managed</string>" plist;
    assert hasInfix "<string>internet</string>" plist;
    assert hasInfix "<data>" plist;
    assert hasInfix "cGFzc3dvcmQ=" plist;
    assert hasInfix "<integer>8080</integer>" plist;
    pkgs.runCommand "can-gen-apn-managed" { } "touch $out";
}
// (import ./assertions.nix { inherit eval pkgs lib; })
