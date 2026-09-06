# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures single sign-on (SSO).

    Deprecated in iOS 26. Use the `ExtensibleSingleSignOn` payload instead.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.sso profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.sso";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.sso";
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
    "Name" = mkProfileOpt {
      type = types.str;
      description = ''
        The human-readable name for the account.

        Requires: iOS >= 7.0
        Deprecated in iOS 26.0
      '';
      required = true;
    };
    "Kerberos" = mkProfileOpt {
      type = (
        utils.subopts {
          "PrincipalName" = mkProfileOpt {
            type = types.str;
            description = ''
              The principal name. If not provided, the system prompts the
              user for one during profile installation. Required for MDM
              installation.

              Requires: iOS >= 7.0
              Deprecated in iOS 26.0
            '';
            required = false;
          };
          "PayloadCertificateUUID" = mkProfileOpt {
            type = types.str;
            description = ''
              The `PayloadUUID` of an identity certificate payload that
              the system can use to renew the Kerberos credential without
              user interaction. Set the payload type to either
              `com.apple.security.pkcs12` or `com.apple.security.scep` in
              the certificate payload. The configuration file needs to
              contain both the SSO payload and the identity certificate
              payload.

              Requires: iOS >= 8.0
              Deprecated in iOS 26.0
            '';
            required = false;
          };
          "Realm" = mkProfileOpt {
            type = types.str;
            description = ''
              The properly capitalized realm name.

              Requires: iOS >= 7.0
              Deprecated in iOS 26.0
            '';
            required = true;
          };
          "URLPrefixMatches" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              The list of URL prefixes to match in order to use this
              account for Kerberos authentication over HTTP. If this key
              is missing, the system makes the account eligible to match
              all `http://` and `https://` URLs.

              Begin the URL matching patterns with either `http://` or
              `https://`. The system performs a simple string match, so
              the URL prefix `http://www.apple.com/` doesn't match
              `http://www.apple.com:80/`. However, if a matching pattern
              doesn't end in `/`, the system automatically append a `/` to
              it.

              Requires: iOS >= 7.0
              Deprecated in iOS 26.0
            '';
            required = false;
          };
          "AppIdentifierMatches" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              The list of app identifiers that the system allows to use
              this login. If this field missing, the system matches all
              app identifiers with this login.

              Don't set an empty array. The array needs to contain strings
              that match App Bundle IDs. These strings can be exact
              matches such as `com.mycompany.myapp`, or they may specify a
              prefix match on the Bundle ID by using the `*` wildcard
              character. The wildcard character needs to appear after a
              period (`.`), and may only appear once, at the end of the
              string, for example, `com.mycompany.*`. When you provide a
              wildcard, the system grants access to the account to any app
              with a Bundle ID that begins with the prefix.

              Requires: iOS >= 7.0
              Deprecated in iOS 26.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The Kerberos dictionary.

        Requires: iOS >= 7.0
        Deprecated in iOS 26.0
      '';
      required = false;
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
    "Kerberos" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Kerberos"."PrincipalName" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Kerberos"."PayloadCertificateUUID" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "Kerberos"."Realm" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Kerberos"."URLPrefixMatches" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Kerberos"."AppIdentifierMatches" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
  };
}
