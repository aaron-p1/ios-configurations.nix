# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.shareddeviceconfiguration profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.shareddeviceconfiguration";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.shareddeviceconfiguration";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "AssetTagInformation" = mkProfileOpt {
      type = types.str;
      description = ''
        The asset tag information for the device, displayed in the
        Login Window and Lock Screen.

        Requires: iOS >= 9.3; supervised device
      '';
      required = false;
    };
    "IfLostReturnToMessage" = mkProfileOpt {
      type = types.str;
      description = ''
        Deprecated. Use `LockScreenFootnote` instead.

        Requires: iOS >= 9.3; supervised device
        Deprecated in iOS 9.3.1
      '';
      required = false;
    };
    "LockScreenFootnote" = mkProfileOpt {
      type = types.str;
      description = ''
        The footnote displayed in the Login Window and Lock Screen.

        Requires: iOS >= 9.3.1; supervised device
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "AssetTagInformation" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "IfLostReturnToMessage" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "LockScreenFootnote" = {
      minIos = "9.3.1";
      maxIos = null;
      supervised = true;
    };
  };
}
