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
      default = "com.example.manage-ios.extensiblesso(kerberos)";
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
      type = (
        types.enum [
          "com.apple.AppSSOKerberos.KerberosExtension"
        ]
      );
      description = ''
        Set this to `com.apple.AppSSOKerberos.KerberosExtension` for
        this extension.

        Requires: iOS >= 13.0
      '';
      required = true;
    };
    "TeamIdentifier" = mkProfileOpt {
      type = (
        types.enum [
          "apple"
        ]
      );
      description = ''
        Set this to `apple` for this extension.

        Requires: iOS >= 13.0
      '';
      required = true;
    };
    "Type" = mkProfileOpt {
      type = (
        types.enum [
          "Credential"
        ]
      );
      description = ''
        Set this to `Credential` for this extension.

        Requires: iOS >= 13.0
      '';
      required = true;
    };
    "Realm" = mkProfileOpt {
      type = types.str;
      description = ''
        The Kerberos realm. Use proper capitalization for this
        value. If in an Active Directory forest, this is the realm
        where the user logs in.

        Requires: iOS >= 13.0
      '';
      required = true;
    };
    "ExtensionData" = mkProfileOpt {
      type = (
        utils.subopts {
          "cacheName" = mkProfileOpt {
            type = types.str;
            description = ''
              The GSS name of the Kerberos cache to use. Rarely set by an
              administrator.

              Requires: iOS >= 13.0
              Deprecated in iOS 15.0
            '';
            required = false;
          };
          "principalName" = mkProfileOpt {
            type = types.str;
            description = ''
              The principal (username) to use. You don't need to include
              the realm.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "siteCode" = mkProfileOpt {
            type = types.str;
            description = ''
              The name of the Active Directory site the Kerberos extension
              should use. Most administrators don't need to modify this
              value, as the Kerberos extension can normally find the site
              automatically.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "certificateUUID" = mkProfileOpt {
            type = types.str;
            description = ''
              The PayloadUUID of a PKINIT certificate.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "useSiteAutoDiscovery" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `false`, the Kerberos extension doesn't automatically use
              LDAP and DNS to determine its AD site name.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "credentialBundleIdACL" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              A list of bundle IDs allowed to access the ticket-granting
              ticket (TGT).

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "includeManagedAppsInBundleIdACL" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, the Kerberos extension allows only managed apps
              to access and use the credential. This is in addition to the
              `credentialBundleIDACL`, if you specify that value.
              Available in iOS 14 and later, and macOS 12 and later.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "domainRealmMapping" = mkProfileOpt {
            type = (
              utils.subopts {
                "Realm" = mkProfileOpt {
                  type = (types.listOf types.str);
                  description = ''
                    The key should be the name of the realm, and the value is an
                    array of DNS suffixes that map to the realm.

                    Requires: iOS >= 13.0
                  '';
                  required = false;
                };
              }
            );
            description = ''
              A custom domain-realm mapping for Kerberos. The system uses
              this when the DNS name of hosts doesn't match the realm
              name. Most administrators don't need to customize this.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "isDefaultRealm" = mkProfileOpt {
            type = types.bool;
            description = ''
              Specifies whether this is the default realm if there's more
              than one Kerberos extension configuration.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "customUsernameLabel" = mkProfileOpt {
            type = types.str;
            description = ''
              The custom user name label used in the Kerberos extension
              instead of "Username," such as "Company ID". Available in
              macOS 11 and later.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "helpText" = mkProfileOpt {
            type = types.str;
            description = ''
              The text to display to the user at the bottom of the
              Kerberos Login Window. You can also use this to display help
              information or disclaimer text. Available in iOS 14 and
              later, and macOS 11 and later.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "allowAutomaticLogin" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `false`, the system doesn't allow saving passwords in the
              keychain.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "requireUserPresence" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, the system requires the user to provide Touch ID,
              Face ID or their passcode to access the keychain entry.

              Requires: iOS >= 13.0
            '';
            required = false;
          };
          "requireTLSForLDAP" = mkProfileOpt {
            type = types.bool;
            description = ''
              Require that LDAP connections use TLS. Available in macOS 11
              and later.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "credentialUseMode" = mkProfileOpt {
            type = (
              types.enum [
                "always"
                "whenNotSpecified"
                "kerberosDefault"
              ]
            );
            description = ''
              This setting affects how other processes use the Kerberos
              Extension credential. Allowed values:

              - `always`: The system always uses the credential if the SPN
              matches the Kerberos Extension `Hosts` array and the caller
              hasn't specified another credential. However, the system
              won't use the credential if the calling app isn't in the
              `credentialBundleIDACL`.
              - `whenNotSpecified`: The system only uses the extension
              credential if the SPN matches the Kerberos Extension `Hosts`
              array. However, the system won't use the credential if the
              calling app isn't in the `credentialBundleIDACL`.
              - `kerberosDefault`: The system uses the default Kerberos
              processes to select credentials, and normally uses the
              default Kerberos credential. This is the same as turning off
              this capability.

              Available in macOS 11 and later.

              Requires: iOS >= 14.0
            '';
            required = false;
          };
          "preferredKDCs" = mkProfileOpt {
            type = (types.listOf types.str);
            description = ''
              The ordered list of preferred Key Distribution Centers
              (KDCs) to use for Kerberos traffic. Use this if the servers
              aren't discoverable through DNS. If the servers are
              specified, then the system uses them for both connectivity
              checks and attempts to use them first for Kerberos traffic.
              If the servers don't respond, the device falls back to DNS
              discovery. Format each entry the same as it would be in a
              `krb5.conf` file, for example:

              - `adserver1.example.com`
              - `tcp/adserver1.example.com:88`
              - `kkdcp://kerberosproxy.example.com:443/kkdcp`

              Requires: iOS >= 15.0
            '';
            required = false;
          };
          "performKerberosOnly" = mkProfileOpt {
            type = types.bool;
            description = ''
              If `true`, the Kerberos Extension handles Kerberos requests
              only. It doesn't check for password expiration, show the
              password expiration in the menu, check for external password
              changes, perform password sync, or retrieve the home
              directory. Available in macOS 13 and later.

              Requires: iOS >= 16.0
            '';
            required = false;
          };
        }
      );
      description = ''
        This is the dictionary used by the Apple built-in Kerberos
        extension.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "Hosts" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        One or more host or domain names for which the app extension
        performs SSO.

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
    "TeamIdentifier" = {
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
    "ExtensionData"."cacheName" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."principalName" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."siteCode" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."certificateUUID" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."useSiteAutoDiscovery" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."credentialBundleIdACL" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."includeManagedAppsInBundleIdACL" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."domainRealmMapping" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."domainRealmMapping"."Realm" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."isDefaultRealm" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."customUsernameLabel" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."helpText" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."allowAutomaticLogin" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."requireUserPresence" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."requireTLSForLDAP" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."credentialUseMode" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."preferredKDCs" = {
      minIos = "15.0";
      maxIos = null;
      supervised = false;
    };
    "ExtensionData"."performKerberosOnly" = {
      minIos = "16.0";
      maxIos = null;
      supervised = false;
    };
    "Hosts" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
  };
}
