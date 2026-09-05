# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.proxy.http.global profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.proxy.http.global";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.proxy.http.global";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "ProxyType" = mkProfileOpt {
      type = (
        types.enum [
          "Manual"
          "Auto"
        ]
      );
      description = ''
        The proxy type. For a manual proxy type, the profile
        contains the proxy server address, including its port, and
        optionally a user name and password. For an auto proxy type,
        you can enter a PAC URL.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "ProxyServer" = mkProfileOpt {
      type = types.str;
      description = ''
        The proxy server's network address. The device requires this
        if `ProxyType` is set to `Manual`, and ignores it if
        `ProxyType` is set to `Automatic`.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "ProxyServerPort" = mkProfileOpt {
      type = types.int;
      description = ''
        The proxy server's port number. The device requires this if
        `ProxyType` is set to `Manual`, and ignores this if
        `ProxyType` is set to `Automatic`.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "ProxyUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name used to authenticate to the proxy server. The
        device only uses this if `ProxyType` is set to `Manual`, and
        ignores it if `ProxyType` is set to `Automatic`.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "ProxyPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The password used to authenticate to the proxy server. The
        device only uses this if `ProxyType` is set to `Manual`, and
        ignores it if `ProxyType` is set to `Automatic`.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "ProxyPACURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The URL of the PAC file that defines the proxy
        configuration. Starting in iOS 13 and macOS 10.15, only URLs
        that begin with `http://` or `https://` are allowed. This is
        only used if `ProxyType` is set to `Automatic`, and is
        ignored if `ProxyType` is set to `Manual`.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "ProxyPACFallbackAllowed" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, allows connecting directly to the destination if
        the proxy autoconfiguration (PAC) file is unreachable.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
    "ProxyCaptiveLoginAllowed" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, allows the device to bypass the proxy server to
        display the login page for captive networks.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyType" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyServer" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyServerPort" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyUsername" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyPassword" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyPACURL" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyPACFallbackAllowed" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "ProxyCaptiveLoginAllowed" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
  };
}
