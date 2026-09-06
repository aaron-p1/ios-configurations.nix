# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures DNS proxies.

    As of iOS 15.0 this payload can be installed on unsupervised devices via MDM and
    can only be installed via MDM. As of iOS 16.0, this can be installed on user
    enrollments via MDM if DNSProxyUUID is specified.

    Beginning with iOS 15, this profile is unsupervised and needs to be installed
    through MDM.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.dnsProxy.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.dnsProxy.managed";
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
    "AppBundleIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        The bundle identifier of the app containing the DNS proxy
        network extension.

        Requires: iOS >= 11.0
      '';
      required = true;
    };
    "ProviderBundleIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        The bundle identifier of the DNS proxy network extension to
        use. Declaring the bundle identifier is useful for apps that
        contain more than one DNS proxy extension.

        Requires: iOS >= 11.0
      '';
      required = false;
    };
    "ProviderConfiguration" = mkProfileOpt {
      type = (types.attrsOf types.anything);
      description = ''
        The dictionary of vendor-specific configuration items.

        Requires: iOS >= 11.0
      '';
      required = false;
    };
    "DNSProxyUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        A globally unique identifier for this DNS proxy
        configuration. The proxy processes DNS lookups traffic for
        managed apps with the same `DNSProxyUUID` in their app
        attributes. This key is required for user enrollment.

        Requires: iOS >= 16.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "AppBundleIdentifier" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "ProviderBundleIdentifier" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "ProviderConfiguration" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "DNSProxyUUID" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
  };
}
