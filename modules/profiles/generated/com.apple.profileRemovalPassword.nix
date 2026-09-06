# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.profileRemovalPassword";
  description = ''
    The payload that configures profile removal.

    This payload provides a password to allow users to remove a locked configuration
    profile from the device. If this payload is present and has a password value
    set, the device asks for the password when the user taps a profile's Remove
    button. This system encrypts the payload with the rest of the profile.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.profileRemovalPassword profile";
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
