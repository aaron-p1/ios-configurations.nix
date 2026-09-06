# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a Calendar account.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.caldav.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.caldav.account";
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
    "CalDAVAccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the account.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CalDAVHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The server's address.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "CalDAVUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name for logins. If this profile is part of a non-
        interactive install, the system requires this field.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CalDAVPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's password. Only use this in encrypted profiles.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CalDAVPrincipalURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The base URL to the user's calendar.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CalDAVUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CalDAVPort" = mkProfileOpt {
      type = types.int;
      description = ''
        The server's port.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "VPNUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The VPNUUID of the per-app VPN the account uses for network
        communication. Available in iOS 14 and later.

        Requires: iOS >= 14.0
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
    "CalDAVAccountDescription" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CalDAVHostName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CalDAVUsername" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CalDAVPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CalDAVPrincipalURL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CalDAVUseSSL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CalDAVPort" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPNUUID" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
  };
}
