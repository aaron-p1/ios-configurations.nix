# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.profileRemovalPassword profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.profileRemovalPassword";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.profileRemovalPassword";
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
