# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.google-oauth profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.google-oauth";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.google-oauth";
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
    "AccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        A user-visible description of the Google account, shown in
        the Mail and Settings apps.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "AccountName" = mkProfileOpt {
      type = types.str;
      description = ''
        The user's full name for the Google account. This name
        appears in sent messages.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "EmailAddress" = mkProfileOpt {
      type = types.str;
      description = ''
        The full Google email address for the account.

        Requires: iOS >= 9.3
      '';
      required = true;
    };
    "CommunicationServiceRules" = mkProfileOpt {
      type = (
        utils.subopts {
          "DefaultServiceHandlers" = mkProfileOpt {
            type = (
              utils.subopts {
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
              A dictionary that defines which app to use for audio calls
              from this account.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The communication service handler rules for this account.

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
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "AccountDescription" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "AccountName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "EmailAddress" = {
      minIos = "9.3";
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
