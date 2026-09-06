# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.security.pem";
  description = ''
    The payload that configures a PEM-formatted certificate.

    PEM-encoded certificate without private key. May contain root certificates.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.security.pem profile";
    "PayloadCertificateFileName" = mkProfileOpt {
      type = types.str;
      description = ''
        The file name of the enclosed certificate.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadContent" = mkProfileOpt {
      type = ios-config-utils.plistDataType;
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
