# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.education profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.education";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.education";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "OrganizationUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The organization's UUID identifier. This identifier can be
        any valid UUID. All teacher and student devices that need to
        communicate with one another must have the same organization
        UUID, particularly if they originated from different Device
        Enrollment Programs.

        Requires: iOS >= 9.3
      '';
      required = true;
    };
    "OrganizationName" = mkProfileOpt {
      type = types.str;
      description = ''
        The organization's display name. The system displays this
        name in the iOS login screen.

        Requires: iOS >= 9.3
      '';
      required = true;
    };
    "PayloadCertificateUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The UUID of an identity certificate payload within the same
        profile to use for performing client authentication with
        other devices. This property supports PKCS12 certificates.

        Required to configure Classroom. Has no effect on the
        configuration of the Shared iPad login screen.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "LeaderPayloadCertificateAnchorUUID" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        The array of UUIDs referring to certificate payloads within
        the same profile that the system uses to authorize leader
        peer certificate identities. This array needs to contain all
        necessary certificates to validate the entire chain of
        trust. Leader certificates needs to have the common name
        prefix leader, which is case insensitive.

        This property doesn't support identity payloads or PKCS12
        certificates.

        Required when configuring a student device for Classroom,
        and ignored when configuring an instructor device. Has no
        effect on the configuration of the Shared iPad login screen.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "MemberPayloadCertificateAnchorUUID" = mkProfileOpt {
      type = types.listOf types.str;
      description = ''
        The array of UUIDs referring to certificate payloads within
        the same profile that the system uses to authorize group
        member peer certificate identities. This array must contain
        all certificates needed to validate the entire chain of
        trust. Member certificates must have the common name prefix
        member (case insensitive).

        This property doesn't support identity payloads or PKCS12
        certificates.

        Required when configuring a student device for Classroom,
        and ignored when configuring an instructor device. Has no
        effect on the configuration of the Shared iPad login screen.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "ResourcePayloadCertificateUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The UUID of an identity certificate payload within the same
        profile that the system uses to perform client
        authentication when fetching additional resources, such as
        student images.

        If set, the system uses this key to configure both Classroom
        and the Shared iPad login screen. If not set, the system
        uses MDM client identity.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "UserIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        The unique string that identifies the user of this device
        within the organization.

        Don't set this value in payloads intended to configure the
        Shared iPad login screen.

        Requires: iOS >= 9.3
      '';
      required = true;
    };
    "Departments" = mkProfileOpt {
      type = types.listOf (
        utils.subopts {
          "Name" = mkProfileOpt {
            type = types.str;
            description = ''
              The display name of the department.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "GroupBeaconIDs" = mkProfileOpt {
            type = types.listOf types.int;
            description = ''
              The group beacon identifiers that are members of this
              department.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
        }
      );
      description = ''
        _For Shared iPad profiles:_ The array of dictionaries that
        defines which departments the system displays in the Shared
        iPad login screen. If set, the system uses this key to
        configure both Classroom and the Shared iPad login screen.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "Groups" = mkProfileOpt {
      type = types.listOf (
        utils.subopts {
          "BeaconID" = mkProfileOpt {
            type = types.int;
            description = ''
              An unsigned 16 bit integer specifying this group's unique
              beacon ID.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "Name" = mkProfileOpt {
            type = types.str;
            description = ''
              The display name of the group.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "Description" = mkProfileOpt {
            type = types.str;
            description = ''
              The description of the group.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "ImageURL" = mkProfileOpt {
            type = types.str;
            description = ''
              Deprecated in iOS 9.3.1 and later. The URL of an image for
              the group.

              Requires: iOS >= 9.3
              Deprecated in iOS 9.3.1
            '';
            required = false;
          };
          "ConfigurationSource" = mkProfileOpt {
            type = types.str;
            description = ''
              The source that provided this group, such as SIS, or MDM.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "LeaderIdentifiers" = mkProfileOpt {
            type = types.listOf types.str;
            description = ''
              The user identifiers that are leaders of this group.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "MemberIdentifiers" = mkProfileOpt {
            type = types.listOf types.str;
            description = ''
              The entries in the Users array that are members of the
              group.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "DeviceGroupIdentifiers" = mkProfileOpt {
            type = types.listOf types.str;
            description = ''
              The identifiers that refer to entries in the `DeviceGroups`
              array to which the instructor can assign users from this
              class.

              Has no effect on the configuration of the Shared iPad login
              screen.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
        }
      );
      description = ''
        _For Shared iPad profiles:_ The array of dictionaries that
        defines which groups the user can select in the Login
        Window.

        _For leader/teacher profiles:_ The array of dictionaries
        that defines the groups that the user can control.

        _For member/student profiles:_ The array of dictionaries
        that defines the groups where the user is a member.

        Requires: iOS >= 9.3
      '';
      required = true;
    };
    "Users" = mkProfileOpt {
      type = types.listOf (
        utils.subopts {
          "Identifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The unique identifier for a user in the organization.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "Name" = mkProfileOpt {
            type = types.str;
            description = ''
              The name of the user.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "GivenName" = mkProfileOpt {
            type = types.str;
            description = ''
              The given name of the user.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "FamilyName" = mkProfileOpt {
            type = types.str;
            description = ''
              The family name of the user.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "PhoneticGivenName" = mkProfileOpt {
            type = types.str;
            description = ''
              The user's phonetic given name. The system uses this name to
              sort users in the Classroom app and the Shared iPad Login
              Screen.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "PhoneticFamilyName" = mkProfileOpt {
            type = types.str;
            description = ''
              The user's phonetic family name. The system uses this name
              to sort users in the Classroom app and the Shared iPad login
              screen.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "ImageURL" = mkProfileOpt {
            type = types.str;
            description = ''
              A string that contains a URL pointing to an image of the
              user. The system displays this image in the iOS login screen
              and in the Classroom app. The recommended resolution is 256
              x 256 pixels (512 x 512 pixels on a 2x device). The
              recommended formats are JPEG, PNG, and TIFF. The system uses
              the `ResourcePayloadCertificateUUID` identity certificate or
              the MDM client identity to perform authentication when
              fetching the image.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "FullScreenImageURL" = mkProfileOpt {
            type = types.str;
            description = ''
              Deprecated in iOS 9.3.1 and later. The URL pointing to an
              image of the user. The system uses the
              `ResourcePayloadCertificateUUID` identity certificate or the
              MDM client identity to perform authentication when fetching
              the specified resource.

              Requires: iOS >= 9.3
              Deprecated in iOS 9.3.1
            '';
            required = false;
          };
          "AppleID" = mkProfileOpt {
            type = types.str;
            description = ''
              The Managed Apple Account for this user.

              Not required to configure Classroom, but if set the system
              uses it.

              Required to configure the Shared iPad login screen.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
          "PasscodeType" = mkProfileOpt {
            type = (
              types.enum [
                "complex"
                "four"
                "six"
              ]
            );
            description = ''
              The type of passcode UI to show when the user is at the
              Login Window.

              Requires: iOS >= 9.3
            '';
            required = false;
          };
        }
      );
      description = ''
        For Shared iPad profiles: The array of dictionaries that
        define the users that the system displays in the iOS Login
        Window.

        _For leader/teacher profiles:_ The array of dictionaries
        that define users that are members of the teacher's groups.

        _For member/student profiles:_ The array of dictionaries
        that needs to contain the definition of the user specified
        in the `UserIdentifier` key. With one-to-one member devices,
        this key should include only the device user and the teacher
        but not other class members.

        Requires: iOS >= 9.3
      '';
      required = true;
    };
    "DeviceGroups" = mkProfileOpt {
      type = types.listOf (
        utils.subopts {
          "Identifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The unique identifier for the device group in the
              organization.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "Name" = mkProfileOpt {
            type = types.str;
            description = ''
              The name of the device group, which must be unique in the
              organization.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
          "SerialNumbers" = mkProfileOpt {
            type = types.listOf types.str;
            description = ''
              The serial numbers of the devices in the group.

              Requires: iOS >= 9.3
            '';
            required = true;
          };
        }
      );
      description = ''
        _For leader/teacher profiles:_ The array of dictionaries
        that defines which device groups the leader can assign
        devices to. Not included in member payloads.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "ScreenObservationPermissionModificationAllowed" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system allows students enrolled in managed
        classes to modify their teacher's permissions for screen
        observation on their device.

        Requires: iOS >= 10.3
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "OrganizationUUID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "OrganizationName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "PayloadCertificateUUID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "LeaderPayloadCertificateAnchorUUID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "MemberPayloadCertificateAnchorUUID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "ResourcePayloadCertificateUUID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "UserIdentifier" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Departments" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Departments"."*"."Name" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Departments"."*"."GroupBeaconIDs" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."BeaconID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."Name" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."Description" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."ImageURL" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."ConfigurationSource" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."LeaderIdentifiers" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."MemberIdentifiers" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Groups"."*"."DeviceGroupIdentifiers" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."Identifier" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."Name" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."GivenName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."FamilyName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."PhoneticGivenName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."PhoneticFamilyName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."ImageURL" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."FullScreenImageURL" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."AppleID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "Users"."*"."PasscodeType" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "DeviceGroups" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "DeviceGroups"."*"."Identifier" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "DeviceGroups"."*"."Name" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "DeviceGroups"."*"."SerialNumbers" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "ScreenObservationPermissionModificationAllowed" = {
      minIos = "10.3";
      maxIos = null;
      supervised = false;
    };
  };
}
