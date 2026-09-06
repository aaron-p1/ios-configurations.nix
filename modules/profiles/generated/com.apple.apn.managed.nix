# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures access point names.

    Not supported in macOS.
    This technically does install on watchOS but we are removing the supportedOS
    dictionary. The cellular payload should be used instead.
    Only applies to the preferred data SIM.
    Deprecated. Use Cellular instead.

    This profile is deprecated. Use the `Cellular` profile instead.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.apn.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.apn.managed";
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
    "DefaultsData" = mkProfileOpt {
      type = (
        ios-config-utils.subopts {
          "apns" = mkProfileOpt {
            type = (
              types.listOf (
                ios-config-utils.subopts {
                  "apn" = mkProfileOpt {
                    type = types.str;
                    description = ''
                      The access point name.

                      Requires: iOS >= 4.0
                      Deprecated in iOS 7.0
                    '';
                    required = true;
                  };
                  "username" = mkProfileOpt {
                    type = types.str;
                    description = ''
                      The user name. If missing, the device prompts for it during
                      profile installation.

                      Requires: iOS >= 4.0
                      Deprecated in iOS 7.0
                    '';
                    required = false;
                  };
                  "password" = mkProfileOpt {
                    type = ios-config-utils.plistDataType;
                    description = ''
                      The password for the user. For obfuscation purposes, the
                      system encodes the password. If missing, the device prompts
                      for the password during profile installation.

                      Requires: iOS >= 4.0
                      Deprecated in iOS 7.0
                    '';
                    required = false;
                  };
                  "proxy" = mkProfileOpt {
                    type = types.str;
                    description = ''
                      The IP address or URL of the APN proxy.

                      Requires: iOS >= 4.0
                      Deprecated in iOS 7.0
                    '';
                    required = false;
                  };
                  "proxyPort" = mkProfileOpt {
                    type = types.int;
                    description = ''
                      The port number of the APN proxy.

                      Requires: iOS >= 4.0
                      Deprecated in iOS 7.0
                    '';
                    required = false;
                  };
                }
              )
            );
            description = ''
              An array of APN dictionaries (\`APN.DefaultsData.Apns\`).

              Requires: iOS >= 4.0
              Deprecated in iOS 7.0
            '';
            required = true;
          };
        }
      );
      description = ''
        The list of access point names (APNs).

        Requires: iOS >= 4.0
        Deprecated in iOS 7.0
      '';
      required = true;
    };
    "DefaultsDomainName" = mkProfileOpt {
      type = (
        types.enum [
          "com.apple.managedCarrier"
        ]
      );
      description = ''
        The domain name.

        Requires: iOS >= 4.0
        Deprecated in iOS 7.0
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsData" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsData"."apns" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsData"."apns"."*"."apn" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsData"."apns"."*"."username" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsData"."apns"."*"."password" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsData"."apns"."*"."proxy" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsData"."apns"."*"."proxyPort" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DefaultsDomainName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
  };
}
