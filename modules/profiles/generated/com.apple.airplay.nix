# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkOption;
  inherit (utils) mkProfileOpt;

  type-id001 = types.listOf (
    types.submodule (
      { ... }: {
        options = {
          "DeviceID" = mkProfileOpt {
            type = types.str;
            description = ''
              The device ID of the AirPlay destination in the format
              `xx:xx:xx:xx:xx:xx`. This field isn't case-sensitive.
              The system limits the list of visible AirPlay
              destinations to devices that are present in the
              `AllowList` field of all installed AirPlay payloads.
              Specifying the same MACAddress more than once, whether
              in the same payload across different payloads, results
              in undefined behavior.  As of tvOS 18, `DeviceID` isn't
              supported.
            '';
            required = false;
          };
          "DeviceName" = mkProfileOpt {
            type = types.str;
            description = ''
              The name of the AirPlay device.  The system limits the list of
              visible AirPlay destinations to devices that are present
              in the `AllowList` field of all installed AirPlay
              payloads.
            '';
            required = false;
          };
        };
      }
    )
  );
in
{
  options = {
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
      type = type-id001;
      description = ''
        If present, only AirPlay destinations in this list are available to the
        device. This allow list applies to supervised devices.
      '';
      required = false;
    };
    "Passwords" = mkProfileOpt {
      type = types.listOf (
        types.submodule (
          { ... }: {
            options = {
              "DeviceName" = mkProfileOpt {
                type = types.str;
                description = ''
                  The name of the AirPlay destination; used in iOS, and
                  available in macOS 15 and later.
                '';
                required = false;
              };
              "Password" = mkProfileOpt {
                type = types.str;
                description = ''
                  The password for the AirPlay destination.
                '';
                required = true;
              };
            };
          }
        )
      );
      description = ''
        If present, sets passwords for known AirPlay destinations. Using
        multiple entries for the same destination, whether within the
        same payload or across multiple installed payloads, is an error
        and results in undefined behavior.
      '';
      required = false;
    };
    "Whitelist" = mkProfileOpt {
      type = type-id001;
      description = ''
        Use `AllowList` instead. This key is deprecated in iOS 14.5 and macOS
        11.3.
      '';
      required = false;
    };
  };
}
