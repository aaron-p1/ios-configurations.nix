# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.carddav.account";
  description = ''
    The payload that configures a Contacts account.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.carddav.account profile";
    "CardDAVAccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the account.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CardDAVHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The server's address.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "CardDAVUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name for logins.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CardDAVPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's password. Only use this in encrypted profiles.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CardDAVPrincipalURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The base URL to the user's address book.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CardDAVUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CardDAVPort" = mkProfileOpt {
      type = types.int;
      description = ''
        The server's port.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CommunicationServiceRules" = mkProfileOpt {
      type = (
        ios-config-utils.subopts {
          "DefaultServiceHandlers" = mkProfileOpt {
            type = (
              ios-config-utils.subopts {
                "AudioCall" = mkProfileOpt {
                  type = types.str;
                  description = ''
                    The bundle identifier for the default application that
                    handles audio calls to contacts from this account.

                    Requires: iOS >= 10.0
                  '';
                  required = false;
                };
              }
            );
            description = ''
              A dictionary of service handlers for contacts from this
              account.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
        }
      );
      description = ''
        An array of communication service rules for this account.

        Requires: iOS >= 10.0
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
    "CardDAVAccountDescription" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CardDAVHostName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CardDAVUsername" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CardDAVPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CardDAVPrincipalURL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CardDAVUseSSL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CardDAVPort" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CommunicationServiceRules" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "CommunicationServiceRules"."DefaultServiceHandlers" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "CommunicationServiceRules"."DefaultServiceHandlers"."AudioCall" = {
      minIos = "10.0";
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
