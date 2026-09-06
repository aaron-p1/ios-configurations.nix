# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a PEM-formatted certificate.

    PEM-encoded certificate without private key. May contain root certificates.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.security.pem profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.security.pem";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.security.pem";
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
