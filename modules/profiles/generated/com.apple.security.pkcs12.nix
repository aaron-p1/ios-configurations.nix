# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a PKCS #12-formatted certificate.

    Password-protected identity certificate. Only one certificate may be included.

    > Warning:
    > The system obfuscates the profile but doesn't encrypt it, so it's possible to
    intercept the profile and extract the password and identity.

    It's recommended to omit the password in the profile, or do one of the following
    instead:

    - Securely deliver the profile to authorized users only, such as through MDM.
    - Encrypt the profile so that only authorized devices can decrypt it.
    - Use `SCEP` or `ACMECertificate` to provision the identity.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.security.pkcs12 profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.security.pkcs12";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
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
    "Password" = mkProfileOpt {
      type = types.str;
      description = ''
        The password to the identity.

        Requires: iOS >= 4.0
      '';
      required = false;
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
    "Password" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
  };
}
