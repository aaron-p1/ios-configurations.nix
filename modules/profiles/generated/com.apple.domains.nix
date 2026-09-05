# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.domains profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.domains";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.domains";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "EmailDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of domains. Mail marks in red all email addresses
        that lack a suffix matching any of these strings.

        Available in iOS 8 and later and macOS 10.10 and later.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "WebDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of domains. The system considers URLs matching the
        patterns listed in this property managed.

        Available in iOS 9.3 and later.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "SafariPasswordAutoFillDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of domains. Users can only save passwords in Safari
        from URLs matching the patterns listed here. This property
        doesn't disable the autofill feature itself.

        Supervised devices or Shared iPads need this property to
        enable saving passwords in Safari.

        Available in iOS 9.3 and later.

        Requires: iOS >= 9.3; supervised device
      '';
      required = false;
    };
    "CrossSiteTrackingPreventionRelaxedDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of up to 10 strings. URLs matching the patterns
        listed here have relaxed enforcement of cross-site tracking
        prevention.

        Available in iOS 16.2 and later and macOS 13.1 and later.

        Requires: iOS >= 16.2; supervised device
      '';
      required = false;
    };
    "CrossSiteTrackingPreventionRelaxedApps" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of up to 10 strings representing app bundle-ids.
        Apps matching the bundle-ids listed here have relaxed
        enforcement of cross-site tracking prevention for the
        domains listed in
        `CrossSiteTrackingPreventionRelaxedDomains`.

        Available in iOS 18 and later and macOS 15 and later.

        Requires: iOS >= 18.0; supervised device
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "EmailDomains" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "WebDomains" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "SafariPasswordAutoFillDomains" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "CrossSiteTrackingPreventionRelaxedDomains" = {
      minIos = "16.2";
      maxIos = null;
      supervised = true;
    };
    "CrossSiteTrackingPreventionRelaxedApps" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
  };
}
