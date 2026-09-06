# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a Lock Screen message.

    Allows admins to specify optional text displayed on the Login Window and Lock
    Screen (i.e. a footnote and Asset Tag Information).

    This payload allows administrators to specify optional text displayed in the
    Login Window and Lock Screen (for example, an "If Lost, Return To" message and
    asset tag information). There can only be one Lock Screen payload.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.shareddeviceconfiguration profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.shareddeviceconfiguration";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      description = "The payload identifier for this profile";
    };
    PayloadUUID = mkOption {
      type = types.str;
      description = "The payload UUID for this profile";
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
      description = "The payload version for this profile";
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
