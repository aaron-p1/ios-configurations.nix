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

  does-not-gen-empty-profile =
    let
      config.profiles.setupAssistant.managed = { };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert !hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "does-not-gen-empty-profile" { } "touch $out";
}
