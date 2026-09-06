{
  eval,
  pkgs,
  testUtils,
  ...
}:
let
  inherit (builtins) tryEval;
  inherit (testUtils) assertContains;

  evalGetPlist = config: (eval { inherit config; }).config.profiles.plist;
  tryEvalGetPlist = config: tryEval (evalGetPlist config);
in
{
  can-gen-profile-if-ios-version-is-null =
    let
      config = {
        targetData.version = null;
        profiles.setupAssistant.managed.enable = true;
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-profile-if-ios-version-is-null" { } "touch $out";

  can-gen-profile-if-is-supervised-is-null =
    let
      config = {
        targetData.isSupervised = null;
        profiles.setupAssistant.managed.enable = true;
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-profile-if-is-supervised-is-null" { } "touch $out";

  checks-min-ios-version =
    let
      gen-config = version: enable: {
        targetData.version = version;
        profiles.setupAssistant.managed.enable = enable;
      };
      result1 = tryEvalGetPlist (gen-config "13.0" true);
      result2 = tryEvalGetPlist (gen-config "14.0" true);
      result3 = tryEvalGetPlist (gen-config "13.0" false);
    in
    assert result1.success == false;
    assert result2.success == true;
    assert result3.success == true;
    pkgs.runCommand "can-gen-profile-if-ios-version-is-above-min" { } "touch $out";

  checks-max-ios-version =
    let
      gen-config = version: enable: {
        targetData.version = version;
        profiles.mdm = {
          enable = enable;
          ManagedAppleID = "string";
          IdentityCertificateUUID = "b57e9a8d-b89f-420a-922e-99775a23a4ac";
          Topic = "com.apple.mgmt.test";
          ServerURL = "https://example.com";
        };
      };
      result1 = tryEvalGetPlist (gen-config "18.0" true);
      result2 = tryEvalGetPlist (gen-config "17.0" true);
      result3 = tryEvalGetPlist (gen-config "18.0" false);
    in
    assert result1.success == false;
    assert result2.success == true;
    assert result3.success == true;
    pkgs.runCommand "can-gen-profile-if-ios-version-is-above-min" { } "touch $out";

  checks-supervised =
    let
      gen-config = isSupervised: enable: {
        targetData.isSupervised = isSupervised;
        profiles.setupAssistant.managed.enable = enable;
      };
      result1 = tryEvalGetPlist (gen-config false true);
      result2 = tryEvalGetPlist (gen-config true true);
      result3 = tryEvalGetPlist (gen-config false false);
    in
    assert result1.success == false;
    assert result2.success == true;
    assert result3.success == true;
    pkgs.runCommand "can-gen-profile-if-is-supervised-is-true" { } "touch $out";

  checks-support-through-array-values =
    let
      gen-config = version: {
        targetData.version = version;
        profiles.airplay = {
          enable = true;
          AllowList = [ { DeviceName = "DeviceNameValue"; } ];
        };
      };
      result1 = tryEvalGetPlist (gen-config "17.0");
      result2 = tryEvalGetPlist (gen-config "18.0");
    in
    assert result1.success == false;
    assert result2.success == true;
    pkgs.runCommand "checks-support-through-array-values" { } "touch $out";
}
