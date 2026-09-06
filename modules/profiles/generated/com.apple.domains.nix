# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.domains";
  description = ''
    The payload that configures the domains under an organization's management.

    This payload defines web domains that are under an enterprise's management.

    The `WebDomains`, `SafariPasswordAutoFillDomains`, and
    `CrossSiteTrackingPreventionRelaxedDomains` keys are arrays containing strings
    that use the following matching patterns:

    - `example.com`: Any path under `example.com` matches, but not
    `site.example.com`.
    - `foo.example.com`: Any path under `foo.example.com` matches, but not
    `example.com` or `bar.example.com`.
    - `\*.example.com`: Any path under `foo.example.com` or `bar.example.com`
    matches, but not `example.com`.
    - `example.com/sub`: `example.com/sub` and any path under it matches, but not
    `example.com`.
    - `foo.example.com/sub`: Any path under `foo.example.com/sub` matches, but not
    `example.com`, `example.com/sub`, `foo.example.com/`, or `bar.example.com/sub`.
    - `\*.example.com/sub`: Any path under `foo.example.com/sub` or
    `bar.example.com/sub` matches, but not `example.com` or `foo.example.com/`.
    - `\*.co`: Any path under `example.co` or `betterbag.co` matches, but not
    `example.co.uk` or `example.com`.

    A URL that begins with the prefix `www.` is treated as though it doesn't contain
    that prefix during matching. For example, `http://www.example.com/store` is
    matched as `http://example.com/store`.

    Trailing slashes are ignored.

    If a domain string contains a port number, the system considers only addresses
    that specify that port number managed. Otherwise, the system matches the domain
    without regard to the port number specified. For example, the pattern
    `*.example.com:8080` matches `http://site.example.com:8080/page.html` but not
    `http://site.example.com/page.html`, while the pattern `*.example.com` matches
    both URLs.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.domains profile";
    "EmailDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of domains. Mail marks in red all email addresses
        that lack a suffix matching any of these strings.

        Available in iOS 8 and later and macOS 10.10 and later.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "WebDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of domains. The system considers URLs matching the
        patterns listed in this property managed.

        Available in iOS 9.3 and later.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "SafariPasswordAutoFillDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of domains. Users can only save passwords in Safari
        from URLs matching the patterns listed here. This property
        doesn't disable the autofill feature itself.

        Supervised devices or Shared iPads need this property to
        enable saving passwords in Safari.

        Available in iOS 9.3 and later.

        Requires: iOS >= 9.3; supervised device
      '';
      required = false;
    };
    "CrossSiteTrackingPreventionRelaxedDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of up to 10 strings. URLs matching the patterns
        listed here have relaxed enforcement of cross-site tracking
        prevention.

        Available in iOS 16.2 and later and macOS 13.1 and later.

        Requires: iOS >= 16.2; supervised device
      '';
      required = false;
    };
    "CrossSiteTrackingPreventionRelaxedApps" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of up to 10 strings representing app bundle-ids.
        Apps matching the bundle-ids listed here have relaxed
        enforcement of cross-site tracking prevention for the
        domains listed in
        `CrossSiteTrackingPreventionRelaxedDomains`.

        Available in iOS 18 and later and macOS 15 and later.

        Requires: iOS >= 18.0; supervised device
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "EmailDomains" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "WebDomains" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "SafariPasswordAutoFillDomains" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "CrossSiteTrackingPreventionRelaxedDomains" = {
      minIos = "16.2";
      maxIos = null;
      supervised = true;
    };
    "CrossSiteTrackingPreventionRelaxedApps" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
  };
}
