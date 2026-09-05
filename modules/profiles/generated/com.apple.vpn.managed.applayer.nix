# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.vpn.managed.applayer profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.vpn.managed.applayer";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.vpn.managed.applayer";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "VPNUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        A globally unique identifier for this VPN configuration.

        Requires: iOS >= 7.0
      '';
      required = true;
    };
    "CellularSliceUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        A string representing the data network name (DNN) or app
        category identifying a Cellular Slice. The device forces the
        VPN tunnel to use the specified Cellular Slice.

        Requires: iOS >= 18.0
      '';
      required = false;
    };
    "SafariDomains" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        An array with entries that must each specify a domain that
        triggers the VPN connection in Safari. Each entry is in the
        format `www.apple.com`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "MailDomains" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        An array with entries that must each specify a domain that
        triggers this VPN connection in Mail. Each entry is in the
        format `www.apple.com`.

        This property is deprecated in iOS 13.4 and later; use the
        `VPNUUID` property of the `Mail` or `ExchangeActiveSync`
        payload instead.

        Requires: iOS >= 13.0
        Deprecated in iOS 13.4
      '';
      required = false;
    };
    "CalendarDomains" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        An array with entries that must each specify a domain that
        triggers this VPN connection in Calendar. Each entry is in
        the format `www.apple.com`.

        This property is deprecated in iOS 13.4 and later; use the
        `VPNUUID` property of the `CalDAV` payload instead.

        Requires: iOS >= 13.0
        Deprecated in iOS 13.4
      '';
      required = false;
    };
    "ContactsDomains" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        An array with entries that must each specify a domain that
        triggers this VPN connection in Contacts. Each entry is in
        the format `www.apple.com`.

        This property is deprecated in iOS 13.4 and later; use the
        `VPNUUID` property of the `CardDAV` payload instead.

        Requires: iOS >= 13.0
        Deprecated in iOS 13.4
      '';
      required = false;
    };
    "AssociatedDomains" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        An array with entries that must each specify a domain that
        triggers this VPN. The domains must also be part of the
        `apple-app-site-association` file, as described in
        `Supporting associated domains`.

        Available in iOS 14 and later, and macOS 11 and later.

        Requires: iOS >= 14.0
      '';
      required = false;
    };
    "ExcludedDomains" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        An array with entries that each specify a domain that
        doesn't trigger this VPN for connections to the domain.

        Available in iOS 14 and later, and macOS 11 and later.

        Requires: iOS >= 14.0
      '';
      required = false;
    };
    "OnDemandMatchAppEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, automatically connects the VPN when associated
        apps for this per-app VPN service initiate network
        communication. Otherwise, the user must initiate the
        connection manually before those apps can initiate network
        communication. If this key isn't present, the value of the
        `OnDemandEnabled` key determines the status of per-app VPN
        On Demand.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "SMBDomains" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        An array of SMB domains that's accessible through this VPN
        connection.

        Available in iOS 13 and later.

        Requires: iOS >= 13.0
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
    "VPNUUID" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "CellularSliceUUID" = {
      minIos = "18.0";
      maxIos = null;
      supervised = false;
    };
    "SafariDomains" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "MailDomains" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "CalendarDomains" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ContactsDomains" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "AssociatedDomains" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "ExcludedDomains" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandMatchAppEnabled" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "SMBDomains" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
  };
}
