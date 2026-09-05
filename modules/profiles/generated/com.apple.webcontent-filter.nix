# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.webcontent-filter profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.webcontent-filter";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.webcontent-filter";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "FilterType" = mkProfileOpt {
      type = (
        types.enum [
          "BuiltIn"
          "Plugin"
        ]
      );
      description = ''
        The type of filter, built-in or plug-in. In macOS, the
        system only supports the plug-in value.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "SafariHistoryRetentionEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, this payload enforces a policy which requires
        retention of browsing history. This causes Safari to disable
        clearing of browsing history, and prevents the use of
        private browsing mode because that mode doesn't keep
        browsing history.

        Requires: iOS >= 26.0; supervised device
      '';
      required = false;
    };
    "AutoFilterEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables automatic filtering. Use when
        `FilterType` is `BuiltIn`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "PermittedURLs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array or URLs that are accessible whether or not the
        automatic filter allows access. Use when `FilterType` is
        `BuiltIn`. Requires that `AutoFilterEnabled` is `true`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "BlacklistedURLs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        Use `DenyListURLs` instead.

        Requires: iOS >= 7.0
        Deprecated in iOS 14.5
      '';
      required = false;
    };
    "DenyListURLs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of URLs that are inaccessible. Use when
        `FilterType` is `BuiltIn`. Limit the number of these URLs to
        no more than 500.

        Requires: iOS >= 14.5
      '';
      required = false;
    };
    "HideDenyListURLs" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the device hides the `DenyListURLs` item in the
        profiles that display in Settings > General > VPN & Device
        Management.

        Requires: iOS >= 18.0
      '';
      required = false;
    };
    "WhitelistedBookmarks" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "URL" = mkProfileOpt {
              type = types.str;
              description = ''
                The URL of the bookmark in the allow list.

                Requires: iOS >= 7.0
                Deprecated in iOS 14.5
              '';
              required = true;
            };
            "Title" = mkProfileOpt {
              type = types.str;
              description = ''
                The title of the bookmark.

                Requires: iOS >= 7.0
                Deprecated in iOS 14.5
              '';
              required = true;
            };
          }
        )
      );
      description = ''
        Use `AllowListBookmarks` instead.

        Requires: iOS >= 7.0
        Deprecated in iOS 14.5
      '';
      required = false;
    };
    "AllowListBookmarks" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "URL" = mkProfileOpt {
              type = types.str;
              description = ''
                The URL of the bookmark in the allow list.

                Requires: iOS >= 14.5
              '';
              required = true;
            };
            "Title" = mkProfileOpt {
              type = types.str;
              description = ''
                The title of the bookmark.

                Requires: iOS >= 14.5
              '';
              required = true;
            };
          }
        )
      );
      description = ''
        An array of dictionaries that define the pages that the user
        can bookmark or visit. Use when `FilterType` is `BuiltIn`.

        Requires: iOS >= 14.5
      '';
      required = false;
    };
    "UserDefinedName" = mkProfileOpt {
      type = types.str;
      description = ''
        The display name for this filtering configuration. Required
        when `FilterType` is `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "PluginBundleID" = mkProfileOpt {
      type = types.str;
      description = ''
        The bundle ID of the plug-in that provides filtering
        service. Required when `FilterType` is `Plugin`. Otherwise,
        it ignores this value. Consult your filtering solution
        vendor to determine what to specify for this value. Required
        when `FilterType` is `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "ServerAddress" = mkProfileOpt {
      type = types.str;
      description = ''
        The server address, which may be the IP address, hostname,
        or URL. Use when `FilterType` is `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "UserName" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name for the service. Use when `FilterType` is
        `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "Password" = mkProfileOpt {
      type = types.str;
      description = ''
        The password for the service. Use when `FilterType` is
        `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "PayloadCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the certificate payload within the same profile
        that the system uses to authenticate the user. Use when
        `FilterType` is `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "Organization" = mkProfileOpt {
      type = types.str;
      description = ''
        The organization string to pass to the third-party plug-in.
        Use when `FilterType` is `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "VendorConfig" = mkProfileOpt {
      type = (types.attrsOf types.anything);
      description = ''
        The custom dictionary that the filtering service plug-in
        needs. Use when `FilterType` is `Plugin`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "FilterBrowsers" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables filtering WebKit traffic. Use
        when `FilterType` is `Plugin`.

        > Note:
        > At least one of `FilterBrowsers` or `FilterSockets` needs
        to be `true`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "FilterSockets" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, enables the filtering of socket traffic. Use when
        `FilterType` is `Plugin`.

        > Note:
        > At least one of `FilterBrowsers` or `FilterSockets` needs
        to be `true`.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "ContentFilterUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        A globally unique identifier for this content filter
        configuration. The content filter processes network traffic
        for managed apps with the same `ContentFilterUUID` in their
        app attributes. Use when `FilterType` is `Plugin`.This key
        must be present for unsupervised devices and user
        enrollment.

        Requires: iOS >= 16.0
      '';
      required = false;
    };
    "FilterURLs" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system filters URL requests. Use when
        `FilterType` is `Plugin`. Available in iOS 26 and macOS 26,
        and later.

        Requires: iOS >= 26.0
      '';
      required = false;
    };
    "URLFilterParameters" = mkProfileOpt {
      type = (
        utils.subopts {
          "URLFilterControlProviderDesignatedRequirement" = mkProfileOpt {
            type = types.str;
            description = ''
              The designated requirement string in the code signature of
              the URL filter control provider app extension. The system
              uses this string to identify the URL filter control provider
              when the filter starts running. Required in macOS.

              Requires: iOS >= 26.0
            '';
            required = false;
          };
          "URLFilterControlProviderBundleIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The bundle identifier string of the URL filter control
              provider app extension. The system uses this string to
              identify the URL filter control provider when the filter
              starts running.

              Requires: iOS >= 26.0
            '';
            required = true;
          };
          "PIRServerURL" = mkProfileOpt {
            type = types.str;
            description = ''
              The URL containing the domain name of the private
              information retrieval server.

              Requires: iOS >= 26.0
            '';
            required = true;
          };
          "PIRPrivacyPassIssuerURL" = mkProfileOpt {
            type = types.str;
            description = ''
              The URL containing the domain name of Privacy Pass Issuer.

              Requires: iOS >= 26.0
            '';
            required = true;
          };
          "PIRAuthenticationToken" = mkProfileOpt {
            type = types.str;
            description = ''
              The per-user authentication token string, which is an HTTP
              bearer token for the person using your app. The system uses
              this token to attest that it is a valid user when requesting
              anonymous authentication tokens for PIR exchanges.

              Requires: iOS >= 26.0
            '';
            required = true;
          };
          "URLFilterFailClosed" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, the system blocks URLs if the filter is enabled,
              but it fails to make any filtering decision; for example, if
              there's a communication failure with the PIR server. If
              `false`, the system allows URLs if the filter is enabled,
              but it fails to make any filtering decision.

              Requires: iOS >= 26.0
            '';
            required = false;
          };
          "URLPrefilterFetchFrequency" = mkProfileOpt {
            type = (types.ints.min 2700);
            description = ''
              The time interval in seconds that the system uses to
              periodically run the `NEURLFilterControlProvider` app
              extension. The default value is 86400 seconds (1 day). The
              minimum allowed value is 2700 seconds (45 minutes). The
              system allows `NEURLFilterControlProvider` implementations
              to download prefilter Bloom filter data onto the device
              periodically at the specified interval. Implementations need
              to allow for a slight difference between the scheduled time
              and the actual runtime of the task, due to the scheduling
              mechanism on the system.

              Requires: iOS >= 26.0
            '';
            required = false;
          };
        }
      );
      description = ''
        A dictionary containing URL filter parameters. Required when
        `FilterURLs` is `true`. Available in iOS 26 and macOS 26 and
        later.

        Requires: iOS >= 26.0
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
    "FilterType" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "SafariHistoryRetentionEnabled" = {
      minIos = "26.0";
      maxIos = null;
      supervised = true;
    };
    "AutoFilterEnabled" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "PermittedURLs" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "BlacklistedURLs" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "DenyListURLs" = {
      minIos = "14.5";
      maxIos = null;
      supervised = false;
    };
    "HideDenyListURLs" = {
      minIos = "18.0";
      maxIos = null;
      supervised = false;
    };
    "WhitelistedBookmarks" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "WhitelistedBookmarks"."*"."URL" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "WhitelistedBookmarks"."*"."Title" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "AllowListBookmarks" = {
      minIos = "14.5";
      maxIos = null;
      supervised = false;
    };
    "AllowListBookmarks"."*"."URL" = {
      minIos = "14.5";
      maxIos = null;
      supervised = false;
    };
    "AllowListBookmarks"."*"."Title" = {
      minIos = "14.5";
      maxIos = null;
      supervised = false;
    };
    "UserDefinedName" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "PluginBundleID" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "ServerAddress" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "UserName" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Password" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadCertificateUUID" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "Organization" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "VendorConfig" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "FilterBrowsers" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "FilterSockets" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "ContentFilterUUID" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "FilterURLs" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters"."URLFilterControlProviderDesignatedRequirement" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters"."URLFilterControlProviderBundleIdentifier" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters"."PIRServerURL" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters"."PIRPrivacyPassIssuerURL" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters"."PIRAuthenticationToken" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters"."URLFilterFailClosed" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "URLFilterParameters"."URLPrefilterFetchFrequency" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
  };
}
