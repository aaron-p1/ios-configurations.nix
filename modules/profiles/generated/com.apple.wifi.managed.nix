# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;

  type-id001 = _: (types.listOf types.str);
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.wifi.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.wifi.managed";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.wifi.managed";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "AutoJoin" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the device joins the network automatically.

        If `false`, the user must tap the network name to join it.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "SSID_STR" = mkProfileOpt {
      type = types.str;
      description = ''
        The SSID of the Wi-Fi network to use. In iOS 7.0 and later,
        the SSID is optional if a value exists for `DomainName`
        value.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "HIDDEN_NETWORK" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, defines this network as hidden.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ProxyType" = mkProfileOpt {
      type = (
        types.enum [
          "None"
          "Manual"
          "Auto"
        ]
      );
      description = ''
        The proxy type, if any, to use. If you choose the manual
        proxy type, you need the proxy server address, including its
        port and optionally a user name and password into the proxy
        server. If you choose the auto proxy type, you can enter a
        proxy autoconfiguration (PAC) URL.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "EncryptionType" = mkProfileOpt {
      type = (
        types.enum [
          "WEP"
          "WPA"
          "WPA2"
          "WPA3"
          "Any"
          "None"
        ]
      );
      description = ''
        The encryption type for the network.

        If set to anything except `None`, the payload may contain
        the following three keys: `Password`,
        `PayloadCertificateUUID`, or `EAPClientConfiguration`.

        As of iOS 16, tvOS 16, watchOS 9, and macOS 13:

        - `WPA` allows joining WPA or WPA2 networks
        - `WPA2` allows joining WPA2 or WPA3 networks
        - `WPA3` allows joining WPA3 networks only
        - `Any` allows joining WPA, WPA2, WPA3, and WEP networks

        Prior to iOS 16, tvOS 16, and watchOS 9, specifying `WPA`,
        `WPA2`, and `WPA3` were equivalent and would allow joining
        any WPA network.

        Prior to macOS 13, the encryption type, if specified
        explicitly, needed to match the encryption type of the
        network exactly.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "Password" = mkProfileOpt {
      type = types.str;
      description = ''
        The password for the access point.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the certificate payload within the same profile
        to use for the client credential.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "EAPClientConfiguration" = mkProfileOpt {
      type = (
        utils.subopts {
          "AcceptEAPTypes" = mkProfileOpt {
            type = (
              types.listOf (
                types.enum [
                  13
                  17
                  18
                  21
                  23
                  25
                  43
                ]
              )
            );
            description = ''
              The EAP types that the system accepts. Allowed values:

              - `13`: EAP-TLS
              - `17`: LEAP
              - `18`: EAP-SIM
              - `21`: EAP-TTLS
              - `23`: EAP-AKA
              - `25`: PEAPv0/v1
              - `43`: EAP-FAST

              For EAP-TLS authentication without a network payload,
              install the necessary identity certificates and have your
              users select EAP-TLS mode in the 802.1X credentials dialog
              that appears when they connect to the network. For other EAP
              types, a network payload is necessary and must specify the
              correct settings for the network.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
          "UserName" = mkProfileOpt {
            type = types.str;
            description = ''
              The user name for the account. If you don't specify a value,
              the system prompts the user during login.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "UserPassword" = mkProfileOpt {
            type = types.str;
            description = ''
              The user's password. If you don't specify a value, the
              system prompts the user during login.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "PayloadCertificateAnchorUUID" = mkProfileOpt {
            type = (types.listOf (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$"));
            description = ''
              An array of the UUID of each certificate payload in the same
              profile to trust for authentication. Use this key to prevent
              the device from asking the user whether to trust the listed
              certificates. Dynamic trust (the certificate dialogue) is in
              a disabled state if you specify this property without also
              enabling 'TLSAllowTrustExceptions'.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "TLSTrustedCertificates" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              An array of trusted certificates. Each entry in the array
              must contain certificate data that represents an anchor
              certificate used for verifying the server certificate.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "TLSTrustedServerNames" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              The list of accepted server certificate common names. If a
              server presents a certificate that isn't in this list, the
              system doesn't trust it.
              If you specify this property, the system disables dynamic
              trust (the certificate dialog) unless you also specify
              'TLSAllowTrustExceptions' with the value 'true'.
              If necessary, use wildcards to specify the name, such as
              'wpa.*.example.com'.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "TLSAllowTrustExceptions" = mkProfileOpt {
            type = types.bool;
            description = ''
              If 'true', allows a dynamic trust decision by the user. The
              dynamic trust is the certificate dialogue that appears when
              the system doesn't trust a certificate.
              If 'false', the authentication fails if the system doesn't
              already trust the certificate.
              As of iOS 8, Apple no longer supports this key.

              Requires: iOS >= 4.0 and < 8.0
            '';
            required = false;
          };
          "TLSCertificateIsRequired" = mkProfileOpt {
            type = types.bool;
            description = ''
              If 'true', allows for two-factor authentication for EAP-
              TTLS, PEAP, or EAP-FAST. If 'false', allows for zero-factor
              authentication for EAP-TLS.
              If you don't specify a value, the default is 'true' for EAP-
              TLS, and 'false' for other EAP types.

              Requires: iOS >= 7.0
            '';
            required = false;
          };
          "TTLSInnerAuthentication" = mkProfileOpt {
            type = (
              types.enum [
                "PAP"
                "EAP"
                "CHAP"
                "MSCHAP"
                "MSCHAPv2"
              ]
            );
            description = ''
              The inner authentication that the TTLS module uses.

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
                "1.3"
              ]
            );
            description = ''
              The minimum TLS version for EAP authentication.

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
                "1.3"
              ]
            );
            description = ''
              The maximum TLS version for EAP authentication.

              Requires: iOS >= 11.0
            '';
            required = false;
          };
          "OuterIdentity" = mkProfileOpt {
            type = types.str;
            description = ''
              A name that hides the user's true name. The user's actual
              name appears only inside the encrypted tunnel. For example,
              you might set this to anonymous or anon, or
              anon@mycompany.net. It can increase security because an
              attacker can't see the authenticating user's name in the
              clear.
              This key is only relevant to TTLS, PEAP, and EAP-FAST.
              This field is required if 'TLSMinimumVersion' is '1.3'.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "EAPFASTUsePAC" = mkProfileOpt {
            type = types.bool;
            description = ''
              If 'true', the device uses an existing PAC if it's present.
              Otherwise, the server must present its identity using a
              certificate.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "EAPFASTProvisionPAC" = mkProfileOpt {
            type = types.bool;
            description = ''
              If 'true', allows PAC provisioning.

              This value is only applicable if 'EAPFASTUsePAC' is 'true'.
              This value must be 'true' for EAP-FAST PAC usage to succeed
              because there's no other way to provision a PAC.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "EAPFASTProvisionPACAnonymously" = mkProfileOpt {
            type = types.bool;
            description = ''
              If 'true', provisions the device anonymously. Note that
              there are known machine-in-the-middle attacks for anonymous
              provisioning.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "EAPSIMNumberOfRANDs" = mkProfileOpt {
            type = (
              types.enum [
                2
                3
              ]
            );
            description = ''
              The minimum number of RAND values to accept from the server.
              For use with EAP-SIM only.

              Requires: iOS >= 8.0
            '';
            required = false;
          };
          "SystemModeCredentialsSource" = mkProfileOpt {
            type = types.str;
            description = ''
              Set this string to 'ActiveDirectory' to use the AD computer
              name and password credentials.
              If using this property, you can't use
              'SystemModeUseOpenDirectoryCredentials'.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "SystemModeUseOpenDirectoryCredentials" = mkProfileOpt {
            type = types.bool;
            description = ''
              If 'true', the system mode connection tries to use the Open
              Directory credentials.
              If using this property, you can't use
              'SystemModeCredentialsSource'.

              Requires: iOS >= 4.0
            '';
            required = false;
          };
          "OneTimeUserPassword" = mkProfileOpt {
            type = types.bool;
            description = ''
              If 'true', the user receives a prompt for a password each
              time they connect to the network.

              Requires: iOS >= 8.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The enterprise network configuration.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "DisplayedOperatorName" = mkProfileOpt {
      type = types.str;
      description = ''
        The operator name to display when connected to this network.
        Used only with Wi-Fi Hotspot 2.0 access points.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "DomainName" = mkProfileOpt {
      type = types.str;
      description = ''
        The primary domain of the tunnel.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "RoamingConsortiumOIs" = mkProfileOpt {
      type = (types.listOf (types.strMatching "^([0-9A-Za-z]{6})|([0-9A-Za-z]{9})$"));
      description = ''
        An array of Roaming Consortium Organization Identifiers used
        for Wi-Fi Hotspot 2.0 negotiation.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "ServiceProviderRoamingEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, allows connection to roaming service providers.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "IsHotspot" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the device treats the network as a hotspot.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "HESSID" = mkProfileOpt {
      type = types.str;
      description = ''
        The HESSID used for Wi-Fi Hotspot 2.0 negotiation.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "NAIRealmNames" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of Network Access Identifier Realm names used for
        Wi-Fi Hotspot 2.0 negotiation.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "MCCAndMNCs" = mkProfileOpt {
      type = (types.listOf (types.strMatching "^[0-9]{6}$"));
      description = ''
        An array of Mobile Country Code/Mobile Network Code
        (MCC/MNC) pairs used for Wi-Fi Hotspot 2.0 negotiation. Each
        string must contain exactly six digits.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "CaptiveBypass" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system bypasses Captive Network detection
        when the device connects to the network.

        Requires: iOS >= 10.0
      '';
      required = false;
    };
    "QoSMarkingPolicy" = mkProfileOpt {
      type = (
        utils.subopts {
          "QoSMarkingAllowListAppIdentifiers" = mkProfileOpt {
            type = (type-id001 { });
            description = ''
              An array of app bundle identifiers that defines the allow
              list for L2 and L3 marking for traffic that goes to the Wi-
              Fi network. If the array isn't present, but the
              `QoSMarkingPolicy` key is present — even empty — no apps can
              use L2 and L3 marking.

              Requires: iOS >= 14.5
            '';
            required = false;
          };
          "QoSMarkingWhitelistedAppIdentifiers" = mkProfileOpt {
            type = (type-id001 { });
            description = ''
              Use `QoSMarkingAllowListAppIdentifiers` instead.

              Requires: iOS >= 10.0
              Deprecated in iOS 14.5
            '';
            required = false;
          };
          "QoSMarkingAppleAudioVideoCalls" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, adds audio and video traffic of built-in audio or
              video services, such as FaceTime and Wi-Fi Calling, to the
              allow list for L2 and L3 marking for traffic that goes to
              the Wi-Fi network.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
          "QoSMarkingEnabled" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, disables L3 marking and only uses L2 marking for
              traffic that goes to the Wi-Fi network.



              If `false`, the system behaves as if Wi-Fi doesn't have an
              association with a Cisco QoS fast lane network.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
        }
      );
      description = ''
        A dictionary that contains the list of apps that the system
        allows to benefit from L2 and L3 marking. When this
        dictionary isn't present, the system allows all apps to use
        L2 and L3 marking when the Wi-Fi network supports Cisco QoS
        fast lane.

        Requires: iOS >= 10.0
      '';
      required = false;
    };
    "EnableIPv6" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, enables IPv6 on this interface.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "TLSCertificateRequired" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, allows for two-factor authentication for EAP-
        TTLS, PEAP, or EAP-FAST. If `false`, allows for zero-factor
        authentication for EAP-TLS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ProxyServer" = mkProfileOpt {
      type = types.str;
      description = ''
        The proxy server's network address.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ProxyServerPort" = mkProfileOpt {
      type = (types.ints.between 0 65535);
      description = ''
        The proxy server's port number.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ProxyUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name used to authenticate to the proxy server.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ProxyPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The password used to authenticate to the proxy server.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ProxyPACURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The URL of the PAC file that defines the proxy
        configuration.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ProxyPACFallbackAllowed" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, allows connecting directly to the destination if
        the PAC file is unreachable.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "DisableAssociationMACRandomization" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true,` disables MAC address randomization for a Wi-Fi
        network while associated with that network. This feature
        also shows a privacy warning in Settings indicating that the
        network has reduced privacy protections.

        If `false`, then the system enables MAC address
        randomization on iOS, watchOS, and visionOS.

        This value is only locked when MDM installs the profile. If
        the profile is manually installed, the system sets the value
        but the user can change it.

        Requires: iOS >= 14.0
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
    "AutoJoin" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "SSID_STR" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "HIDDEN_NETWORK" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ProxyType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EncryptionType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Password" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadCertificateUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."AcceptEAPTypes" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."UserName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."UserPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."PayloadCertificateAnchorUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."TLSTrustedCertificates" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."TLSTrustedServerNames" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."TLSAllowTrustExceptions" = {
      minIos = "4.0";
      maxIos = "8.0";
      supervised = false;
    };
    "EAPClientConfiguration"."TLSCertificateIsRequired" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."TTLSInnerAuthentication" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."TLSMinimumVersion" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."TLSMaximumVersion" = {
      minIos = "11.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."OuterIdentity" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."EAPFASTUsePAC" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."EAPFASTProvisionPAC" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."EAPFASTProvisionPACAnonymously" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."EAPSIMNumberOfRANDs" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."SystemModeCredentialsSource" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."SystemModeUseOpenDirectoryCredentials" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EAPClientConfiguration"."OneTimeUserPassword" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "DisplayedOperatorName" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "DomainName" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "RoamingConsortiumOIs" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "ServiceProviderRoamingEnabled" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "IsHotspot" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "HESSID" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "NAIRealmNames" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "MCCAndMNCs" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "CaptiveBypass" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "QoSMarkingPolicy" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "QoSMarkingPolicy"."QoSMarkingAllowListAppIdentifiers" = {
      minIos = "14.5";
      maxIos = null;
      supervised = false;
    };
    "QoSMarkingPolicy"."QoSMarkingWhitelistedAppIdentifiers" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "QoSMarkingPolicy"."QoSMarkingAppleAudioVideoCalls" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "QoSMarkingPolicy"."QoSMarkingEnabled" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "EnableIPv6" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "TLSCertificateRequired" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ProxyServer" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ProxyServerPort" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ProxyUsername" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ProxyPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ProxyPACURL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ProxyPACFallbackAllowed" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DisableAssociationMACRandomization" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
  };
}
