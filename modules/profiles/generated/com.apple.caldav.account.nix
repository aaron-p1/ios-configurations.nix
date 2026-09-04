# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.caldav.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.caldav.account";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.caldav.account";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "CalDAVAccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the account.
      '';
      required = false;
    };
    "CalDAVHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The server's address.
      '';
      required = true;
    };
    "CalDAVUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name for logins. If this profile is part of a non-
        interactive install, the system requires this field.
      '';
      required = false;
    };
    "CalDAVPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's password. Only use this in encrypted profiles.
      '';
      required = false;
    };
    "CalDAVPrincipalURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The base URL to the user's calendar.
      '';
      required = false;
    };
    "CalDAVUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL.
      '';
      required = false;
    };
    "CalDAVPort" = mkProfileOpt {
      type = types.int;
      description = ''
        The server's port.
      '';
      required = false;
    };
    "VPNUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The VPNUUID of the per-app VPN the account uses for network
        communication. Available in iOS 14 and later.
      '';
      required = false;
    };
  };
  supportData = {
    enable = {
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
