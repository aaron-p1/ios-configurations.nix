# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.declarations profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.declarations";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.declarations";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "Declarations" = mkProfileOpt {
      type = types.listOf utils.plistDataType;
      description = ''
        The set of declarations to apply. The array items are
        Base64-encoded data representations of the declaration JSON
        data.
      '';
      required = true;
    };
  };
  supportData = {
    enable = {
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
