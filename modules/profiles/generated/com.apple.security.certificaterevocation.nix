# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures certificate revocation checking.

    Policies that affect system-wide certificate revocation checking.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.security.certificaterevocation profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.security.certificaterevocation";
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
    "EnabledForCerts" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "Algorithm" = mkProfileOpt {
              type = (
                types.enum [
                  "sha256"
                ]
              );
              description = ''
                The algorithm must be `sha256`.

                Requires: iOS >= 14.2
              '';
              required = true;
            };
            "Hash" = mkProfileOpt {
              type = utils.plistDataType;
              description = ''
                The hash of the DER-encoding of the certificate's
                `subjectPublicKeyInfo`.

                The hash field requires the data (`subjectPublicKeyInfo`
                hash) in a specific format: a Base64 encoded (binary)
                SHA-256 hash of the certificate's public key.

                Requires: iOS >= 14.2
              '';
              required = true;
            };
          }
        )
      );
      description = ''
        An array of certificates that the system checks for
        revocation.

        Specifying a certificate authority (CA) enables revocation
        checking for all certificates chaining up to that CA.

        It's not necessary to specify trusted root certificates
        because they're implicitly specified. See
        [https://support.apple.com/en-
        us/HT209143](https://support.apple.com/en-us/HT209143) for
        the available trusted root certificates for Apple operating
        systems.

        Requires: iOS >= 14.2
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
    "EnabledForCerts" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
    "EnabledForCerts"."*"."Algorithm" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
    "EnabledForCerts"."*"."Hash" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
  };
}
