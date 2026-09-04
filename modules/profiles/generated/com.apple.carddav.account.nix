# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.carddav.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.carddav.account";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.carddav.account";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "CardDAVAccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the account.
      '';
      required = false;
    };
    "CardDAVHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The server's address.
      '';
      required = true;
    };
    "CardDAVUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name for logins.
      '';
      required = false;
    };
    "CardDAVPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's password. Only use this in encrypted profiles.
      '';
      required = false;
    };
    "CardDAVPrincipalURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The base URL to the user's address book.
      '';
      required = false;
    };
    "CardDAVUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL.
      '';
      required = false;
    };
    "CardDAVPort" = mkProfileOpt {
      type = types.int;
      description = ''
        The server's port.
      '';
      required = false;
    };
    "CommunicationServiceRules" = mkProfileOpt {
      type = (
        types.submodule (
          { ... }: {
            options = {
              "DefaultServiceHandlers" = mkProfileOpt {
                type = (
                  types.submodule (
                    { ... }: {
                      options = {
                        "AudioCall" = mkProfileOpt {
                          type = types.str;
                          description = ''
                            The bundle identifier for the default application that
                            handles audio calls to contacts from this account.
                          '';
                          required = false;
                        };
                      };
                    }
                  )
                );
                description = ''
                  A dictionary of service handlers for contacts from this
                  account.
                '';
                required = false;
              };
            };
          }
        )
      );
      description = ''
        An array of communication service rules for this account.
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
