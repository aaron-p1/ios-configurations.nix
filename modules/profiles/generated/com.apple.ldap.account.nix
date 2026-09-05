# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.ldap.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.ldap.account";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.ldap.account";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "LDAPAccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the account.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "LDAPAccountHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The server's address.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "LDAPAccountUserName" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's user name.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "LDAPAccountPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's password. Only use this in encrypted profiles.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "LDAPAccountUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "LDAPSearchSettings" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "LDAPSearchSettingDescription" = mkProfileOpt {
              type = types.str;
              description = ''
                The description of this search setting.

                Requires: iOS >= 4.0
              '';
              required = false;
            };
            "LDAPSearchSettingSearchBase" = mkProfileOpt {
              type = types.str;
              description = ''
                The path to the node where a search should start.

                Requires: iOS >= 4.0
              '';
              required = true;
            };
            "LDAPSearchSettingScope" = mkProfileOpt {
              type = (
                types.enum [
                  "LDAPSearchSettingScopeBase"
                  "LDAPSearchSettingScopeOneLevel"
                  "LDAPSearchSettingScopeSubtree"
                ]
              );
              description = ''
                The type of recursion to use in the search:

                - `LDAPSearchSettingScopeBase`: The search uses only the
                immediate node that the search base points to.
                - `LDAPSearchSettingScopeOneLevel`: The search uses the node
                plus its immediate children.
                - `LDAPSearchSettingScopeSubtree`: The search uses the node
                plus all children, regardless of depth.

                Requires: iOS >= 4.0
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        An array of search settings dictionaries.

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
    "LDAPAccountDescription" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPAccountHostName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPAccountUserName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPAccountPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPAccountUseSSL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPSearchSettings" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPSearchSettings"."*"."LDAPSearchSettingDescription" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPSearchSettings"."*"."LDAPSearchSettingSearchBase" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "LDAPSearchSettings"."*"."LDAPSearchSettingScope" = {
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
