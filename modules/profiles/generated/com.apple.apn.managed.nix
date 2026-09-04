# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.apn.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.apn.managed";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.apn.managed";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "DefaultsData" = mkProfileOpt {
      type = (
        types.submodule (
          { ... }: {
            options = {
              "apns" = mkProfileOpt {
                type = types.listOf (
                  types.submodule (
                    { ... }: {
                      options = {
                        "apn" = mkProfileOpt {
                          type = types.str;
                          description = ''
                            The access point name.
                          '';
                          required = true;
                        };
                        "username" = mkProfileOpt {
                          type = types.str;
                          description = ''
                            The user name. If missing, the device prompts for it during
                            profile installation.
                          '';
                          required = false;
                        };
                        "password" = mkProfileOpt {
                          type = utils.plistDataType;
                          description = ''
                            The password for the user. For obfuscation purposes, the
                            system encodes the password. If missing, the device prompts
                            for the password during profile installation.
                          '';
                          required = false;
                        };
                        "proxy" = mkProfileOpt {
                          type = types.str;
                          description = ''
                            The IP address or URL of the APN proxy.
                          '';
                          required = false;
                        };
                        "proxyPort" = mkProfileOpt {
                          type = types.int;
                          description = ''
                            The port number of the APN proxy.
                          '';
                          required = false;
                        };
                      };
                    }
                  )
                );
                description = ''
                  An array of APN dictionaries (\`APN.DefaultsData.Apns\`).
                '';
                required = true;
              };
            };
          }
        )
      );
      description = ''
        The list of access point names (APNs).
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
      '';
      required = true;
    };
  };
  supportData = {
    enable = {
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
