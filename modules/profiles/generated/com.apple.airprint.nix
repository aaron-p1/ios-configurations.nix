# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.airprint profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.airprint";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.airprint";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "AirPrint" = mkProfileOpt {
      type = types.listOf (
        types.submodule (
          { ... }: {
            options = {
              "IPAddress" = mkProfileOpt {
                type = types.str;
                description = ''
                  The IP address or hostname of the AirPrint destination.
                '';
                required = true;
              };
              "ResourcePath" = mkProfileOpt {
                type = types.str;
                description = ''
                  The resource path associated with the printer. This path
                  corresponds to the `rp` parameter of the `_ipps.tcp` Bonjour
                  record. For example:

                  - `printers/Canon_MG5300_series`
                  - `printers/Xerox_Phaser_7600`
                  - `ipp/print`
                  - `Epson_IPP_Printer`
                '';
                required = true;
              };
              "Port" = mkProfileOpt {
                type = (types.ints.between 0 65535);
                description = ''
                  The listening port of the AirPrint destination. Available
                  only in iOS 11 and later.
                '';
                required = false;
              };
              "ForceTLS" = mkProfileOpt {
                type = types.bool;
                description = ''
                  If `true`, AirPrint connections are secured by Transport
                  Layer Security (TLS). Available only in iOS 11 and later.
                '';
                required = false;
              };
            };
          }
        )
      );
      description = ''
        An array of AirPrint printers that are presented to the
        user.
      '';
      required = true;
    };
  };
  supportData = {
    enable = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AirPrint" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AirPrint"."*"."IPAddress" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AirPrint"."*"."ResourcePath" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AirPrint"."*"."Port" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "AirPrint"."*"."ForceTLS" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
  };
}
