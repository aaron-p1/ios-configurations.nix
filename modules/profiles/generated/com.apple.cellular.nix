# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures cellular settings.

    This payload cannot be installed if an APN payload is already installed.
    This payload only applies to the preferred data SIM. There is no way to have a
    cellular payload affect a different SIM.
    This payload replaces the com.apple.managedCarrier payload. The latter payload
    is supported, but deprecated.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.cellular profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.cellular";
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
    "AttachAPN" = mkProfileOpt {
      type = (
        ios-config-utils.subopts {
          "Name" = mkProfileOpt {
            type = types.str;
            description = ''
              The name for this configuration.

              Requires: iOS >= 7.0
            '';
            required = true;
          };
          "AuthenticationType" = mkProfileOpt {
            type = (
              types.enum [
                "CHAP"
                "PAP"
              ]
            );
            description = ''
              The authentication type.

              Requires: iOS >= 7.0
            '';
            required = false;
          };
          "Username" = mkProfileOpt {
            type = types.str;
            description = ''
              The user name.

              Requires: iOS >= 7.0
            '';
            required = false;
          };
          "Password" = mkProfileOpt {
            type = types.str;
            description = ''
              The password for the user.

              Requires: iOS >= 7.0
            '';
            required = false;
          };
          "AllowedProtocolMask" = mkProfileOpt {
            type = (
              types.enum [
                1
                2
                3
              ]
            );
            description = ''
              The Internet Protocol versions that the system supports.
              Allowed values:

              - `1`: IPv4
              - `2`: IPv6
              - `3`: Both

              Requires: iOS >= 10.3
            '';
            required = false;
          };
        }
      );
      description = ''
        A configuration dictionary.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "APNs" = mkProfileOpt {
      type = (
        types.listOf (
          ios-config-utils.subopts {
            "Name" = mkProfileOpt {
              type = types.str;
              description = ''
                The name for this configuration.

                Requires: iOS >= 7.0
              '';
              required = true;
            };
            "AuthenticationType" = mkProfileOpt {
              type = (
                types.enum [
                  "CHAP"
                  "PAP"
                ]
              );
              description = ''
                The authentication type for logging in.

                Requires: iOS >= 7.0
              '';
              required = false;
            };
            "Username" = mkProfileOpt {
              type = types.str;
              description = ''
                The user name for the APN.

                Requires: iOS >= 7.0
              '';
              required = false;
            };
            "Password" = mkProfileOpt {
              type = types.str;
              description = ''
                The user's password for the APN.

                Requires: iOS >= 7.0
              '';
              required = false;
            };
            "ProxyServer" = mkProfileOpt {
              type = types.str;
              description = ''
                The proxy server's address.

                Requires: iOS >= 7.0
              '';
              required = false;
            };
            "ProxyPort" = mkProfileOpt {
              type = types.int;
              description = ''
                The proxy server's port number.

                Requires: iOS >= 7.0
              '';
              required = false;
            };
            "DefaultProtocolMask" = mkProfileOpt {
              type = (
                types.enum [
                  1
                  2
                  3
                ]
              );
              description = ''
                The default Internet Protocol versions. Available in iOS
                10.3 but no longer used in iOS 11 and later. Allowed values:

                - `1`: IPv4
                - `2`: IPv6
                - `3`: Both

                Requires: iOS >= 10.3
                Deprecated in iOS 11.0
              '';
              required = false;
            };
            "AllowedProtocolMask" = mkProfileOpt {
              type = (
                types.enum [
                  1
                  2
                  3
                ]
              );
              description = ''
                The Internet Protocol versions that the system supports.
                Available in iOS 10.3 and later. Allowed values:

                - `1`: IPv4
                - `2`: IPv6
                - `3`: Both

                Requires: iOS >= 10.3
              '';
              required = false;
            };
            "AllowedProtocolMaskInRoaming" = mkProfileOpt {
              type = (
                types.enum [
                  1
                  2
                  3
                ]
              );
              description = ''
                The Internet Protocol versions that the system supports
                while roaming. Available in iOS 10.3 and later. Allowed
                values:

                - `1`: IPv4
                - `2`: IPv6
                - `3`: Both

                Requires: iOS >= 10.3
              '';
              required = false;
            };
            "AllowedProtocolMaskInDomesticRoaming" = mkProfileOpt {
              type = (
                types.enum [
                  1
                  2
                  3
                ]
              );
              description = ''
                The Internet Protocol versions that the system supports
                while roaming. Available in iOS 10.3 and later. Allowed
                values:

                - `1`: IPv4
                - `2`: IPv6
                - `3`: Both

                Requires: iOS >= 10.3
              '';
              required = false;
            };
            "EnableXLAT464" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, the system enables XLAT464. Available in iOS 16
                and later and watchOS 9 and later.

                Requires: iOS >= 16.0
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        An array of access point name (APN) dictionaries.

        Requires: iOS >= 7.0
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
    "AttachAPN" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AttachAPN"."Name" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AttachAPN"."AuthenticationType" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AttachAPN"."Username" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AttachAPN"."Password" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AttachAPN"."AllowedProtocolMask" = {
      minIos = "10.3";
      maxIos = null;
      supervised = false;
    };
    "APNs" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."Name" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."AuthenticationType" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."Username" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."Password" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."ProxyServer" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."ProxyPort" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."DefaultProtocolMask" = {
      minIos = "10.3";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."AllowedProtocolMask" = {
      minIos = "10.3";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."AllowedProtocolMaskInRoaming" = {
      minIos = "10.3";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."AllowedProtocolMaskInDomesticRoaming" = {
      minIos = "10.3";
      maxIos = null;
      supervised = false;
    };
    "APNs"."*"."EnableXLAT464" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
  };
}
