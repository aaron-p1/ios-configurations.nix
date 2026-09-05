# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.globalethernet.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.globalethernet.managed";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.globalethernet.managed";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "settings" = mkProfileOpt {
      type = (utils.settingsOf types.anything);
      description = ''
        Keys relevant to 802.1X configuration. User enrollment
        payloads don't support the various proxy keys, including
        `ProxyType`, `ProxyServer`, `ProxyServerPort`,
        `ProxyUsername`, `ProxyPassword`, `ProxyPACURL` and
        `ProxyPACFallbackAllowed`.

        Requires: iOS >= 17.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "settings" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
  };
}
