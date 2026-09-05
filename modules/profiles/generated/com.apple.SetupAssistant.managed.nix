# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.SetupAssistant.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.SetupAssistant.managed";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.SetupAssistant.managed";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "SkipSetupItems" = mkProfileOpt {
      type = types.listOf types.str;
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
