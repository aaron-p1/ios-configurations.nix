# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that applies a set of declarations to the device through the
    Settings app.

    This profile applies a set of declarations to the device. Users use this profile
    to install declarations without requiring an MDM enrollment. A device management
    server can't install a configuration profile containing this payload type.
    Device management servers need to use declarative device management to install
    declarations.

    > Important:
    > When a user installs the profile, the device only applies configuration
    declarations that allow a "local" enrollment. Consult the documentation for each
    configuration type to see if you can use it.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.declarations profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.declarations";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.declarations";
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
    "Declarations" = mkProfileOpt {
      type = (types.listOf utils.plistDataType);
      description = ''
        The set of declarations to apply. The array items are
        Base64-encoded data representations of the declaration JSON
        data.

        Requires: iOS >= 17.0
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Declarations" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
  };
}
