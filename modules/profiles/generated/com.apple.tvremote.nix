# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.tvremote profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.tvremote";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.tvremote";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "AllowedTVs" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "TVDeviceID" = mkProfileOpt {
              type = types.str;
              description = ''
                The MAC address of an Apple TV device that the system
                permits this iOS device to control. Use the format
                `xx:xx:xx:xx:xx:xx`, which isn't case-sensitive.

                Requires: iOS >= 11.3; supervised device
              '';
              required = true;
            };
            "TVDeviceName" = mkProfileOpt {
              type = types.str;
              description = ''
                The name of an Apple TV device that the system permits this
                iOS device to control.

                Requires: iOS >= 15.0; supervised device
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        The array of valid Apple TV identifiers that the remote can
        connect to.

        Requires: iOS >= 11.3; supervised device
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "AllowedTVs" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "AllowedTVs"."*"."TVDeviceID" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "AllowedTVs"."*"."TVDeviceName" = {
      minIos = "15.0";
      maxIos = null;
      supervised = true;
    };
  };
}
