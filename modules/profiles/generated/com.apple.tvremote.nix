# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures the Apple TV remote.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.tvremote profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.tvremote";
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
    "AllowedTVs" = mkProfileOpt {
      type = (
        types.listOf (
          ios-config-utils.subopts {
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
