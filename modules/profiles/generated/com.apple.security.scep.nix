# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures Simple Certificate Enrollment Protocol (SCEP)
    settings.

    A SCEP payload automates the request of a client certificate from a SCEP server,
    as described in [Over-the-Air Profile Delivery and Configuration](https://develo
    per.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/iPhone
    OTAConfiguration/Introduction/Introduction.html).
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.security.scep profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.security.scep";
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
    "PayloadContent" = mkProfileOpt {
      type = (
        utils.subopts {
          "URL" = mkProfileOpt {
            type = types.str;
            description = ''
              The SCEP URL. See Over-the-Air Profile Delivery and
              Configuration for more information about SCEP.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
          "Name" = mkProfileOpt {
            type = types.str;
            description = ''
              A string that's understood by the SCEP server; for example,
              a domain name like example.org. If a certificate authority
              has multiple CA certificates, this field can be used to
              distinguish which is required.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Subject" = mkProfileOpt {
            type = (types.listOf (types.listOf (types.listOf types.str)));
            description = ''
              The representation of an X.500 name as an array of OID and
              value.

              For example, `/C=US/O=Apple Inc./CN=foo/1.2.5.3=bar`
              translates to `[ [ ["C", "US"] ], [ ["O", "Apple Inc."] ],
              …, [ [ "1.2.5.3", "bar" ] ] ]`.

              OIDs can be represented as dotted numbers, with shortcuts
              for country (C), locality (L), state (ST), organization (O),
              organizational unit (OU), and common name (CN).

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Challenge" = mkProfileOpt {
            type = types.str;
            description = ''
              A preshared secret.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Keysize" = mkProfileOpt {
            type = (
              types.enum [
                1024
                2048
                4096
              ]
            );
            description = ''
              The key size, in bits.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Key Type" = mkProfileOpt {
            type = types.str;
            description = ''
              Always `RSA`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Key Usage" = mkProfileOpt {
            type = types.int;
            description = ''
              A bitmask indicating the use of the key. Possible values:

              - `1`: Signing
              - `4`: Encryption

              Some certificate authorities, such as Windows CA, support
              only encryption or signing, but not both at the same time.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "CAFingerprint" = mkProfileOpt {
            type = utils.plistDataType;
            description = ''
              The fingerprint of the Certificate Authority certificate.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Retries" = mkProfileOpt {
            type = types.int;
            description = ''
              The number of times the device should retry if the server
              sends a PENDING response.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "RetryDelay" = mkProfileOpt {
            type = types.int;
            description = ''
              The number of seconds to wait between subsequent retries.
              The first retry is attempted without this delay.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "SubjectAltName" = mkProfileOpt {
            type = (
              utils.subopts {
                "rfc822Name" = mkProfileOpt {
                  type = types.str;
                  description = ''
                    The RFC 822 (email address) string.

                    Requires: iOS >= 4.0
                  '';
                  required = false;
                };
                "dNSName" = mkProfileOpt {
                  type = types.str;
                  description = ''
                    The DNS name.

                    Requires: iOS >= 4.0
                  '';
                  required = false;
                };
                "uniformResourceIdentifier" = mkProfileOpt {
                  type = types.str;
                  description = ''
                    The Uniform Resource Identifier.

                    Requires: iOS >= 4.0
                  '';
                  required = false;
                };
                "ntPrincipalName" = mkProfileOpt {
                  type = types.str;
                  description = ''
                    The NT principal name. Use an other name OID set to
                    `1.3.6.1.4.1.311.20.2.3`.

                    Requires: iOS >= 4.0
                  '';
                  required = false;
                };
              }
            );
            description = ''
              The SCEP payload can specify an optional `SubjectAltName`
              dictionary that provides values required by the CA for
              issuing a certificate. You can specify a single string or an
              array of strings for each key. The values you specify depend
              on the CA you're using, but might include DNS name, URL, or
              email values. For an example, see Sample Configuration
              Profile or Over-the-Air Profile Delivery and Configuration.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "KeyIsExtractable" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `false`, the system disables exporting the private key
              from the keychain.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AllowAllAppsAccess" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, all apps have access to the private key.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        A dictionary containing the SCEP information.

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
    "PayloadContent" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."URL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."Name" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."Subject" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."Challenge" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."Keysize" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."Key Type" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."Key Usage" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."CAFingerprint" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."Retries" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."RetryDelay" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."SubjectAltName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."SubjectAltName"."rfc822Name" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."SubjectAltName"."dNSName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."SubjectAltName"."uniformResourceIdentifier" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."SubjectAltName"."ntPrincipalName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."KeyIsExtractable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent"."AllowAllAppsAccess" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
  };
}
