# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures profile removal.

    This payload provides a password to allow users to remove a locked configuration
    profile from the device. If this payload is present and has a password value
    set, the device asks for the password when the user taps a profile's Remove
    button. This system encrypts the payload with the rest of the profile.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.profileRemovalPassword profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.profileRemovalPassword";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "ios-configurations.profileRemovalPassword";
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
    "RemovalPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The password to allow removing the profile.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "RemovalPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
  };
}
