# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures notifications.

    A notification settings payload specifies the restriction enforced notification
    settings for apps using their bundle identifier. The profile specifies
    notification settings by bundle identifier (even for apps that aren’t installed
    on the device yet), and those settings will always be enforced.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.notificationsettings profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.notificationsettings";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
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
    "NotificationSettings" = mkProfileOpt {
      type = (
        types.listOf (
          ios-config-utils.subopts {
            "BundleIdentifier" = mkProfileOpt {
              type = types.str;
              description = ''
                The bundle identifier of the app to which to apply these
                notification settings.

                Available in iOS 9.3 and later and macOS 10.15 and later.

                Requires: iOS >= 9.3; supervised device
              '';
              required = true;
            };
            "NotificationsEnabled" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, enables notifications for this app.

                Available in iOS 9.3 and later and macOS 10.15 and later.

                Requires: iOS >= 9.3; supervised device
              '';
              required = false;
            };
            "ShowInNotificationCenter" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, enables notifications in the notification center
                for this app.

                Available in iOS 9.3 and later and macOS 10.15 and later.

                Requires: iOS >= 9.3; supervised device
              '';
              required = false;
            };
            "ShowInLockScreen" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, enables notifications on the Lock Screen for this
                app.

                Available in iOS 9.3 and later and macOS 10.15 and later.

                Requires: iOS >= 9.3; supervised device
              '';
              required = false;
            };
            "AlertType" = mkProfileOpt {
              type = (
                types.enum [
                  0
                  1
                  2
                ]
              );
              description = ''
                The type of alert for notifications for this app:

                - `0`: None
                - `1`: Temporary Banner
                - `2`: Persistent Banner

                Available in iOS 9.3 and later and macOS 10.15 and later.

                Requires: iOS >= 9.3; supervised device
              '';
              required = false;
            };
            "BadgesEnabled" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, enables badges for this app.

                Available in iOS 9.3 and later and macOS 10.15 and later.

                Requires: iOS >= 9.3; supervised device
              '';
              required = false;
            };
            "SoundsEnabled" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, enables sounds for this app.

                Requires: iOS >= 9.3; supervised device
              '';
              required = false;
            };
            "ShowInCarPlay" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, enables notifications in CarPlay for this app.

                Available in iOS 12 and later.

                Requires: iOS >= 12.0; supervised device
              '';
              required = false;
            };
            "CriticalAlertEnabled" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `true`, enables critical alerts that can ignore Do Not
                Disturb and ringer settings for this app.

                Available in iOS 12 and later and macOS 10.15 and later.

                Requires: iOS >= 12.0; supervised device
              '';
              required = false;
            };
            "GroupingType" = mkProfileOpt {
              type = (
                types.enum [
                  0
                  1
                  2
                ]
              );
              description = ''
                The type of grouping for notifications for this app:

                - `0`: Automatic: Group notifications into app-specified
                groups.
                - `1`: By app: Group notifications into one group.
                - `2`: Off: Don't group notifications.

                Available in iOS 12 and later.

                Requires: iOS >= 12.0; supervised device
              '';
              required = false;
            };
            "PreviewType" = mkProfileOpt {
              type = (
                types.enum [
                  0
                  1
                  2
                ]
              );
              description = ''
                The type previews for notifications. This key overrides the
                value at Settings>Notifications>Show Previews.

                - `0` - Always: Previews will be shown when the device is
                locked and unlocked
                - `1` - When Unlocked: Previews will only be shown when the
                device is unlocked
                - `2` - Never: Previews will never be shown

                Available in iOS 14 and later.

                Requires: iOS >= 14.0; supervised device
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        An array of notification settings dictionaries.

        Requires: iOS >= 9.3; supervised device
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."BundleIdentifier" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."NotificationsEnabled" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."ShowInNotificationCenter" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."ShowInLockScreen" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."AlertType" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."BadgesEnabled" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."SoundsEnabled" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."ShowInCarPlay" = {
      minIos = "12.0";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."CriticalAlertEnabled" = {
      minIos = "12.0";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."GroupingType" = {
      minIos = "12.0";
      maxIos = null;
      supervised = true;
    };
    "NotificationSettings"."*"."PreviewType" = {
      minIos = "14.0";
      maxIos = null;
      supervised = true;
    };
  };
}
