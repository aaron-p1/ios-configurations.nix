# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures relay settings.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.relay.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.relay.managed";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "ios-configurations.relay.managed";
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
    "Relays" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "HTTP3RelayURL" = mkProfileOpt {
              type = types.str;
              description = ''
                The URL or URI template, as defined in RFC 9298, of a relay
                server that's reachable using HTTP/3 and supports proxying
                TCP and UDP using the CONNECT method.

                Each relay needs to include either `HTTP2RelayURL` or
                `HTTP3RelayURL`, or it can include both.

                Requires: iOS >= 17.0
              '';
              required = false;
            };
            "HTTP2RelayURL" = mkProfileOpt {
              type = types.str;
              description = ''
                The URL or URI template, as defined in RFC 9298, of a relay
                server that's reachable using HTTP/2 and supports proxying
                TCP and UDP using the CONNECT method.

                Each relay needs to include either `HTTP2RelayURL` or
                `HTTP3RelayURL`, or it can include both.

                Requires: iOS >= 17.0
              '';
              required = false;
            };
            "AdditionalHTTPHeaderFields" = mkProfileOpt {
              type = (types.attrsOf types.str);
              description = ''
                A dictionary that contains custom HTTP header keys and
                values to add to each request. The dictionary key name
                represents the HTTP header field name to use, and the
                dictionary value is the string to use as the HTTP header
                field value.

                Requires: iOS >= 17.0
              '';
              required = false;
            };
            "PayloadCertificateUUID" = mkProfileOpt {
              type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
              description = ''
                The UUID that points to an identity certificate payload,
                which the system uses to authenticate the user to the relay
                server.

                Requires: iOS >= 17.0
              '';
              required = false;
            };
            "RawPublicKeys" = mkProfileOpt {
              type = (types.listOf utils.plistDataType);
              description = ''
                An array of DER-encoded raw public keys that the system uses
                to authenticate the server during a TLS handshake. The
                server needs to use one of the keys in the handshake to
                authenticate.

                If this array is empty, the system uses the default TLS
                trust evaluation.

                Requires: iOS >= 17.0
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        An array of dictionaries that describe one or more relay
        servers that the system can chain together.

        Requires: iOS >= 17.0
      '';
      required = true;
    };
    "MatchDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        A list of domain strings that the system uses to determine
        which connection to route through the servers in `Relays`.

        Any connection that matches a domain in the list exactly or
        is a subdomain of the listed domain uses the relay servers,
        unless it matches a domain in `ExcludedDomains`.

        If this list and `MatchFQDNs` are empty, the system routes
        traffic to all domains to the relay servers, except those
        that match an excluded domain or excluded FQDN.

        Requires: iOS >= 17.0
      '';
      required = false;
    };
    "ExcludedDomains" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        A list of domain strings to exclude from routing through the
        servers in `Relays`. Any connection that matches a domain in
        the list exactly or is a subdomain of the listed domain
        won't use the relay server.

        Requires: iOS >= 17.0
      '';
      required = false;
    };
    "MatchFQDNs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        A list of Fully Qualified Domain Names (FQDNs) to be routed
        through the servers contained in `Relays`. Any connection
        that matches an FQDN in the list exactly uses the relay
        servers. If this list and `MatchDomains` are empty, the
        system routes traffic to all domains to the relay servers,
        except those that match an excluded domain or excluded FQDN.

        Requires: iOS >= 18.4
      '';
      required = false;
    };
    "ExcludedFQDNs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        A list of Fully Qualified Domain Names (FQDNs) to exclude
        from routing through the servers contained in `Relays`. Any
        connection that matches an FQDN in the list exactly won't
        use the relay server. When `MatchDomains` is also present,
        any FQDN listed in the list should be a subdomain of at
        least one `MatchDomain` value, otherwise it will not have
        any effect.

        Requires: iOS >= 18.4
      '';
      required = false;
    };
    "RelayUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        A globally unique identifier for this relay configuration.
        The system uses this UUID to route managed apps through the
        servers in `Relays`. This key is required for user
        enrollment.

        Requires: iOS >= 17.0
      '';
      required = false;
    };
    "UIToggleEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the device allows the user to disable this
        network relay configuration.

        Requires: iOS >= 26.0
      '';
      required = false;
    };
    "AllowDNSFailover" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the device allows the relay to failover to the
        default system DNS resolver.

        Requires: iOS >= 26.0
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
    "Relays" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Relays"."*"."HTTP3RelayURL" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Relays"."*"."HTTP2RelayURL" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Relays"."*"."AdditionalHTTPHeaderFields" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Relays"."*"."PayloadCertificateUUID" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Relays"."*"."RawPublicKeys" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "MatchDomains" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "ExcludedDomains" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "MatchFQDNs" = {
      minIos = "18.4";
      maxIos = null;
      supervised = false;
    };
    "ExcludedFQDNs" = {
      minIos = "18.4";
      maxIos = null;
      supervised = false;
    };
    "RelayUUID" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "UIToggleEnabled" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "AllowDNSFailover" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
  };
}
