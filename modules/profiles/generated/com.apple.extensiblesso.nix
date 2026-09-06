# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.extensiblesso profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.extensiblesso";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.extensiblesso";
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
    "ExtensionIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        The bundle identifier of the app extension that performs SSO
        for the specified URLs.

        Requires: iOS >= 13.0
      '';
      required = true;
    };
    "Type" = mkProfileOpt {
      type = (
        types.enum [
          "Credential"
          "Redirect"
        ]
      );
      description = ''
        The type of SSO.

        Requires: iOS >= 13.0
      '';
      required = true;
    };
    "Realm" = mkProfileOpt {
      type = types.str;
      description = ''
        The realm name for `Credential` payloads. Use proper
        capitalization for this value. Ignored for `Redirect`
        payloads.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "ExtensionData" = mkProfileOpt {
      type = (types.attrsOf types.anything);
      description = ''
        A dictionary of arbitrary data passed through to the app
        extension.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "URLs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of URL prefixes of identity providers where the app
        extension performs SSO.

        Required for `Redirect` payloads. Ignored for `Credential`
        payloads.

        The URLs need to begin with `http://` or `https://`.

        The system:

        - Matches scheme and host name case-insensitively
        - Doesn't allow query parameters and URL fragments
        - Requires that the URLs of all installed Extensible SSO
        payloads are unique

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "Hosts" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of host or domain names that apps can authenticate
        through the app extension.

        Required for `Credential` payloads. Ignored for `Redirect`
        payloads.

        The system:

        - Matches host or domain names case-insensitively
        - Requires that all the host and domain names of all
        installed Extensible SSO payloads are unique

        > Note:
        > Host names that begin with a "." are wildcard suffixes
        that match all subdomains; otherwise the host name needs be
        an exact match.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "ScreenLockedBehavior" = mkProfileOpt {
      type = (
        types.enum [
          "Cancel"
          "DoNotHandle"
        ]
      );
      description = ''
        If set to `Cancel`, the system cancels authentication
        requests when the screen is locked. If set to `DoNotHandle`,
        the request continues without SSO instead. This doesn't
        apply to requests where `userInterfaceEnabled` is `false`,
        or for background `URLSession` requests. Available in iOS 15
        and later, and macOS 12 and later.

        Requires: iOS >= 15.0
      '';
      required = false;
    };
    "DeniedBundleIdentifiers" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of bundle identifiers of apps that don't use SSO
        provided by this extension. Available in iOS 15 and later,
        and macOS 12 and later.

        Requires: iOS >= 15.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionIdentifier" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "Type" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "Realm" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "URLs" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "Hosts" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ScreenLockedBehavior" = {
      minIos = "15.0";
      maxIos = null;
      supervised = false;
    };
    "DeniedBundleIdentifiers" = {
      minIos = "15.0";
      maxIos = null;
      supervised = false;
    };
  };
}
