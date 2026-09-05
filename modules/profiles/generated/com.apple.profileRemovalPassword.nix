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
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.profileRemovalPassword";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
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
