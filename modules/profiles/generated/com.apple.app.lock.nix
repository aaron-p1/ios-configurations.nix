# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a device to run a single app.

    With an app lock profile, the device locks to the specified app until removal of
    the profile. The device returns to the app automatically upon wake or restart.

    Only use an app lock payload after installing the target app.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.app.lock profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.app.lock";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "ios-configurations.app.lock";
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
    "App" = mkProfileOpt {
      type = (
        utils.subopts {
          "Identifier" = mkProfileOpt {
            type = types.str;
            description = ''
              The app's bundle identifier.

              Requires: iOS >= 6.0; supervised device
            '';
            required = true;
          };
          "Options" = mkProfileOpt {
            type = (
              utils.subopts {
                "DisableTouch" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system disables the touch screen. In tvOS, it
                    disables the touch surface on the Apple TV Remote.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "DisableDeviceRotation" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system disables device rotation sensing.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "DisableVolumeButtons" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system disables the volume buttons.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "DisableRingerSwitch" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system disables the ringer switch. When
                    disabled, the ringer behavior depends on what position the
                    switch was in when it was first disabled.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "DisableSleepWakeButton" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system disables the sleep/wake button.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "DisableAutoLock" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the device doesn't automatically go to sleep
                    after an idle period.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "EnableVoiceOver" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system enables VoiceOver.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "EnableZoom" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system enables Zoom.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "EnableInvertColors" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system enables Invert Colors.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "EnableAssistiveTouch" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system enables AssistiveTouch.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "EnableSpeakSelection" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system enables Speak Selection.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "EnableMonoAudio" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system enables Mono Audio.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "EnableVoiceControl" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system enables Voice Control.

                    Requires: iOS >= 13.0; supervised device
                  '';
                  required = false;
                };
              }
            );
            description = ''
              A dictionary of options that the user can't change.

              Requires: iOS >= 7.0; supervised device
            '';
            required = false;
          };
          "UserEnabledOptions" = mkProfileOpt {
            type = (
              utils.subopts {
                "VoiceControl" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system allows the user to toggle Voice
                    Control.

                    Requires: iOS >= 13.0; supervised device
                  '';
                  required = false;
                };
                "VoiceOver" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system allows the user to toggle VoiceOver.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "Zoom" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system allows the user to toggle Zoom.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "InvertColors" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system allows the user to toggle Invert
                    Colors.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
                "AssistiveTouch" = mkProfileOpt {
                  type = types.bool;
                  description = ''
                    If `true`, the system allows the user to toggle
                    AssistiveTouch.

                    Requires: iOS >= 7.0; supervised device
                  '';
                  required = false;
                };
              }
            );
            description = ''
              A dictionary of user-editable options.

              Requires: iOS >= 7.0; supervised device
            '';
            required = false;
          };
        }
      );
      description = ''
        A dictionary that contains information about the app.

        Requires: iOS >= 6.0; supervised device
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "App" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Identifier" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."DisableTouch" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."DisableDeviceRotation" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."DisableVolumeButtons" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."DisableRingerSwitch" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."DisableSleepWakeButton" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."DisableAutoLock" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."EnableVoiceOver" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."EnableZoom" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."EnableInvertColors" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."EnableAssistiveTouch" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."EnableSpeakSelection" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."EnableMonoAudio" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."Options"."EnableVoiceControl" = {
      minIos = "13.0";
      maxIos = null;
      supervised = true;
    };
    "App"."UserEnabledOptions" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."UserEnabledOptions"."VoiceControl" = {
      minIos = "13.0";
      maxIos = null;
      supervised = true;
    };
    "App"."UserEnabledOptions"."VoiceOver" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."UserEnabledOptions"."Zoom" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."UserEnabledOptions"."InvertColors" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "App"."UserEnabledOptions"."AssistiveTouch" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
  };
}
