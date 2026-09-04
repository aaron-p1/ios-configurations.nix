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
  can-gen-profile-if-ios-version-is-null =
    let
      config = {
        targetData.version = null;
        profiles.setupAssistant.managed.enable = true;
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-profile-if-ios-version-is-null" { } "touch $out";

  can-gen-profile-if-is-supervised-is-null =
    let
      config = {
        targetData.isSupervised = null;
        profiles.setupAssistant.managed.enable = true;
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-profile-if-is-supervised-is-null" { } "touch $out";

  can-gen-profile-if-ios-version-is-above-min =
    let
      config = {
        targetData.version = "14.0";
        profiles.setupAssistant.managed.enable = true;
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-profile-if-ios-version-is-above-min" { } "touch $out";

  does-not-gen-profile-if-ios-version-is-below-min =
    let
      config = {
        targetData.version = "13.0";
        profiles.setupAssistant.managed.enable = true;
      };
      result = tryEval (eval { inherit config; }).config.profiles.plist;
    in
    assert !result.success;
    pkgs.runCommand "does-not-gen-profile-if-ios-version-is-below-min" { } "touch $out";

  can-gen-profile-if-ios-version-is-below-min-but-not-enabled =
    let
      config = {
        targetData.version = "13.0";
        profiles.setupAssistant.managed.enable = false;
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert !hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-profile-if-ios-version-is-below-min-but-not-enabled" { } "touch $out";

  # TODO: test maxIos version

  can-gen-profile-if-is-supervised-is-true =
    let
      config = {
        targetData.isSupervised = true;
        profiles.setupAssistant.managed.enable = true;
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-profile-if-is-supervised-is-true" { } "touch $out";

  does-not-gen-profile-if-is-supervised-is-false =
    let
      config = {
        targetData.isSupervised = false;
        profiles.setupAssistant.managed.enable = true;
      };
      result = tryEval (eval { inherit config; }).config.profiles.plist;
    in
    assert !result.success;
    pkgs.runCommand "does-not-gen-profile-if-is-supervised-is-false" { } "touch $out";

  checks-support-through-array-values-if-ok =
    let
      config = {
        targetData.version = "18.0";
        profiles.airplay = {
          enable = true;
          AllowList = [ { DeviceName = "DeviceNameValue"; } ];
        };
      };
      plist = (eval { inherit config; }).config.profiles.plist;
    in
    assert hasInfix "airplay" plist;
    pkgs.runCommand "checks-support-through-array-values" { } "touch $out";

  checks-support-through-array-values-if-not-ok =
    let
      config = {
        targetData.version = "16.0";
        profiles.airplay = {
          enable = true;
          AllowList = [ { DeviceName = "DeviceNameValue"; } ];
        };
      };
      result = tryEval (eval { inherit config; }).config.profiles.plist;
    in
    assert !result.success;
    pkgs.runCommand "checks-support-through-array-values-if-not-ok" { } "touch $out";
}
