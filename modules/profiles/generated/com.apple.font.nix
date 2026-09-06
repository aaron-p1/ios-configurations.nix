# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.font";
  description = ''
    The payload that configures fonts.

    Each payload may contain one font file. Font files may be in TrueType (.ttf) or
    OpenType (.otf) file format. Collection types (.ttc or .otc) formats are not
    supported.
    Fonts are uniquely identified internally by their embedded PostScript name. Two
    fonts with the same PostScript name will be considered the same font, even if
    their contents differ. Installing two different fonts with the same PostScript
    name is not supported, and it is undefined which font will remain installed.
    Supported on the Shared iPad user channel as of iPadOS 18.0. Earlier versions of
    iPadOS erroneously accepted the Font payload on the device channel but installed
    it for the currently logged in user.

    In iPadOS 18 and later, the font profile is available on the user channel for
    Shared iPads.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.font profile";
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
      type = ios-config-utils.plistDataType;
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
