# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a macOS Server account.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.osxserver.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.osxserver.account";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.osxserver.account";
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
    "HostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The server's address.

        Requires: iOS >= 9.0 and < 12.0
        Deprecated in iOS 12.0
      '';
      required = true;
    };
    "UserName" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's user name.

        Requires: iOS >= 9.0 and < 12.0
        Deprecated in iOS 12.0
      '';
      required = true;
    };
    "Password" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's password.

        Requires: iOS >= 9.0 and < 12.0
        Deprecated in iOS 12.0
      '';
      required = false;
    };
    "AccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the account.

        Requires: iOS >= 9.0 and < 12.0
        Deprecated in iOS 12.0
      '';
      required = false;
    };
    "ConfiguredAccounts" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "Type" = mkProfileOpt {
              type = (
                types.enum [
                  "com.apple.osxserver.documents"
                ]
              );
              description = ''
                com.apple.osxserver.documents (the Documents account type).

                Requires: iOS >= 9.0 and < 12.0
                Deprecated in iOS 12.0
              '';
              required = true;
            };
            "Port" = mkProfileOpt {
              type = types.int;
              description = ''
                Designates the port number to use when contacting the
                server. If no port number is specified, the default port is
                used.

                Requires: iOS >= 9.0 and < 12.0
                Deprecated in iOS 12.0
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        An array of dictionaries containing configured account types
        and relevant settings

        Requires: iOS >= 9.0 and < 12.0
        Deprecated in iOS 12.0
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
    "HostName" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
    "UserName" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
    "Password" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
    "AccountDescription" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
    "ConfiguredAccounts" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
    "ConfiguredAccounts"."*"."Type" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
    "ConfiguredAccounts"."*"."Port" = {
      minIos = "9.0";
      maxIos = "12.0";
      supervised = false;
    };
  };
}
