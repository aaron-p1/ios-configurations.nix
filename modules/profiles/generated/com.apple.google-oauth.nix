# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.google-oauth";
  description = ''
    The payload that configures a Google account.

    A Google account payload sets up a Google email address as well as any other
    Google services the user enables after authentication. Google accounts must be
    installed via MDM or by Apple Configurator 2 (if the device is supervised). The
    payload never contains credentials and the user will be prompted to enter their
    credentials shortly after the payload successfully installs. On Shared iPads,
    this payload can only be installed on the MDM user channel.

    You can install multiple Google payloads. Each sets up a Google email address
    and any other Google services the user enables after authentication.

    > Note:
    > For supervised devices, the system requires installation of Google accounts
    through MDM or Apple Configurator 2.

    The payload never contains credentials; the system prompts the user to enter
    credentials shortly after installation of the payload.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.google-oauth profile";
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
