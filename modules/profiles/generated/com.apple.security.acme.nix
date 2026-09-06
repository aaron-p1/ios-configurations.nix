# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures Automated Certificate Management Environment (ACME)
    settings.

    Use this payload to specify how the device requests a client certificate from an
    Automated Certificate Management Environment (ACME) server. Other payloads can
    reference the resulting client identity by the payload's `PayloadUUID`.

    First the device generates an asymmetric key pair based upon the `KeyType`,
    `KeySize`, and `HardwareBound` fields. Then the device communicates with the
    ACME server. It requests a new order using the `ClientIdentifier` as the
    `permanent-identifier`. The ACME server responds with a challenge type of
    `device-attest-01`. If `Attest` is `true` the device requests an attestation of
    the key and device properties. Then it replies to the challenge with a WebAuthn
    attestation statement, and this contains the attestation if the device obtained
    one. The device submits a certificate signing request matching the key and
    containing the `ClientIdentifier`, `Subject`, `SubjectAltName`, `UsageFlags`,
    and `ExtendedKeyUsage` fields. The ACME server issues a certificate, and the
    device stores the resulting identity.

    For details on the content of the attestation provided to the ACME server, see
    the documentation of the `DevicePropertiesAttestation` key in the
    `QueryResponses`response. In the attestation certificate the value of the
    freshness code OID is the SHA-256 hash of the `token` from the `device-
    attest-01` challenge.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.security.acme profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.security.acme";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.security.acme";
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
    "DirectoryURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The directory URL of the ACME server. The URL must use the
        https scheme.

        Requires: iOS >= 16.0
      '';
      required = true;
    };
    "ClientIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        A unique string identifying a specific device. The server
        may use this as an anti-replay code to prevent issuing
        multiple certificates. This identifier also indicates to the
        ACME server that the device has access to a valid client
        identifier issued by the enterprise infrastructure. This can
        help the ACME server determine whether to trust the device.
        Though this is a relatively weak indication because of the
        risk that an attacker can intercept the client identifier.

        Requires: iOS >= 16.0
      '';
      required = true;
    };
    "KeySize" = mkProfileOpt {
      type = types.int;
      description = ''
        The valid values for `KeySize` depend on the values of
        `KeyType` and `HardwareBound`. See those keys for specific
        requirements.

        Requires: iOS >= 16.0
      '';
      required = true;
    };
    "KeyType" = mkProfileOpt {
      type = (
        types.enum [
          "RSA"
          "ECSECPrimeRandom"
        ]
      );
      description = ''
        The type of key pair to generate. Allowed values:

        - `RSA`: Specifies an RSA key pair. RSA key pairs need to
        have a `KeySize` that's a multiple of 8 in the range of 1024
        through 4096 (inclusive), and `HardwareBound` needs to be
        `false`.
        - `ECSECPrimeRandom`: Specifies a key pair on the P-192,
        P-256, P-384, or P-521 curves as defined in FIPS Pub 186-4.
        `KeySize` defines the particular curve, which needs to be
        `192`, `256`, `384`, or `521`. Hardware bound keys only
        support values of `256` and `384`.

        > Note:
        > The key size is `521`, not `512`, even though the other
        key sizes are multiples of 64.

        Requires: iOS >= 16.0
      '';
      required = true;
    };
    "HardwareBound" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the private key isn't bound to the device.

        If `true`, the private key is bound to the device. The
        Secure Enclave generates the key pair, and the private key
        is cryptographically entangled with a system key. This
        prevents the system from exporting the private key.

        If `true`, `KeyType` must be `ECSECPrimeRandom` and
        `KeySize` must be 256 or 384.

        Setting this key to `true` is supported as of macOS 14 on
        Apple Silicon and Intel devices that have a T2 chip. Older
        macOS versions or other Mac devices require this key but it
        must have a value of `false`.

        Requires: iOS >= 16.0
      '';
      required = true;
    };
    "Subject" = mkProfileOpt {
      type = (types.listOf (types.listOf (types.listOf types.str)));
      description = ''
        The device requests this subject for the certificate that
        the ACME server issues. The ACME server may override or
        ignore this field in the certificate it issues.

        The representation of a X.500 name represented as an array
        of OID and value. For example, `/C=US/O=Apple
        Inc./CN=foo/1.2.5.3=bar` corresponds to:

        `[ [ ["C", "US"] ], [ ["O", "Apple Inc."] ], ..., [ [
        "1.2.5.3", "bar" ] ] ]`

        Dotted numbers can represent OIDs , with shortcuts for
        country (C), locality (L), state (ST), organization (O),
        organizational unit (OU), and common name (CN).

        Requires: iOS >= 16.0
      '';
      required = true;
    };
    "SubjectAltName" = mkProfileOpt {
      type = (
        utils.subopts {
          "rfc822Name" = mkProfileOpt {
            type = types.str;
            description = ''
              The RFC 822 (email address) string.

              Requires: iOS >= 16.0
            '';
            required = false;
          };
          "dNSName" = mkProfileOpt {
            type = types.str;
            description = ''
              The DNS name.

              Requires: iOS >= 16.0
            '';
            required = false;
          };
          "uniformResourceIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The Uniform Resource Identifier.

              Requires: iOS >= 16.0
            '';
            required = false;
          };
          "ntPrincipalName" = mkProfileOpt {
            type = types.str;
            description = ''
              The NT principal name. Use an other name OID set to
              `1.3.6.1.4.1.311.20.2.3`.

              Requires: iOS >= 16.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The Subject Alt Name that the device requests for the
        certificate that the ACME server issues. The ACME server may
        override or ignore this field in the certificate it issues.

        Requires: iOS >= 16.0
      '';
      required = false;
    };
    "UsageFlags" = mkProfileOpt {
      type = types.int;
      description = ''
        This value is a bit field.

        - Bit `0x01` indicates digital signature.
        - Bit `0x04` indicates encryption.

        The device requests this key for the certificate that the
        ACME server issues. The ACME server may override or ignore
        this field in the certificate it issues.

        Requires: iOS >= 16.0
      '';
      required = false;
    };
    "ExtendedKeyUsage" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        The value is an array of strings. Each string is an OID in
        dotted notation. For instance, `["1.3.6.1.5.5.7.3.2",
        "1.3.6.1.5.5.7.3.4"]` indicates client authentication and
        email protection.

        The device requests this field for the certificate that the
        ACME server issues. The ACME server may override or ignore
        this field in the certificate it issues.

        Requires: iOS >= 16.0
      '';
      required = false;
    };
    "Attest" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the device provides attestations that describe
        the device and the generated key to the ACME server. The
        server can use the attestations as strong evidence that the
        key is bound to the device, and that the device has
        properties listed in the attestation. The server can use
        that as part of a trust score to decide whether to issue the
        requested certificate.

        When `Attest` is `true`, `HardwareBound` also needs to be
        `true`.

        Setting this key to `true` is supported as of macOS 14.
        Older macOS versions require this key but it must have a
        value of `false`. See below for hardware requirements.

        Requires: iOS >= 16.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "DirectoryURL" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "ClientIdentifier" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "KeySize" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "KeyType" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "HardwareBound" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "Subject" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "SubjectAltName" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "SubjectAltName"."rfc822Name" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "SubjectAltName"."dNSName" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "SubjectAltName"."uniformResourceIdentifier" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "SubjectAltName"."ntPrincipalName" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "UsageFlags" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "ExtendedKeyUsage" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "Attest" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
  };
}
