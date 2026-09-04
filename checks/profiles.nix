{
  eval,
  pkgs,
  lib,
}:
let
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

  does-not-gen-empty-profile =
    let
      config.profiles.setupAssistant.managed = { };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert !hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "does-not-gen-empty-profile" { } "touch $out";

  empty-list-counts-as-empty-profile =
    let
      config.profiles.setupAssistant.managed.SkipSetupItems = [ ];
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert !hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "empty-list-counts-as-empty-profile" { } "touch $out";

  can-gen-setupassistant-managed =
    let
      config.profiles.setupAssistant.managed.SkipSetupItems = [ "SkipValue" ];
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
      config.profiles.airplay.Passwords = [ { DeviceName = "Name"; } ];
      # this should throw an error because Password is required
      result = builtins.tryEval (eval { inherit config; }).config.profiles.plist;
    in
    assert result.success == false;
    pkgs.runCommand "options-can-be-required" { } "touch $out";

  can-gen-airprint =
    let
      config.profiles.airprint = {
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
}
