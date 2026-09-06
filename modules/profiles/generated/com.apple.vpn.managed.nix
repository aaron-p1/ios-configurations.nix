# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;

  type-id001 = _: (types.listOf types.str);
  type-id002 = _: (types.listOf types.str);
  type-id003 = _: (types.listOf types.str);
  type-id004 =
    _:
    (types.listOf (
      utils.subopts {
        "Action" = mkProfileOpt {
          type = (
            types.enum [
              "Allow"
              "Connect"
              "Disconnect"
              "EvaluateConnection"
              "Ignore"
            ]
          );
          description = ''
            The action to take if this dictionary matches the current
            network. Possible values are:
            - `Allow`: Deprecated. Allow VPN On Demand to connect if
            triggered.
            - `Connect`: Unconditionally initiate a VPN connection on
            the next network attempt.
            - `Disconnect`: Tear down the VPN connection and don't
            reconnect on demand as long as this dictionary matches.
            - `EvaluateConnection`: Evaluate the ActionParameters array
            for each connection attempt.
            - `Ignore`: Leave any existing VPN connection up, but don't
            reconnect on demand as long as this dictionary matches.
            Only the `Disconnect` action is available on watchOS 10 and
            later.

            Requires: iOS >= 4.0
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
                    The domains to apply this evaluation.

                    Requires: iOS >= 4.0
                  '';
                  required = true;
                };
                "DomainAction" = mkProfileOpt {
                  type = (
                    types.enum [
                      "ConnectIfNeeded"
                      "NeverConnect"
                    ]
                  );
                  description = ''
                    Defines the VPN behavior for the specified domains. Allowed
                    values are:
                    * 'ConnectIfNeeded': The specified domains should trigger a
                    VPN connection attempt if domain name resolution fails, such
                    as when the DNS server indicates that it can't resolve the
                    domain, responds with a redirection to a different server,
                    or fails to respond (timeout).
                    * 'NeverConnect': The specified domains should never trigger
                    a VPN connection attempt.

                    Requires: iOS >= 4.0
                  '';
                  required = true;
                };
                "RequiredDNSServers" = mkProfileOpt {
                  type = (types.listOf types.str);
                  description = ''
                    An array of IP addresses of DNS servers to use for resolving
                    the specified domains. These servers don't need to be part
                    of the device's current network configuration. If these DNS
                    servers aren't reachable, the system establishes a VPN
                    connection. These DNS servers need to be either internal DNS
                    servers or trusted external DNS servers.
                    This key is valid only if the value of 'DomainAction' is
                    'ConnectIfNeeded'.

                    Requires: iOS >= 4.0
                  '';
                  required = false;
                };
                "RequiredURLStringProbe" = mkProfileOpt {
                  type = types.str;
                  description = ''
                    An HTTP or HTTPS (preferred) URL to probe, using a GET
                    request. If the URL's hostname can't be resolved, if the
                    server is unreachable, or if the server doesn't respond with
                    a 200 HTTP status code, a VPN connection is established in
                    response.
                    This key is valid only if the value of 'DomainAction' is
                    'ConnectIfNeeded'.

                    Requires: iOS >= 4.0
                  '';
                  required = false;
                };
              }
            )
          );
          description = ''
            An array of dictionaries that provides rules similar to the
            `OnDemandRules` dictionary, but evaluated on each connection
            instead of when the network changes. This value is only for
            use with dictionaries in which the `Action` value is
            `EvaluateConnection`. The system evaluates these
            dictionaries in order and the first dictionary that matches
            determines the behavior. Not available in watchOS.

            Requires: iOS >= 4.0
          '';
          required = false;
        };
        "DNSDomainMatch" = mkProfileOpt {
          type = (types.listOf types.str);
          description = ''
            An array of domain names. This rule matches if any of the
            domain names in the specified list matches any domain in the
            device's search domains list.
            The system supports a wildcard (`*`) prefix. For example,
            `*.example.com` matches against either
            `mydomain.example.com` or `yourdomain.example.com`.

            Requires: iOS >= 4.0
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
            example, `17.*` matches any DNS server in the `17.0.0.0/8`
            subnet.

            Requires: iOS >= 4.0
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

            Requires: iOS >= 4.0
          '';
          required = false;
        };
        "SSIDMatch" = mkProfileOpt {
          type = (types.listOf types.str);
          description = ''
            An array of SSIDs to match against the current network. If
            the network isn't a Wi-Fi network or if the SSID doesn't
            appear in this array, the match fails.
            Omit this key and the corresponding array to match against
            any SSID.

            Requires: iOS >= 4.0
          '';
          required = false;
        };
        "URLStringProbe" = mkProfileOpt {
          type = types.str;
          description = ''
            A URL to probe. This rule matches when this URL is
            successfully fetched (returns a `200` HTTP status code)
            without redirection. Not available in watchOS.

            Requires: iOS >= 4.0
          '';
          required = false;
        };
      }
    ));

  type-id005 =
    _:
    (utils.subopts {
    "EncryptionAlgorithm" = mkProfileOpt {
      type = (
        types.enum [
          "DES"
          "3DES"
          "AES-128"
          "AES-256"
          "AES-128-GCM"
          "AES-256-GCM"
          "ChaCha20Poly1305"
        ]
      );
      description = ''
        The encryption algorithm.

        In watchOS and tvOS, the default value is `AES-256-GCM`.
        `DES` and `3DES` are available only in iOS, macOS, and
        visionOS prior to iOS 26, macOS 26, and visionOS 26.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IntegrityAlgorithm" = mkProfileOpt {
      type = (
        types.enum [
          "SHA1-96"
          "SHA1-160"
          "SHA2-256"
          "SHA2-384"
          "SHA2-512"
        ]
      );
      description = ''
        The integrity algorithm.

        `SHA1-96` and `SHA1-160` are available only in iOS, macOS,
        and visionOS prior to iOS 26, macOS 26, and visionOS 26.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "DiffieHellmanGroup" = mkProfileOpt {
      type = (
        types.enum [
          1
          2
          5
          14
          15
          16
          17
          18
          19
          20
          21
          31
          32
        ]
      );
      description = ''
        The Diffie-Hellman group.

        For `AlwaysOn` VPN in iOS 14.2 and later, the minimum
        allowed value is `14`.

        `1`, `2`, and `5` are available only in iOS, macOS, and
        visionOS prior to iOS 26, macOS 26, and visionOS 26.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PostQuantumKeyExchangeMethods" = mkProfileOpt {
      type = (
        types.listOf (
          types.enum [
            0
            36
            37
          ]
        )
      );
      description = ''
        An array of strings representing postquantum key exchange
        methods the device uses during SA establishment and rekey.
        You can specify up to seven items, which correspond to
        ADDKE1 - ADDKE7 from RFC 9370.

        Requires: iOS >= 26.0
      '';
      required = false;
    };
    "LifeTimeInMinutes" = mkProfileOpt {
      type = (types.ints.between 10 1440);
      description = ''
        The SA lifetime (rekey interval) in minutes.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
  });

  type-id006 = _: (types.listOf types.str);
in
{
  description = ''
    The payload that configures a VPN.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.vpn.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.vpn.managed";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "ios-configurations.vpn.managed";
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
    "VPNType" = mkProfileOpt {
      type = (
        types.enum [
          "VPN"
          "L2TP"
          "IPSec"
          "IKEv2"
          "AlwaysOn"
          "TransparentProxy"
        ]
      );
      description = ''
        The type of the VPN, which defines which settings are
        appropriate for this VPN payload.

        If the type is `VPN` or `TransparentProxy`, then the system
        requires a value for `VPNSubType`.

        `TransparentProxy` is only available in macOS. `L2TP` and
        `IPSec` aren't available in tvOS. `AlwaysOn` is only
        available on iOS and Apple Watch pairing isn't supported
        with `AlwaysOn`. For a previously paired Apple Watch, all
        phone-watch communications cease when `AlwaysOn` is enabled.
        Not available in watchOS.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "VPNSubType" = mkProfileOpt {
      type = types.str;
      description = ''
        An identifier for a vendor-specified configuration
        dictionary when the value for `VPNType` is `VPN`.

        If `VPNType` is `VPN`, the system requires this field. If
        the configuration targets a VPN solution that uses a VPN
        plugin, then this field contains the bundle identifier of
        the plugin. Here are some examples:

        - Cisco AnyConnect: `com.cisco.anyconnect.applevpn.plugin`
        - Juniper SSL: `net.juniper.sslvpn`
        - F5 SSL: `com.f5.F5-Edge-Client.vpnplugin`
        - SonicWALL Mobile Connect: `com.sonicwall.SonicWALL-
        SSLVPN.vpnplugin`
        - ``Aruba VIA: `com.arubanetworks.aruba-via.vpnplugin`

        If the configuration targets a VPN solution that uses a
        network extension provider, then this field contains the
        bundle identifier of the app that contains the provider.
        Contact the VPN solution vendor for the value of the
        identifier.

        If `VPNType` is `IKEv2`, then the `VPNSubType` field is
        optional and reserved for future use. If it's specified, it
        needs to contain an empty string.

        Not available in watchOS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "UserDefinedName" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the VPN connection that the system
        displays on the device. Not available in watchOS.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "VendorConfig" = mkProfileOpt {
      type = (
        utils.subopts {
          "Realm" = mkProfileOpt {
            type = types.str;
            description = ''
              The Kerberos realm name, which needs to be properly
              capitalized. Valid only for Juniper SSL and Pulse Secure.
              Not available in watchOS.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Role" = mkProfileOpt {
            type = types.str;
            description = ''
              The role to select when connecting to the server. Valid only
              for Juniper SSL and Pulse Secure. Not available in watchOS.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Group" = mkProfileOpt {
            type = types.str;
            description = ''
              The group to connect to on the head end. Valid for Cisco
              AnyConnect and Cisco Legacy AnyConnect. Not available in
              watchOS.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "LoginGroupOrDomain" = mkProfileOpt {
            type = types.str;
            description = ''
              The login group or domain. Valid only for SonicWALL Mobile
              Connect. Not available in watchOS.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The vendor-specific configuration dictionary, which the
        system reads only when `VPNSubType` has a value. Not
        available in watchOS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "VPN" = mkProfileOpt {
      type = (
        utils.subopts {
          "AuthName" = mkProfileOpt {
            type = types.str;
            description = ''
              The VPN account username.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AuthPassword" = mkProfileOpt {
            type = types.str;
            description = ''
              The VPN account password. Only use this if
              `AuthenticationMethod` is set to `Password`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "RemoteAddress" = mkProfileOpt {
            type = types.str;
            description = ''
              The IP address or hostname of the VPN server.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
          "AuthenticationMethod" = mkProfileOpt {
            type = (
              types.enum [
                "Password"
                "Certificate"
                "Password+Certificate"
              ]
            );
            description = ''
              The authentication method to use.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "PayloadCertificateUUID" = mkProfileOpt {
            type = types.str;
            description = ''
              The UUID of the certificate payload within the same profile
              to use for account credentials.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ProviderBundleIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The bundle identifier for the VPN provider. Not available in
              watchOS.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DisconnectOnIdle" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, disconnects after an on-demand connection idles.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DisconnectOnIdleTimer" = mkProfileOpt {
            type = types.int;
            description = ''
              The length of time to wait, in seconds, before disconnecting
              an on-demand connection. In watchOS, the maximum allowed
              value is `15`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ProviderType" = mkProfileOpt {
            type = (
              types.enum [
                "packet-tunnel"
                "app-proxy"
              ]
            );
            description = ''
              The type of VPN service. If the value is `app-proxy`, the
              service tunnels traffic at the app level. If the value is
              `packet-tunnel`, the service tunnels traffic at the IP
              layer. Not available in watchOS.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "IncludeAllNetworks" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1``, routes all traffic through the VPN, with some
              exclusions. Several of the exclusions can be controlled with
              the `ExcludeLocalNetworks`, `ExcludeCellularServices`,
              `ExcludeAPNs` and `ExcludeDeviceCommunication` properties.
              The following traffic is always excluded from the tunnel:

              - Traffic necessary for connecting and maintaining the
              device's network connection, such as DHCP.
              - Traffic necessary for connecting to captive networks.
              - Certain cellular services traffic that is not routable
              over the internet and is instead directly routed to the
              cellular network. See the ExcludeCellularServices property
              for more details.
              - Network communication with a companion device such as a
              watchOS device.

              Not available in watchOS.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "EnforceRoutes" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, all the VPN's non-default routes take precedence
              over any locally defined routes.

              If `IncludeAllNetworks` is `1`, the system ignores the value
              of `EnforceRoutes`.

              Available in iOS 14.2 and later, and macOS 11 and later. Not
              available in watchOS.

              Requires: iOS >= 14.2
            '';
            required = false;
          };
          "ExcludeLocalNetworks" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and `IncludeAllNetworks` is `1`, routes all local
              network traffic outside the VPN. Not available in watchOS.

              Requires: iOS >= 14.2
            '';
            required = false;
          };
          "ExcludeCellularServices" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and `IncludeAllNetworks` is `1`, then the system
              excludes internet-routable network traffic for cellular
              services (VoLTE, Wi-Fi Calling, IMS, MMS, Visual Voicemail,
              etc.) from the tunnel. Note that some cellular carriers
              route cellular services traffic directly to the carrier
              network, bypassing the internet. Such cellular services
              traffic is always excluded from the tunnel. Not available in
              watchOS.

              Requires: iOS >= 16.4
            '';
            required = false;
          };
          "ExcludeAPNs" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and `IncludeAllNetworks` is `1`, then the system
              excludes the network traffic for the Apple Push Notification
              service (APNs) from the tunnel. Not available in watchOS.

              Requires: iOS >= 16.4
            '';
            required = false;
          };
          "ExcludeDeviceCommunication" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If set to `1` and `IncludeAllNetworks` is set to `1`, the
              device excludes network traffic used for communicating with
              devices connected via USB or Wi-Fi from the tunnel.

              Requires: iOS >= 17.4
            '';
            required = false;
          };
          "OnDemandEnabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables VPN On Demand.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "OnDemandUserOverrideDisabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the Connect On Demand toggle in Settings is disabled
              for this configuration. Available in iOS 14 and later. Not
              available in watchOS.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "OnDemandMatchDomainsAlways" = mkProfileOpt {
            type = (type-id001 { });
            description = ''
              A list of domain names. The system treats associated domain
              names as though they're associated with the
              `OnDemandMatchDomainsOnRetry` key. This behavior can be
              overridden by `OnDemandRules`.

              In iOS 7 and later, this key is deprecated (but still
              supported) in favor of `EvaluateConnection` actions in the
              `OnDemandRules` dictionaries.

              Not available in watchOS.

              Requires: iOS >= 4.0
              Deprecated in iOS 7.0
            '';
            required = false;
          };
          "OnDemandMatchDomainsNever" = mkProfileOpt {
            type = (type-id002 { });
            description = ''
              A list of domain names. If the host name ends with one of
              these domain names, the system doesn't start the VPN
              automatically. The system uses this value to exclude a
              subdomain within an included domain.

              In iOS 7 and later, this key is deprecated (but still
              supported) in favor of `EvaluateConnection` actions in the
              `OnDemandRules` dictionaries.

              Not available in watchOS.

              Requires: iOS >= 4.0
              Deprecated in iOS 7.0
            '';
            required = false;
          };
          "OnDemandMatchDomainsOnRetry" = mkProfileOpt {
            type = (type-id003 { });
            description = ''
              A list of domain names. If the host name ends with one of
              these domain names and a DNS query for that domain name
              fails, the system starts the VPN automatically.

              In iOS 7 and later, this key is deprecated (but still
              supported) in favor of `EvaluateConnection` actions in the
              `OnDemandRules` dictionaries.

              Not available in watchOS.

              Requires: iOS >= 4.0
              Deprecated in iOS 7.0
            '';
            required = false;
          };
          "OnDemandRules" = mkProfileOpt {
            type = (type-id004 { });
            description = ''
              An array of dictionaries defining On Demand Rules.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The dictionary to use when `VPNType` is `VPN`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IPv4" = mkProfileOpt {
      type = (
        utils.subopts {
          "OverridePrimary" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the system sends all network traffic over VPN. Only
              applies to Cisco IPsec and L2TP VPN types.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The dictionary that contains IPv4 settings. Not available in
        watchOS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PPP" = mkProfileOpt {
      type = (
        utils.subopts {
          "AuthName" = mkProfileOpt {
            type = types.str;
            description = ''
              The VPN account user name. This key is for use with L2TP and
              PPTP networks.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AuthPassword" = mkProfileOpt {
            type = types.str;
            description = ''
              If `TokenCard` is `1`, use this password for authentication.
              This key is for use with L2TP and PPTP networks.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "TokenCard" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, uses a token card such as an RSA SecurID card for
              connecting. This key is for use with L2TP networks.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "CommRemoteAddress" = mkProfileOpt {
            type = types.str;
            description = ''
              The IP address or host name of VPN server. This key is for
              use with L2TP and PPTP networks.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AuthEAPPlugins" = mkProfileOpt {
            type = (
              types.listOf (
                types.enum [
                  "EAP-RSA"
                  "EAP-TLS"
                  "EAP-KRB"
                ]
              )
            );
            description = ''
              An array of authentication plugins. For use of RSA SecurID,
              this array should only have one value: `EAP-RSA`. This key
              is for use with L2TP and PPTP networks.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AuthProtocol" = mkProfileOpt {
            type = (
              types.listOf (
                types.enum [
                  "EAP"
                ]
              )
            );
            description = ''
              An array of authentication protocols. For use of RSA
              SecurID, this array should have one value, `EAP`. This key
              is for use with L2TP and PPTP networks.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "CCPMPPE40Enabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and `CCPEnabled` is also `1`, enables CCPMPPE128
              encryption.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "CCPMPPE128Enabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and `CCPEnabled` is also `1`, enables CCPMPPE40
              encryption.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "CCPEnabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables encryption on the connection. This key is
              for use with PPTP networks.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DisconnectOnIdle" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, disconnects after an on demand connection idles.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DisconnectOnIdleTimer" = mkProfileOpt {
            type = types.int;
            description = ''
              The length of time to wait before disconnecting an on demand
              connection

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The dictionary to use when `VPNType` is `L2TP` or `PTPP`.
        Not available in watchOS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IPSec" = mkProfileOpt {
      type = (
        utils.subopts {
          "RemoteAddress" = mkProfileOpt {
            type = types.str;
            description = ''
              The IP address or host name of the VPN server.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AuthenticationMethod" = mkProfileOpt {
            type = (
              types.enum [
                "SharedSecret"
                "Certificate"
              ]
            );
            description = ''
              The authentication method for L2TP and Cisco IPSec.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "XAuthName" = mkProfileOpt {
            type = types.str;
            description = ''
              The user name for the VPN account for Cisco IPSec.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "XAuthPassword" = mkProfileOpt {
            type = types.str;
            description = ''
              The VPN account password for Cisco IPSec.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "XAuthEnabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables Xauth for Cisco IPSec VPNs.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "XAuthPasswordEncryption" = mkProfileOpt {
            type = (
              types.enum [
                "Prompt"
              ]
            );
            description = ''
              A string that either has the value "Prompt" or isn't
              present.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "LocalIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The name of the group. For hybrid authentication, the string
              needs to end with "hybrid".

              Present only for Cisco IPSec if `AuthenticationMethod` is
              `SharedSecret`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "LocalIdentifierType" = mkProfileOpt {
            type = (
              types.enum [
                "KeyID"
              ]
            );
            description = ''
              Present only if `AuthenticationMethod` is `SharedSecret`.
              The value is `KeyID`. The system uses this value for L2TP
              and Cisco IPSec VPNs.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "SharedSecret" = mkProfileOpt {
            type = utils.plistDataType;
            description = ''
              The shared secret for this VPN account.

              Only use this with L2TP and Cisco IPSec VPNs and if the
              `AuthenticationMethod` key is to `SharedSecret`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "PayloadCertificateUUID" = mkProfileOpt {
            type = types.str;
            description = ''
              The UUID of the certificate payload within the same profile
              to use for the account credentials.

              Only use this with Cisco IPSec VPNs and if the
              `AuthenticationMethod` key is to `Certificate`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "PromptForVPNPIN" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, prompts for a PIN when connecting to Cisco IPSec
              VPNs.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DisconnectOnIdle" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, disconnect after an on-demand connection idles.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DisconnectOnIdleTimer" = mkProfileOpt {
            type = types.int;
            description = ''
              The length of time to wait before disconnecting an on-demand
              connection.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "OnDemandEnabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables bringing the VPN connection up on demand.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "OnDemandMatchDomainsAlways" = mkProfileOpt {
            type = (type-id001 { });
            description = ''
              Deprecated. A list of domain names. In iOS 7 and later, if
              this key is present, the system treats associated domain
              names as though they're associated with the
              `OnDemandMatchDomainsOnRetry` key. This behavior can be
              overridden by `OnDemandRules`.

              Requires: iOS >= 4.0
              Deprecated in iOS 7.0
            '';
            required = false;
          };
          "OnDemandMatchDomainsNever" = mkProfileOpt {
            type = (type-id002 { });
            description = ''
              Deprecated. A list of domain names. In iOS 7 and later, this
              key is deprecated (but still supported) in favor of
              `EvaluateConnection` actions in the `OnDemandRules`
              dictionaries.

              Requires: iOS >= 4.0
              Deprecated in iOS 7.0
            '';
            required = false;
          };
          "OnDemandMatchDomainsOnRetry" = mkProfileOpt {
            type = (type-id003 { });
            description = ''
              Deprecated. A list of domain names. In iOS 7 and later, this
              field is deprecated (but still supported) in favor of
              `EvaluateConnection` actions in the `OnDemandRules`
              dictionaries.

              Requires: iOS >= 4.0
              Deprecated in iOS 7.0
            '';
            required = false;
          };
          "OnDemandRules" = mkProfileOpt {
            type = (type-id004 { });
            description = ''
              The on-demand rules dictionary.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The dictionary that contains IPSec settings. Not available
        in watchOS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IKEv2" = mkProfileOpt {
      type = (
        utils.subopts {
          "RemoteAddress" = mkProfileOpt {
            type = types.str;
            description = ''
              The IP address or host name of the VPN server.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
          "LocalIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              Identifier of the IKEv2 client.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
          "RemoteIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The remote identifier.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
          "AuthenticationMethod" = mkProfileOpt {
            type = (
              types.enum [
                "None"
                "SharedSecret"
                "Certificate"
              ]
            );
            description = ''
              The type of authentication method for the VPN.

              To enable EAP-only authentication, set this to `None` and
              `ExtendedAuthEnabled` to `1`. If this is `None` and the
              `ExtendedAuthEnabled` key isn't set, the authentication
              configuration defaults to `SharedSecret`.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
          "CertificateType" = mkProfileOpt {
            type = (
              types.enum [
                "RSA"
                "ECDSA256"
                "ECDSA384"
                "ECDSA521"
                "RSA-PSS"
              ]
            );
            description = ''
              The type of `PayloadCertificateUUID` to use for IKEv2
              machine authentication. If this key is included, the system
              requires a value for `ServerCertificateIssuerCommonName`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "PayloadCertificateUUID" = mkProfileOpt {
            type = types.str;
            description = ''
              The UUID of the certificate payload within the same profile
              to use as the account credential. If the value of
              `AuthenticationMethod` is `Certificate`, the system sends
              this certificate out for IKEv2 machine authentication. If
              extended authentication (EAP) is used, the system sends this
              certificate out for EAP-TLS authentication.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "Password" = mkProfileOpt {
            type = types.str;
            description = ''
              The password to use for the account credentials. Only used
              if `AuthenticationMethod` is `Password`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ProviderBundleIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              If the VPNSubType field contains the bundle identifier of an
              app that contains multiple VPN providers of the same type
              (app-proxy or packet-tunnel), then the system uses this
              field to choose which provider to use for this
              configuration. If the VPN provider is implemented as a
              System Extension, then this field is required.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "SharedSecret" = mkProfileOpt {
            type = types.str;
            description = ''
              If `AuthenticationMethod` is `SharedSecret`, this value is
              used for IKE authentication.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ExtendedAuthEnabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables EAP-only authentication.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AuthName" = mkProfileOpt {
            type = types.str;
            description = ''
              The user name to use for authentication.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "AuthPassword" = mkProfileOpt {
            type = types.str;
            description = ''
              The password to use for authentication.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "OnDemandEnabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables VPN up on demand.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "OnDemandUserOverrideDisabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the system disables the Connect On Demand toggle in
              Settings for this configuration.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "OnDemandRules" = mkProfileOpt {
            type = (type-id004 { });
            description = ''
              A list of rules that determine when and how to use an
              OnDemand VPN.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DeadPeerDetectionRate" = mkProfileOpt {
            type = (
              types.enum [
                "None"
                "Low"
                "Medium"
                "High"
              ]
            );
            description = ''
              One of the following:

              - `None`: No keepalive.
              - `Low`: Send keepalive every 30 minutes.
              - `Medium`: Send keepalive every 10 minutes.
              - `High`: Send keepalive every 1 minute.

              Not available in watchOS.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ServerCertificateIssuerCommonName" = mkProfileOpt {
            type = types.str;
            description = ''
              Common Name of the server certificate issuer. If set, this
              field causes IKE to send a certificate request based on this
              certificate issuer to the server. This key is required if
              the `CertificateType` key is included and the
              `ExtendedAuthEnabled` key is `1`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ServerCertificateCommonName" = mkProfileOpt {
            type = types.str;
            description = ''
              The common name of the server certificate. The system uses
              this name to validate the certificate sent by the IKE
              server. If not set, the system uses the remote identifier to
              validate the certificate.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "TLSMinimumVersion" = mkProfileOpt {
            type = (
              types.enum [
                "1.0"
                "1.1"
                "1.2"
              ]
            );
            description = ''
              The minimum TLS version to use with EAP-TLS authentication.

              Requires: iOS >= 11.0
            '';
            required = false;
          };
          "TLSMaximumVersion" = mkProfileOpt {
            type = (
              types.enum [
                "1.0"
                "1.1"
                "1.2"
              ]
            );
            description = ''
              The maximum TLS version to use with EAP-TLS authentication.

              Requires: iOS >= 11.0
            '';
            required = false;
          };
          "UseConfigurationAttributeInternalIPSubnet" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, negotiations should use IKEv2 Configuration
              Attribute `INTERNAL_IP4_SUBNET` and `INTERNAL_IP6_SUBNET`.

              Requires: iOS >= 9.0
            '';
            required = false;
          };
          "DisableMOBIKE" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the system disables MOBIKE.

              Requires: iOS >= 9.0
            '';
            required = false;
          };
          "DisableRedirect" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the system disables IKEv2 redirect. If not set, the
              system redirects an IKEv2 connection when it receives a
              redirect request from the server.

              Requires: iOS >= 9.0
            '';
            required = false;
          };
          "DisconnectOnIdle" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the VPN disconnects automatically after a period
              defined by `DisconnectOnIdleTimer`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "DisconnectOnIdleTimer" = mkProfileOpt {
            type = types.int;
            description = ''
              Only used if `DisconnectOnIdle` is `1`. The number of
              seconds before the VPN disconnects. On watchOS, maximum
              allowed value is 15 seconds

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "NATKeepAliveOffloadEnable" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables NAT keepalive offload for Always On VPN
              IKEv2 connections. The device sends keepalive packets to
              maintain NAT mappings for IKEv2 connections that have a NAT
              on the path. It sends keepalive packets at regular intervals
              when the device is awake. If `NATKeepAliveOffloadEnable` is
              `1`, the system offloads keepalive packets to hardware while
              the device is asleep.

              NAT keepalive offload has an impact on the battery life due
              to the extra workload during sleep. The default interval for
              the keepalive offload packets is 20 seconds over Wi-Fi and
              110 seconds over Cellular interface. The default NAT
              keepalive works well on networks with small NAT mapping
              timeouts but imposes a potential battery impact. If a
              network has larger NAT mapping timeouts, larger keepalive
              intervals may be safely used to minimize battery impact.
              Modify the keepalive interval through the
              `NATKeepAliveInterval` key.

              Requires: iOS >= 9.0
            '';
            required = false;
          };
          "NATKeepAliveInterval" = mkProfileOpt {
            type = types.int;
            description = ''
              The NAT Keepalive interval for Always On VPN IKEv2
              connections. This value controls the interval that the
              device sends keepalive offload packets. The minimum value is
              20 seconds. If no key is specified, the default is 20
              seconds over Wi-Fi and 110 seconds over a cellular
              interface.

              Requires: iOS >= 9.0
            '';
            required = false;
          };
          "EnablePFS" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`,  enables Perfect Forward Secrecy (PFS) for IKEv2
              Connections.

              Requires: iOS >= 9.0
            '';
            required = false;
          };
          "EnableCertificateRevocationCheck" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the system performs a certificate revocation check
              for IKEv2 connections. This is a best-effort revocation
              check and server response timeouts won't cause it to fail.

              Requires: iOS >= 9.0
            '';
            required = false;
          };
          "EnableFallback" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, the system enables a tunnel over cellular data to
              carry traffic that's eligible for Wi-Fi Assist and also
              requires VPN.

              Enabling fallback requires that the server support multiple
              tunnels for a single user.

              This field is available in iOS 13 and later, and tvOS 17 and
              later. Not available in watchOS.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "MTU" = mkProfileOpt {
            type = (types.ints.between 1280 1400);
            description = ''
              The Maximum Transmission Unit (MTU) specifies the maximum
              size in bytes of each packet that the system sends over the
              IKEv2 VPN interface. Available in iOS 14 and later, and
              macOS 11 and later.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "ProviderType" = mkProfileOpt {
            type = (
              types.enum [
                "packet-tunnel"
                "app-proxy"
              ]
            );
            description = ''
              If the value of this key is `app-proxy`, the VPN service
              tunnels traffic at the application layer. If the value of
              this key is `packet-tunnel`, the VPN service tunnels traffic
              at the IP layer.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "IncludeAllNetworks" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, then the system routes all network traffic through
              the VPN, with some controllable exclusions, such as
              `ExcludeLocalNetworks`, `ExcludeCellularServices`, and
              `ExcludeAPNs` properties. The system always excludes the
              following traffic from the tunnel:

              - Traffic necessary for connecting and maintaining the
              device's network connection, such as DHCP.
              - Traffic necessary for connecting to captive networks.
              - Certain cellular services traffic that's not routable over
              the internet and is instead directly routed to the cellular
              network. See the `ExcludeCellularServices` field for more
              information.
              - Network communication with a companion device such as a
              watchOS device.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "EnforceRoutes" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, all the VPN's non-default routes take precedence
              over any locally-defined routes. If `IncludeAllNetworks` is
              `1`, the system ignores `EnforceRoutes`.

              Requires: iOS >= 14.2
            '';
            required = false;
          };
          "ExcludeLocalNetworks" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and either `IncludeAllNetworks` or `EnforceRoutes`
              are `1`, then the system routes local network traffic
              outside of the VPN. The default for this value is `0` on
              macOS and `1` on iOS.

              Requires: iOS >= 14.2
            '';
            required = false;
          };
          "ExcludeCellularServices" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and `IncludeAllNetworks` is `1`, the system excludes
              internet-routable network traffic for cellular services
              (VoLTE, Wi-Fi Calling, IMS, MMS, Visual Voicemail, etc.)
              from the tunnel. Note that some cellular carriers route
              cellular services traffic directly to the carrier network,
              bypassing the internet. Such cellular services traffic is
              always excluded from the tunnel.

              Requires: iOS >= 16.4
            '';
            required = false;
          };
          "ExcludeAPNs" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1` and `IncludeAllNetworks` is `1`, the system excludes
              network traffic for the Apple Push Notification service
              (APNs) from the tunnel.

              Requires: iOS >= 16.4
            '';
            required = false;
          };
          "ExcludeDeviceCommunication" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If set to `1` and `IncludeAllNetworks` is set to `1`, the
              device excludes network traffic used for communicating with
              devices connected via USB or Wi-Fi from the tunnel.

              Requires: iOS >= 17.4
            '';
            required = false;
          };
          "PPK" = mkProfileOpt {
            type = utils.plistDataType;
            description = ''
              The Post-quantum Pre-shared key (PPK) the device uses for
              this VPN. This key is is used with VPN servers that support
              RFC 8784. If this key is present `PPKIdentifier` must also
              be present.

              Requires: iOS >= 18.0
            '';
            required = false;
          };
          "PPKIdentifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The identifier for the Post-quantum Pre-shared key (PPK) the
              device uses for this VPN. This key is is used with VPN
              servers that support RFC 8784. If this key is present `PPK`
              must also be present.

              Requires: iOS >= 18.0
            '';
            required = false;
          };
          "PPKMandatory" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If set to `1`, the VPN doesn't establish a connection if the
              server doesn't support RFC 8784 or doesn't accept the PPK
              identifier specified in `PPKIdentifier`. The device ignores
              this key if `PPK` and `PPKIdentifier` are not present.

              Requires: iOS >= 18.0
            '';
            required = false;
          };
          "AllowPostQuantumKeyExchangeFallback" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If set to `0`, the VPN doesn't establish a connection if the
              server does not support or doesn't allow post-quantum key
              exchanges. Thd device ignores this key if
              `PostQuantumKeyExchangeMethods` is not present in
              `IKESecurityAssociationParameters` or
              `ChildSecurityAssociationParameters`.

              Requires: iOS >= 26.0
            '';
            required = false;
          };
          "EnforceStrictAlgorithmSelection" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If set to `1`, the device doesn't allow DES, 3DES, and
              Diffie-Hellman groups less than 14. Also the device requires
              the encryption algorithm specified for the IKE SA to be at
              least as cryptographically strong as the algorithm specified
              for the child SA. The device rejects this profile payload if
              these requirements are not met.

              Requires: iOS >= 18.5
            '';
            required = false;
          };
          "IKESecurityAssociationParameters" = mkProfileOpt {
            type = (type-id005 { });
            description = ''
              These parameters apply to Child Security Association unless
              `ChildSecurityAssociationParameters` is specified.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ChildSecurityAssociationParameters" = mkProfileOpt {
            type = (type-id005 { });
            description = ''
              The `ChildSecurityAssociationParameters` dictionaries.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The dictionary to use when `VPNType` is `IKEv2`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "DNS" = mkProfileOpt {
      type = (
        utils.subopts {
          "DNSProtocol" = mkProfileOpt {
            type = (
              types.enum [
                "Cleartext"
                "HTTPS"
                "TLS"
              ]
            );
            description = ''
              The transport protocol to communicate with the DNS server.

              Requires: iOS >= 14.0
            '';
            required = true;
          };
          "ServerURL" = mkProfileOpt {
            type = types.str;
            description = ''
              The URI template of a DNS-over-HTTPS server, as defined in
              RFC 8484, which needs to use the `https://` scheme. The
              system uses the hostname or address in the URL to validate
              the server certificate. If `ServerAddresses` isn't
              specified, the system uses the hostname or address in the
              URL to determine the server addresses. This key is required
              if the `DNSProtocol` is `HTTPS`.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "ServerName" = mkProfileOpt {
            type = types.str;
            description = ''
              The hostname of a DNS-over-TLS server to validate the server
              certificate, as defined in RFC 7858. If `ServerAddresses`
              isn't specified, the system uses the hostname to determine
              the server addresses. This key is required if the
              `DNSProtocol` is `TLS`.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "ServerAddresses" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              The array of DNS server IP address strings. These IP
              addresses can be a mixture of IPv4 and IPv6 addresses.

              Requires: iOS >= 10.0
            '';
            required = true;
          };
          "SearchDomains" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              The list of domain strings used to fully qualify single-
              label host names.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
          "DomainName" = mkProfileOpt {
            type = types.str;
            description = ''
              The primary domain of the tunnel.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
          "SupplementalMatchDomains" = mkProfileOpt {
            type = (type-id006 { });
            description = ''
              The list of domain strings used to determine which DNS
              queries use the DNS resolver settings in `ServerAddresses`.
              The system uses this key to create a split DNS configuration
              where it resolves only hosts in certain domains using the
              tunnel's DNS resolver. The system uses the default resolver
              for hosts that aren't in one of the domains in this list.

              If `SupplementalMatchDomains` contains the empty string it
              becomes the default domain.

              Split-tunnel configurations can direct all DNS queries to
              the VPN DNS servers before the primary DNS servers. If the
              VPN tunnel becomes the network's default route, the servers
              listed in `ServerAddresses` become the default resolver and
              the system ignores the `SupplementalMatchDomains` list.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
          "SupplementalMatchDomainsNoSearch" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `0`, append the domains in the `SupplementalMatchDomains`
              list to the resolver's list of search domains.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
          "PayloadCertificateUUID" = mkProfileOpt {
            type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
            description = ''
              That UUID that points to an identity certificate payload.
              The system uses this identity to authenticate the user to
              the DNS resolver.

              Requires: iOS >= 16.0
            '';
            required = false;
          };
        }
      );
      description = ''
        A dictionary to use for all VPN types.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "Proxies" = mkProfileOpt {
      type = (
        utils.subopts {
          "ProxyAutoConfigEnable" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `true`, enables automatic proxy configuration.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ProxyAutoDiscoveryEnable" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `true`, enables proxy auto discovery.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "ProxyAutoConfigURLString" = mkProfileOpt {
            type = types.str;
            description = ''
              The URL to the location of the proxy auto-configuration
              file. Used only when `ProxyAutoConfigEnable` is `true`.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "SupplementalMatchDomains" = mkProfileOpt {
            type = (type-id006 { });
            description = ''
              An array of domains that defines which hosts use proxy
              settings for hosts.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPEnable" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, enables proxy for HTTP traffic.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPProxy" = mkProfileOpt {
            type = types.str;
            description = ''
              The host name of the HTTP proxy.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPPort" = mkProfileOpt {
            type = (types.ints.between 0 65535);
            description = ''
              The port number of the HTTP proxy. This field is required if
              `HTTPProxy` is specified.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPProxyUsername" = mkProfileOpt {
            type = types.str;
            description = ''
              The user name used for authentication.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPProxyPassword" = mkProfileOpt {
            type = types.str;
            description = ''
              The password used for authentication.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPSEnable" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `true`, enables proxy for HTTPS traffic.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPSProxy" = mkProfileOpt {
            type = types.str;
            description = ''
              The host name of the HTTPS proxy.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "HTTPSPort" = mkProfileOpt {
            type = (types.ints.between 0 65535);
            description = ''
              The port number of the HTTPS proxy. This field is required
              if `HTTPSProxy` is specified.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The dictionary to use to configure `Proxies` for use with
        `VPN`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "AlwaysOn" = mkProfileOpt {
      type = (
        utils.subopts {
          "UIToggleEnabled" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, allows the user to disable the VPN configuration.

              Requires: iOS >= 8.0
            '';
            required = false;
          };
          "TunnelConfigurations" = mkProfileOpt {
            type = (
              types.listOf (
                utils.subopts {
                  "ProtocolType" = mkProfileOpt {
                    type = (
                      types.enum [
                        "IKEv2"
                      ]
                    );
                    description = ''
                      The type of connection, which needs to be `IKEv2`.

                      Requires: iOS >= 8.0
                    '';
                    required = true;
                  };
                  "Interfaces" = mkProfileOpt {
                    type = (
                      types.listOf (
                        types.enum [
                          "Cellular"
                          "WiFi"
                        ]
                      )
                    );
                    description = ''
                      The interfaces to apply this configuration to.

                      Requires: iOS >= 8.0
                    '';
                    required = false;
                  };
                }
              )
            );
            description = ''
              An array that contains an arbitrary number of tunnel
              configurations.

              Requires: iOS >= 8.0
            '';
            required = true;
          };
          "ServiceExceptions" = mkProfileOpt {
            type = (
              types.listOf (
                utils.subopts {
                  "ServiceName" = mkProfileOpt {
                    type = (
                      types.enum [
                        "VoiceMail"
                        "AirPrint"
                        "CellularServices"
                        "DeviceCommunication"
                      ]
                    );
                    description = ''
                      The name of a service that's exempt from Always On VPN.

                      `CellularServices` is available in iOS 11.3 and later; it
                      exempts `VoLTE`, `IMS` and `MMS`. WiFiCalling is exempted in
                      iOS 13.4 and later.

                      `DeviceCommunication` is available in iOS 17.4 and later; it
                      exempts network traffic used for communicating with devices
                      connected via USB or Wi-Fi.

                      Requires: iOS >= 8.0
                    '';
                    required = true;
                  };
                  "Action" = mkProfileOpt {
                    type = (
                      types.enum [
                        "Allow"
                        "Drop"
                      ]
                    );
                    description = ''
                      The action to take with network connections from the named
                      service.

                      Requires: iOS >= 8.0
                    '';
                    required = true;
                  };
                }
              )
            );
            description = ''
              An array that contains an arbitrary number of service
              exceptions.

              Requires: iOS >= 8.0
            '';
            required = false;
          };
          "ApplicationExceptions" = mkProfileOpt {
            type = (
              types.listOf (
                utils.subopts {
                  "BundleIdentifier" = mkProfileOpt {
                    type = types.str;
                    description = ''
                      The app's bundle identifier.

                      Requires: iOS >= 13.6
                    '';
                    required = true;
                  };
                  "LimitToProtocols" = mkProfileOpt {
                    type = (
                      types.listOf (
                        types.enum [
                          "UDP"
                        ]
                      )
                    );
                    description = ''
                      Limit the exception to only the specified list of protocols,
                      with support for `UDP` only.

                      Requires: iOS >= 13.6
                    '';
                    required = false;
                  };
                }
              )
            );
            description = ''
              An array that contains an arbitrary number of apps whose
              connections occur outside the VPN.

              Requires: iOS >= 13.6
            '';
            required = false;
          };
          "AllowCaptiveWebSheet" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, allows traffic from Captive Web Sheet outside the
              VPN tunnel.

              Requires: iOS >= 8.0
            '';
            required = false;
          };
          "AllowAllCaptiveNetworkPlugins" = mkProfileOpt {
            type = (
              types.enum [
                0
                1
              ]
            );
            description = ''
              If `1`, allows traffic from all captive networking apps
              outside the VPN tunnel to perform captive network handling.

              Requires: iOS >= 8.0
            '';
            required = false;
          };
          "AllowedCaptiveNetworkPlugins" = mkProfileOpt {
            type = (
              types.listOf (
                utils.subopts {
                  "BundleIdentifier" = mkProfileOpt {
                    type = types.str;
                    description = ''
                      The bundle identifier for the app that's allowed on the
                      captive network.

                      Requires: iOS >= 8.0
                    '';
                    required = true;
                  };
                }
              )
            );
            description = ''
              The array of captive networking apps whose traffic is
              allowed outside the VPN tunnel, to perform captive network
              handling. Used only when `AllowAllCaptiveNetworkPlugins` is
              `false`.

              Requires: iOS >= 8.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The dictionary to use when `VPNType` is `AlwaysOn`. Not
        available in tvOS or watchOS.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPNType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPNSubType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "UserDefinedName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VendorConfig" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VendorConfig"."Realm" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VendorConfig"."Role" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VendorConfig"."Group" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VendorConfig"."LoginGroupOrDomain" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."AuthName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."AuthPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."RemoteAddress" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."AuthenticationMethod" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."PayloadCertificateUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."ProviderBundleIdentifier" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."DisconnectOnIdle" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."DisconnectOnIdleTimer" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."ProviderType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."IncludeAllNetworks" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."EnforceRoutes" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
    "VPN"."ExcludeLocalNetworks" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
    "VPN"."ExcludeCellularServices" = {
      minIos = "16.4";
      maxIos = null;
      supervised = false;
    };
    "VPN"."ExcludeAPNs" = {
      minIos = "16.4";
      maxIos = null;
      supervised = false;
    };
    "VPN"."ExcludeDeviceCommunication" = {
      minIos = "17.4";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandEnabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandUserOverrideDisabled" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandMatchDomainsAlways" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandMatchDomainsNever" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandMatchDomainsOnRetry" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."Action" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."ActionParameters" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."ActionParameters"."*"."Domains" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."ActionParameters"."*"."DomainAction" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."ActionParameters"."*"."RequiredDNSServers" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."ActionParameters"."*"."RequiredURLStringProbe" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."DNSDomainMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."DNSServerAddressMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."InterfaceTypeMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."SSIDMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "VPN"."OnDemandRules"."*"."URLStringProbe" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPv4" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPv4"."OverridePrimary" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."AuthName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."AuthPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."TokenCard" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."CommRemoteAddress" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."AuthEAPPlugins" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."AuthProtocol" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."CCPMPPE40Enabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."CCPMPPE128Enabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."CCPEnabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."DisconnectOnIdle" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PPP"."DisconnectOnIdleTimer" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."RemoteAddress" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."AuthenticationMethod" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."XAuthName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."XAuthPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."XAuthEnabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."XAuthPasswordEncryption" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."LocalIdentifier" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."LocalIdentifierType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."SharedSecret" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."PayloadCertificateUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."PromptForVPNPIN" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."DisconnectOnIdle" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."DisconnectOnIdleTimer" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandEnabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandMatchDomainsAlways" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandMatchDomainsNever" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandMatchDomainsOnRetry" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."Action" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."ActionParameters" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."ActionParameters"."*"."Domains" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."ActionParameters"."*"."DomainAction" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."ActionParameters"."*"."RequiredDNSServers" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."ActionParameters"."*"."RequiredURLStringProbe" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."DNSDomainMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."DNSServerAddressMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."InterfaceTypeMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."SSIDMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IPSec"."OnDemandRules"."*"."URLStringProbe" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."RemoteAddress" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."LocalIdentifier" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."RemoteIdentifier" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."AuthenticationMethod" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."CertificateType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."PayloadCertificateUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."Password" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ProviderBundleIdentifier" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."SharedSecret" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ExtendedAuthEnabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."AuthName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."AuthPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandEnabled" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandUserOverrideDisabled" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."Action" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."ActionParameters" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."ActionParameters"."*"."Domains" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."ActionParameters"."*"."DomainAction" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."ActionParameters"."*"."RequiredDNSServers" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."ActionParameters"."*"."RequiredURLStringProbe" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."DNSDomainMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."DNSServerAddressMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."InterfaceTypeMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."SSIDMatch" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."OnDemandRules"."*"."URLStringProbe" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."DeadPeerDetectionRate" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ServerCertificateIssuerCommonName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ServerCertificateCommonName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."TLSMinimumVersion" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."TLSMaximumVersion" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."UseConfigurationAttributeInternalIPSubnet" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."DisableMOBIKE" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."DisableRedirect" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."DisconnectOnIdle" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."DisconnectOnIdleTimer" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."NATKeepAliveOffloadEnable" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."NATKeepAliveInterval" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."EnablePFS" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."EnableCertificateRevocationCheck" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."EnableFallback" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."MTU" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ProviderType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."IncludeAllNetworks" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."EnforceRoutes" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ExcludeLocalNetworks" = {
      minIos = "14.2";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ExcludeCellularServices" = {
      minIos = "16.4";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ExcludeAPNs" = {
      minIos = "16.4";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ExcludeDeviceCommunication" = {
      minIos = "17.4";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."PPK" = {
      minIos = "18.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."PPKIdentifier" = {
      minIos = "18.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."PPKMandatory" = {
      minIos = "18.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."AllowPostQuantumKeyExchangeFallback" = {
      minIos = "26.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."EnforceStrictAlgorithmSelection" = {
      minIos = "18.5";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."IKESecurityAssociationParameters" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IKEv2"."ChildSecurityAssociationParameters" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DNS" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."DNSProtocol" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."ServerURL" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."ServerName" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."ServerAddresses" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."SearchDomains" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."DomainName" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."SupplementalMatchDomains" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."SupplementalMatchDomainsNoSearch" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "DNS"."PayloadCertificateUUID" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."ProxyAutoConfigEnable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."ProxyAutoDiscoveryEnable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."ProxyAutoConfigURLString" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."SupplementalMatchDomains" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPEnable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPProxy" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPPort" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPProxyUsername" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPProxyPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPSEnable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPSProxy" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Proxies"."HTTPSPort" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."UIToggleEnabled" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."TunnelConfigurations" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."TunnelConfigurations"."*"."ProtocolType" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."TunnelConfigurations"."*"."Interfaces" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."ServiceExceptions" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."ServiceExceptions"."*"."ServiceName" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."ServiceExceptions"."*"."Action" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."ApplicationExceptions" = {
      minIos = "13.6";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."ApplicationExceptions"."*"."BundleIdentifier" = {
      minIos = "13.6";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."ApplicationExceptions"."*"."LimitToProtocols" = {
      minIos = "13.6";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."AllowCaptiveWebSheet" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."AllowAllCaptiveNetworkPlugins" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."AllowedCaptiveNetworkPlugins" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "AlwaysOn"."AllowedCaptiveNetworkPlugins"."*"."BundleIdentifier" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
  };
}
