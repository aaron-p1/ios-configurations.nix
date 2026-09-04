# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt plistDataType;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.app.lock profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.app.lock";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.app.lock";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "App" = mkProfileOpt {
      type = (
        types.submodule (
          { ... }: {
            options = {
              "Identifier" = mkProfileOpt {
                type = types.str;
                description = ''
                  The app's bundle identifier.
                '';
                required = true;
              };
              "Options" = mkProfileOpt {
                type = (
                  types.submodule (
                    { ... }: {
                      options = {
                        "DisableTouch" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system disables the touch screen. In tvOS, it
                            disables the touch surface on the Apple TV Remote.
                          '';
                          required = false;
                        };
                        "DisableDeviceRotation" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system disables device rotation sensing.
                          '';
                          required = false;
                        };
                        "DisableVolumeButtons" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system disables the volume buttons.
                          '';
                          required = false;
                        };
                        "DisableRingerSwitch" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system disables the ringer switch. When
                            disabled, the ringer behavior depends on what position the
                            switch was in when it was first disabled.
                          '';
                          required = false;
                        };
                        "DisableSleepWakeButton" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system disables the sleep/wake button.
                          '';
                          required = false;
                        };
                        "DisableAutoLock" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the device doesn't automatically go to sleep
                            after an idle period.
                          '';
                          required = false;
                        };
                        "EnableVoiceOver" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system enables VoiceOver.
                          '';
                          required = false;
                        };
                        "EnableZoom" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system enables Zoom.
                          '';
                          required = false;
                        };
                        "EnableInvertColors" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system enables Invert Colors.
                          '';
                          required = false;
                        };
                        "EnableAssistiveTouch" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system enables AssistiveTouch.
                          '';
                          required = false;
                        };
                        "EnableSpeakSelection" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system enables Speak Selection.
                          '';
                          required = false;
                        };
                        "EnableMonoAudio" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system enables Mono Audio.
                          '';
                          required = false;
                        };
                        "EnableVoiceControl" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system enables Voice Control.
                          '';
                          required = false;
                        };
                      };
                    }
                  )
                );
                description = ''
                  A dictionary of options that the user can't change.
                '';
                required = false;
              };
              "UserEnabledOptions" = mkProfileOpt {
                type = (
                  types.submodule (
                    { ... }: {
                      options = {
                        "VoiceControl" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system allows the user to toggle Voice
                            Control.
                          '';
                          required = false;
                        };
                        "VoiceOver" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system allows the user to toggle VoiceOver.
                          '';
                          required = false;
                        };
                        "Zoom" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system allows the user to toggle Zoom.
                          '';
                          required = false;
                        };
                        "InvertColors" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system allows the user to toggle Invert
                            Colors.
                          '';
                          required = false;
                        };
                        "AssistiveTouch" = mkProfileOpt {
                          type = types.bool;
                          description = ''
                            If `true`, the system allows the user to toggle
                            AssistiveTouch.
                          '';
                          required = false;
                        };
                      };
                    }
                  )
                );
                description = ''
                  A dictionary of user-editable options.
                '';
                required = false;
              };
            };
          }
        )
      );
      description = ''
        A dictionary that contains information about the app.
      '';
      required = true;
    };
  };
  supportData = {
    enable = {
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
