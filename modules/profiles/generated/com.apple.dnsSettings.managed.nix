# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures encrypted DNS settings.

    When installed from an MDM, the setting only applies to managed Wi-Fi networks.

    When installed manually, this setting also applies to cellular networks.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.dnsSettings.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.dnsSettings.managed";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "ios-configurations.dnsSettings.managed";
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
    "DNSSettings" = mkProfileOpt {
      type = (
        utils.subopts {
          "DNSProtocol" = mkProfileOpt {
            type = (
              types.enum [
                "HTTPS"
                "TLS"
              ]
            );
            description = ''
              The encrypted transport protocol used to communicate with
              the DNS server.

              Requires: iOS >= 14.0
            '';
            required = true;
          };
          "ServerURL" = mkProfileOpt {
            type = types.str;
            description = ''
              The URI template of a DNS-over-HTTPS server, as defined in
              RFC 8484. This URL needs to use the `https://` scheme, and
              the system uses the hostname or address in the URL to
              validate the server certificate. If no `ServerAddresses` are
              provided, the system uses the hostname or address in the URL
              to determine the server addresses. Required if `DNSProtocol`
              is `HTTPS`.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "ServerName" = mkProfileOpt {
            type = types.str;
            description = ''
              The hostname of a DNS-over-TLS server used to validate the
              server certificate, as defined in RFC 7858. If no
              `ServerAddresses` are provided, the system uses the hostname
              to determine the server addresses. This key must be present
              only if the DNSProtocol is `TLS`.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "ServerAddresses" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              An unordered list of DNS server IP address strings. These IP
              addresses can be a mixture of IPv4 and IPv6 addresses.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "AllowFailover" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, the device allows failover to the default system
              DNS resolver.

              Requires: iOS >= 26.0
            '';
            required = false;
          };
          "PayloadCertificateUUID" = mkProfileOpt {
            type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
            description = ''
              The UUID that points to an identity certificate payload. The
              system uses this identity to authenticate the user to the
              DNS resolver.

              Requires: iOS >= 16.0
            '';
            required = false;
          };
          "SupplementalMatchDomains" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              A list of domain strings used to determine which DNS queries
              use the DNS server. If not set, all domains use the DNS
              server.

              The system supports a single wildcard (`*`) prefix, but it's
              not required. For example, both `*.example.com` and
              `example.com` match against `mydomain.example.com` and
              `your.domain.example.com`, but don't match against
              `mydomain-example.com`.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
        }
      );
      description = ''
        A dictionary that defines a configuration for an encrypted
        DNS server.

        Requires: iOS >= 14.0
      '';
      required = true;
    };
    "OnDemandRules" = mkProfileOpt {
      type = (
        types.listOf (
          utils.subopts {
            "Action" = mkProfileOpt {
              type = (
                types.enum [
                  "Connect"
                  "Disconnect"
                  "EvaluateConnection"
                ]
              );
              description = ''
                The action to take if this dictionary matches the current
                network. Allowed values:

                - `Connect`: Apply DNS Settings when the dictionary matches.
                - `Disconnect`: Don't apply DNS Settings when the dictionary
                matches.
                - `EvaluateConnection`: Apply DNS Settings with per-domain
                exceptions when the dictionary matches.

                Requires: iOS >= 14.0
              '';
              required = true;
            };
            "ActionParameters" = mkProfileOpt {
              type = (
                types.listOf (
                  utils.subopts {
                    "Domains" = mkProfileOpt {
                      type = (types.listOf types.str);
                      description = ''
                        The domains for which this evaluation applies.

                        Requires: iOS >= 14.0
                      '';
                      required = true;
                    };
                    "DomainAction" = mkProfileOpt {
                      type = (
                        types.enum [
                          "NeverConnect"
                          "ConnectIfNeeded"
                        ]
                      );
                      description = ''
                        The DNS settings behavior for the specified domains. Allowed
                        values:

                        * 'NeverConnect': Don't use the DNS Settings for the
                        specified domains.
                        * 'ConnectIfNeeded': Allow using the DNS Settings for the
                        specified domains.

                        Requires: iOS >= 14.0
                      '';
                      required = true;
                    };
                  }
                )
              );
              description = ''
                An array of dictionaries that provide per-connection rules.
                The system uses this array only for settings where the
                `Action` value is `EvaluateConnection`.

                Requires: iOS >= 14.0
              '';
              required = false;
            };
            "DNSDomainMatch" = mkProfileOpt {
              type = (types.listOf types.str);
              description = ''
                An array of domain names. This rule matches if any of the
                domain names in the specified list matches any domain in the
                device's search domains list.

                The system supports a single wildcard (`*`) prefix, but it's
                not required. For example, both `*.example.com` and
                `example.com` match against `mydomain.example.com` and
                `your.domain.example.com`, but don't match against
                `mydomain-example.com`.

                Requires: iOS >= 14.0
              '';
              required = false;
            };
            "DNSServerAddressMatch" = mkProfileOpt {
              type = (types.listOf types.str);
              description = ''
                An array of IP addresses. This rule matches if any of the
                network's specified DNS servers match any entry in the
                array.

                The system supports matching with a single wildcard. For
                example, `17.*` matches any DNS server in the 17.0.0.0/8
                subnet.

                Requires: iOS >= 14.0
              '';
              required = false;
            };
            "InterfaceTypeMatch" = mkProfileOpt {
              type = (
                types.enum [
                  "Ethernet"
                  "WiFi"
                  "Cellular"
                ]
              );
              description = ''
                An interface type. If specified, this rule matches only if
                the primary network interface hardware matches the specified
                type.

                Requires: iOS >= 14.0
              '';
              required = false;
            };
            "SSIDMatch" = mkProfileOpt {
              type = (types.listOf types.str);
              description = ''
                An array of SSIDs to match against the current network. If
                the network isn't a Wi-Fi network or if the SSID doesn't
                appear in this array, the match fails. Omit this key and the
                corresponding array to match against any SSID.

                Requires: iOS >= 14.0
              '';
              required = false;
            };
            "URLStringProbe" = mkProfileOpt {
              type = types.str;
              description = ''
                A URL to probe. This rule matches if this URL is
                successfully fetched and returns a 200 HTTP status code
                without redirection.

                Requires: iOS >= 14.0
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        An array of rules that define the DNS settings. If not set,
        the system always applies the DNS settings. These rules are
        identical to the `OnDemandRules` array in VPN payloads.

        Requires: iOS >= 14.0
      '';
      required = false;
    };
    "ProhibitDisablement" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system prohibits users from disabling DNS
        settings. This key is only available on supervised devices.

        Requires: iOS >= 14.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings"."DNSProtocol" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings"."ServerURL" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings"."ServerName" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings"."ServerAddresses" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings"."AllowFailover" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings"."PayloadCertificateUUID" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "DNSSettings"."SupplementalMatchDomains" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."Action" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."ActionParameters" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."ActionParameters"."*"."Domains" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."ActionParameters"."*"."DomainAction" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."DNSDomainMatch" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."DNSServerAddressMatch" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."InterfaceTypeMatch" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."SSIDMatch" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "OnDemandRules"."*"."URLStringProbe" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "ProhibitDisablement" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
  };
}
