# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;

  type-id001 =
    _:
    types.listOf (
      utils.subopts {
        "DeviceID" = mkProfileOpt {
          type = (types.strMatching "^([0-9A-Fa-f]{2}:){5}([0-9A-Fa-f]{2})$");
          description = ''
            The device ID of the AirPlay destination in the format
            `xx:xx:xx:xx:xx:xx`. This field isn't case-sensitive.

            The system limits the list of visible AirPlay destinations
            to devices that are present in the `AllowList` field of all
            installed AirPlay payloads.

            Specifying the same MACAddress more than once, whether in
            the same payload across different payloads, results in
            undefined behavior.

            As of tvOS 18, `DeviceID` isn't supported.

            Requires: iOS >= 7.0; supervised device
            Deprecated in iOS 18.0
          '';
          required = false;
        };
        "DeviceName" = mkProfileOpt {
          type = types.str;
          description = ''
            The name of the AirPlay device.

            The system limits the list of visible AirPlay destinations
            to devices that are present in the `AllowList` field of all
            installed AirPlay payloads.

            Requires: iOS >= 18.0; supervised device
          '';
          required = false;
        };
      }
    );

in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.airplay profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.airplay";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.airplay";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "AllowList" = mkProfileOpt {
      type = (type-id001 { });
      description = ''
        If present, only AirPlay destinations in this list are
        available to the device. This allow list applies to
        supervised devices.

        Requires: iOS >= 14.5; supervised device
      '';
      required = false;
    };
    "Passwords" = mkProfileOpt {
      type = types.listOf (
        utils.subopts {
          "DeviceName" = mkProfileOpt {
            type = types.str;
            description = ''
              The name of the AirPlay destination; used in iOS, and
              available in macOS 15 and later.

              Requires: iOS >= 7.0
            '';
            required = false;
          };
          "Password" = mkProfileOpt {
            type = types.str;
            description = ''
              The password for the AirPlay destination.

              Requires: iOS >= 7.0
            '';
            required = true;
          };
        }
      );
      description = ''
        If present, sets passwords for known AirPlay destinations.
        Using multiple entries for the same destination, whether
        within the same payload or across multiple installed
        payloads, is an error and results in undefined behavior.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "Whitelist" = mkProfileOpt {
      type = (type-id001 { });
      description = ''
        Use `AllowList` instead. This key is deprecated in iOS 14.5
        and macOS 11.3.

        Requires: iOS >= 7.0; supervised device
        Deprecated in iOS 14.5
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AllowList" = {
      minIos = "14.5";
      maxIos = null;
      supervised = true;
    };
    "AllowList"."*"."DeviceID" = {
      minIos = "14.5";
      maxIos = null;
      supervised = true;
    };
    "AllowList"."*"."DeviceName" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "Passwords" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Passwords"."*"."DeviceName" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Passwords"."*"."Password" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Whitelist" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "Whitelist"."*"."DeviceID" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "Whitelist"."*"."DeviceName" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
  };
}
