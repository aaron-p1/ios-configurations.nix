# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.security.pem profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.security.pem";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.security.pem";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "PayloadCertificateFileName" = mkProfileOpt {
      type = types.str;
      description = ''
        The file name of the enclosed certificate.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadContent" = mkProfileOpt {
      type = utils.plistDataType;
      description = ''
        The binary representation of the payload, encoded in Base64.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadCertificateFileName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
  };
}
