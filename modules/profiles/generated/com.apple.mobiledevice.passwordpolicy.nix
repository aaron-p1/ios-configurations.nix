# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a passcode policy.

    The presence of this payload type causes the device to present the user with a
    passcode entry mechanism. The payload controls the complexity of the passcode.

    For user enrollments, the system allows this payload type, but ignores most of
    the keys. Instead, the presence of the payload forces only these settings:

    - `allowSimple`: always set to `false`
    - `forcePIN`: always set to `true`
    - `minLength`: always set to `6`
    - `maxInactivity`: if this key is present its value is ignored, but the `never`
    option is removed in the Settings UI.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.mobiledevice.passwordpolicy profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.mobiledevice.passwordpolicy";
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
    "allowSimple" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents use of a simple passcode. A
        simple passcode contains repeated characters, or increasing
        or decreasing characters, such as `123` or `CBA`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "forcePIN" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system forces the user to enter a PIN.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "maxFailedAttempts" = mkProfileOpt {
      type = (types.ints.between 2 11);
      description = ''
        The number of failed passcode attempts that the system
        allows the user before it erases or locks the device. After
        six failed attempts, the device imposes a time delay before
        the user can enter a passcode again. The time delay
        increases with each failed attempt. On macOS, set
        `minutesUntilFailedLoginReset` to define the time delay. The
        time delay begins after the sixth attempt, so if
        `MaximumFailedAttempts` is six or lower, the system has no
        time delay and triggers the erase or lock as soon as the
        user exceeds the limit.

        After the final failed attempt, the system locks a macOS
        device, or securely erases all data and settings from an
        iOS, visionOS, or watchOS device.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "maxInactivity" = mkProfileOpt {
      type = (types.ints.between 0 15);
      description = ''
        The maximum number of minutes for which the device can be
        idle without the user unlocking it, before the system locks
        it. When this limit is reached, the system locks the device
        and the passcode is required to unlock it. The user can edit
        this setting, but the value can't exceed the `maxInactivity`
        value.

        On macOS, the system translates this inactivity value to
        screen-saver settings. The maximum value for macOS is `60`.

        Setting this key removes the `never` option in the Settings
        UI on user enrolled devices.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "maxPINAgeInDays" = mkProfileOpt {
      type = (types.ints.between 1 730);
      description = ''
        The number of days for which the passcode can remain
        unchanged. After this number of days, the system forces the
        user to change the passcode before it unlocks the device.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "minComplexChars" = mkProfileOpt {
      type = (types.ints.between 0 4);
      description = ''
        The minimum number of complex characters that a passcode
        needs to contain. A _complex_ character is a character other
        than a number or a letter, such as `&`, `%`, `$`, and `#`.

        The system ignores this property for user enrollments.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "minLength" = mkProfileOpt {
      type = (types.ints.between 0 16);
      description = ''
        The minimum overall length of the passcode. This value is
        independent of the value for `minComplexChars`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "requireAlphanumeric" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system requires alphabetic characters instead
        of only numeric characters.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "pinHistory" = mkProfileOpt {
      type = (types.ints.between 1 50);
      description = ''
        This value defines _N_, where the new passcode must be
        unique within the last _N_ entries in the passcode history.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "maxGracePeriod" = mkProfileOpt {
      type = types.int;
      description = ''
        The maximum grace period, in minutes, to unlock the phone
        without entering a passcode. The default is `0`, which is no
        grace period and requires a passcode immediately. On macOS,
        the system translates this grace period value to screen-
        saver settings.

        Requires: iOS >= 4.0
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
    "allowSimple" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "forcePIN" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "maxFailedAttempts" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "maxInactivity" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "maxPINAgeInDays" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "minComplexChars" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "minLength" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "requireAlphanumeric" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "pinHistory" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "maxGracePeriod" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
  };
}
