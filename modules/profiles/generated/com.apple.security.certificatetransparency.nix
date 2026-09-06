# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.security.certificatetransparency";
  description = ''
    The payload that configures certificate transparency enforcement.

    Policies that affect system-wide certificate transparency enforcement.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.security.certificatetransparency profile";
    "DisabledForCerts" = mkProfileOpt {
      type = (
        types.listOf (
          ios-config-utils.subopts {
            "Algorithm" = mkProfileOpt {
              type = (
                types.enum [
                  "sha256"
                ]
              );
              description = ''
                The algorithm must be `sha256`.

                Requires: iOS >= 12.1.1
              '';
              required = true;
            };
            "Hash" = mkProfileOpt {
              type = ios-config-utils.plistDataType;
              description = ''
                The hash of the DER-encoding of the certificate's
                `subjectPublicKeyInfo`.

                The hash field requires the data (`subjectPublicKeyInfo`
                hash) in a specific format: a Base64 encoded (binary)
                SHA-256 hash of the certificate's public key.

                Requires: iOS >= 12.1.1
              '';
              required = true;
            };
          }
        )
      );
      description = ''
        An array of certificates for which certificate transparency
        is disabled. One of the following conditions needs to be met
        to disable certificate transparency enforcement when this
        policy is set:

        - The hash is of the server certificate's
        `subjectPublicKeyInfo`.
        - The hash is of a `subjectPublicKeyInfo` that appears in a
        CA certificate in the certificate chain; the CA certificate
        is constrained through the X.509v3 `nameConstraints`
        extension. One or more `directoryName` `nameConstraints` are
        present in the `permittedSubtrees`, and the `directoryName`
        contains an `organizationName` attribute.
        - The hash is of a `subjectPublicKeyInfo` that appears in a
        CA certificate in the certificate chain. The CA certificate
        has one or more `organizationName` attributes in the
        certificate `Subject`, and the server's certificate contains
        the same number of `organizationName` attributes, in the
        same order, and with byte-for-byte identical values.

        Requires: iOS >= 12.1.1
      '';
      required = false;
    };
    "DisabledForDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of strings that represent the domains to exclude
        from certificate transparency enforcement. The system
        supports using a leading period (`.`) to signify subdomains.
        However, the system doesn't support wildcards. If you
        include a leading period, the domain can't be a top-level
        domain, such as `.com` and `.co.uk`.

        Requires: iOS >= 12.1.1
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "12.1.1";
      maxIos = null;
      supervised = false;
    };
    "DisabledForCerts" = {
      minIos = "12.1.1";
      maxIos = null;
      supervised = false;
    };
    "DisabledForCerts"."*"."Algorithm" = {
      minIos = "12.1.1";
      maxIos = null;
      supervised = false;
    };
    "DisabledForCerts"."*"."Hash" = {
      minIos = "12.1.1";
      maxIos = null;
      supervised = false;
    };
    "DisabledForDomains" = {
      minIos = "12.1.1";
      maxIos = null;
      supervised = false;
    };
  };
}
