# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.font profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.font";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.font";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "Name" = mkProfileOpt {
      type = types.str;
      description = ''
        The user-visible name for the font. This field is replaced
        by the actual name of the font after installation. Each
        payload must contain exactly one font file in trueType
        (.ttf) or OpenType (.otf) format. Collection formats (.ttc
        or .otc) are not supported.

        Fonts are identified by their embedded PostScript names. Two
        fonts with the same PostScript name are considered to be the
        same font even if their contents differ. Installing two
        different fonts with the same PostScript name isn't
        supported, and the resulting behavior is undefined.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "Font" = mkProfileOpt {
      type = utils.plistDataType;
      description = ''
        The contents of the font file.

        Requires: iOS >= 7.0
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Name" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Font" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
  };
}
