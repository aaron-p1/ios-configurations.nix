# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.globalethernet.managed";
  description = ''
    The payload that configures the default fallback global Ethernet interface.

    This payload's contents contain these profile-specific keys:

    - Interface (String): This payload uses the value `GlobalEthernet`.
    - EAPClientConfiguration (`EAPClientConfiguration`): The dictionary that defines
    the enterprise profile for the network.
    - SetupModes (String): The type of connection mode, which is either `System` or
    `Loginwindow`. `System` is the default.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.globalethernet.managed profile";
    "settings" = mkProfileOpt {
      type = (ios-config-utils.settingsOf types.anything);
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
