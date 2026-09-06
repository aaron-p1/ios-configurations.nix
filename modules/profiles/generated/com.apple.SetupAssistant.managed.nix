# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.SetupAssistant.managed";
  description = ''
    The payload that configures Setup Assistant settings.

    On macOS, this payload can specify Setup Assistant options for either the system
    or particular users.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.SetupAssistant.managed profile";
    "SkipSetupItems" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of strings that describe the setup items to skip.
        `SkipKeys` provides a list of valid strings and their
        meanings. Available in iOS 14 and later, and macOS 15 and
        later.

        Requires: iOS >= 14.0; supervised device
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "14.0";
      maxIos = null;
      supervised = true;
    };
    "SkipSetupItems" = {
      minIos = "14.0";
      maxIos = null;
      supervised = true;
    };
  };
}
