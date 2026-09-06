# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.mdm profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.mdm";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.mdm";
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
    "IdentityCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the certificate payload for the device's
        identity. It may also point to a SCEP payload.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "Topic" = mkProfileOpt {
      type = types.str;
      description = ''
        The topic that MDM listens to for push notifications. The
        certificate that the server uses to send push notifications
        must have the same topic in its subject. The topic must
        begin with the 'com.apple.mgmt.' prefix.

        > Note:
        > When updating the payload, the value of this key must not
        change. Any change is an error, and the update is rejected.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "ServerURL" = mkProfileOpt {
      type = (types.strMatching "^https://.*$");
      description = ''
        The URL that the device contacts to retrieve device
        management instructions. The URL must begin with the
        `https://` URL scheme, and may contain a port number
        (`:1234`, for example).

        > Note:
        > When updating the payload, the value of this key must not
        change. Any change is an error, and the update is rejected.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "CheckInURL" = mkProfileOpt {
      type = (types.strMatching "^https://.*$");
      description = ''
        The URL that the device should use to check in during
        installation. The URL must begin with the `https://` URL
        scheme and may contain a port number (`:1234`, for example).
        If not set, the system uses `ServerURL`.

        > Note:
        > When updating the payload, the value of this key must not
        change. Any change is an error, and the update is rejected.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "SignMessage" = mkProfileOpt {
      type = types.bool;
      description = ''
        If 'true', each message coming from the device carries the
        additional 'Mdm-Signature' HTTP header.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "AccessRights" = mkProfileOpt {
      type = types.int;
      description = ''
        Logical OR of the following bit flags:

        - `1`: Allow inspection of installed configuration profiles.
        - `2`: Allow installation and removal of configuration
        profiles.
        - `4`: Allow device lock and passcode removal.
        - `8`: Allow device erase.
        - `16`: Allow query of device information (device capacity,
        serial number).
        - `32`: Allow query of network information (phone/SIM
        numbers, MAC addresses).
        - `64`: Allow inspection of installed provisioning profiles.
        - `128`: Allow installation and removal of provisioning
        profiles.
        - `256`: Allow inspection of installed applications.
        - `512`: Allow restriction-related queries.
        - `1024`: Allow security-related queries.
        - `2048`: Allow manipulation of settings.
        - `4096`: Allow app management.

        Don't set to `0`. Specify `1` if you specify `2`. Specify
        `64` if you specify `128`. Ignored if you set a value for
        `ManagedAppleID`.

        > Note:
        > When updating the payload, the addition of any access
        right is an error, and the update is rejected.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "UseDevelopmentAPNS" = mkProfileOpt {
      type = types.bool;
      description = ''
        If 'true', the device uses the development APNS servers.
        Otherwise, the device uses the production servers.
        Set to 'false' if your Apple Push Notification Service
        certificate was issued by the Apple Push Certificate Portal
        ('https://identity.apple.com/pushcert'). That portal only
        issues certificates for the production push environment.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ManagedAppleID" = mkProfileOpt {
      type = types.str;
      description = ''
        The Managed Apple Account of the user. Previously required
        for profile-driven user enrollment.
        Removed as of iOS 18 and macOS 15.

        Requires: iOS >= 13.1 and < 18.0
        Deprecated in iOS 17.0
      '';
      required = false;
    };
    "AssignedManagedAppleID" = mkProfileOpt {
      type = types.str;
      description = ''
        The Managed Apple Account pre-assigned to the authenticated
        user. Required for account-driven enrollments. Available in
        iOS 15 and later, and macOS 14 and later.

        > Note:
        > When updating the payload, the value of this key must not
        change. Any change is an error, and the update is rejected.

        Requires: iOS >= 15.0
      '';
      required = false;
    };
    "EnrollmentMode" = mkProfileOpt {
      type = (
        types.enum [
          "BYOD"
          "ADDE"
        ]
      );
      description = ''
        The enrollment mode the server indicates to use when
        enrolling. Required for account-driven enrollment. Available
        in iOS 15 and macOS 14, and later.

        > Note:
        > When updating the payload, the value of this key must not
        change. Any change is an error, and the update is rejected.

        Requires: iOS >= 15.0
      '';
      required = false;
    };
    "ServerURLPinningCertificateUUIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of strings, each containing the UUID of a
        certificate to use when evaluating trust to the
        '.../connect/' URLs of MDM servers.

        Requires: iOS >= 13.4
      '';
      required = false;
    };
    "CheckInURLPinningCertificateUUIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of strings, each containing the payload UUID of a
        certificate to use when evaluating trust to the
        '.../checkin/' URLs of MDM servers.

        Requires: iOS >= 13.4
      '';
      required = false;
    };
    "PinningRevocationCheckRequired" = mkProfileOpt {
      type = types.bool;
      description = ''
        If 'true', the system fails the connection attempt unless it
        obtains a verified positive response during certificate
        revocation checks.
        If 'false', the system performs revocation checks on a best-
        attempt basis, where failure to reach the server isn't
        considered fatal.

        Requires: iOS >= 13.4
      '';
      required = false;
    };
    "ServerCapabilities" = mkProfileOpt {
      type = (
        types.listOf (
          types.enum [
            "com.apple.mdm.per-user-connections"
            "com.apple.mdm.bootstraptoken"
            "com.apple.mdm.token"
          ]
        )
      );
      description = ''
        A unique array of strings indicating server capabilities:

        - `com.apple.mdm.per-user-connections`: Indicates that the
        server supports both device and user connections. This must
        be present when managing Shared iPad or macOS devices.
        - `com.apple.mdm.bootstraptoken`: Indicates that the server
        supports escrowing the bootstrap token. This must be present
        for the device to create a bootstrap token and send it to
        the server. Available in iOS 26 and later, macOS 11 and
        later, and visionOS 26 and later.
        - `com.apple.mdm.token`: Indicates that the server supports
        the `Get-Token` CheckIn message type. This must be present
        for the device to use `Get-Token` CheckIn message when
        appropriate.

        > Note:
        > When updating the payload, the `com.apple.mdm.per-user-
        connections` capability must not be added or removed. Any
        such change is an error, and the update is rejected.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "CheckOutWhenRemoved" = mkProfileOpt {
      type = types.bool;
      description = ''
        If 'true', the device attempts to send a `Check-Out` message
        to the 'CheckInURL' when the profile is removed.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "RequiredAppIDForMDM" = mkProfileOpt {
      type = types.int;
      description = ''
        This property specifies an iTunes Store ID for an app the
        system can install with the InstallApplicationCommand,
        without any approval from the user. The MDM vendor or
        managing organization generally provides this app, which
        enhances the management experience for the user. The device
        shows the user details about this app in the account-driven
        enrollment process prior to installing the MDM profile. Use
        this property with account-driven MDM enrollments that
        normally require user approval for app installs through MDM.
        Only account-driven enrollments support this property and
        other enrollment types ignore it.
        Available in iOS 15.1 and later.

        > Note:
        > When updating the payload, the value of this key must not
        change. Any change is an error, and the update is rejected.

        Requires: iOS >= 15.1
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
    "IdentityCertificateUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Topic" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ServerURL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CheckInURL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SignMessage" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "AccessRights" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "UseDevelopmentAPNS" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ManagedAppleID" = {
      minIos = "13.1";
      maxIos = "18.0";
      supervised = false;
    };
    "AssignedManagedAppleID" = {
      minIos = "15.0";
      maxIos = null;
      supervised = false;
    };
    "EnrollmentMode" = {
      minIos = "15.0";
      maxIos = null;
      supervised = false;
    };
    "ServerURLPinningCertificateUUIDs" = {
      minIos = "13.4";
      maxIos = null;
      supervised = false;
    };
    "CheckInURLPinningCertificateUUIDs" = {
      minIos = "13.4";
      maxIos = null;
      supervised = false;
    };
    "PinningRevocationCheckRequired" = {
      minIos = "13.4";
      maxIos = null;
      supervised = false;
    };
    "ServerCapabilities" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CheckOutWhenRemoved" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "RequiredAppIDForMDM" = {
      minIos = "15.1";
      maxIos = null;
      supervised = false;
    };
  };
}
