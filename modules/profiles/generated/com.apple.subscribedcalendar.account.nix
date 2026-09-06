# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures subscribed calendars.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.subscribedcalendar.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.subscribedcalendar.account";
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
    "SubCalAccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the account.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "SubCalAccountHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The server's address.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "SubCalAccountUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's user name.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "SubCalAccountPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's password.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "SubCalAccountUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL.

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
    "SubCalAccountDescription" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SubCalAccountHostName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SubCalAccountUsername" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SubCalAccountPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SubCalAccountUseSSL" = {
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
