# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (ios-config-utils) mkProfileOpt;

  type-id001 =
    {
      counter-id001 ? 2,
      ...
    }@args:
    let
      counters = args // {
        inherit counter-id001;
      };
      decrCounter =
        name:
        if counters ? "counter-${name}" then
          counters // { "counter-${name}" = counters."counter-${name}" - 1; }
        else
          counters;
    in
    if counters ? counter-id001 && counters.counter-id001 <= 0 then
      types.anything
    else
      (types.listOf (
        ios-config-utils.subopts {
          "Type" = mkProfileOpt {
            type = (
              types.enum [
                "Application"
                "Folder"
                "WebClip"
              ]
            );
            description = ''
              The type of the Dock item.

              Requires: iOS >= 9.3; supervised device
            '';
            required = true;
          };
          "DisplayName" = mkProfileOpt {
            type = types.str;
            description = ''
              The human-readable string shown to the user. This setting is
              valid only if the type is `Folder`.

              Requires: iOS >= 9.3; supervised device
            '';
            required = false;
          };
          "BundleID" = mkProfileOpt {
            type = types.str;
            description = ''
              The bundle identifier of the app. This setting is required
              if the type is `Application`.

              Requires: iOS >= 9.3; supervised device
            '';
            required = false;
          };
          "Pages" = mkProfileOpt {
            type = (type-id002 (decrCounter "id002"));
            description = ''
              An array of arrays of dictionaries, each conforming to the
              icon dictionary format. This setting is valid only if the
              type is `Folder`.

              Requires: iOS >= 9.3; supervised device
            '';
            required = false;
          };
          "URL" = mkProfileOpt {
            type = types.str;
            description = ''
              The URL of the existing web clip for this item. This setting
              is required if `type` is `WebClip`. If more than one web
              clip exists with the same URL, the behavior is undefined.

              Specifying a web clip in this payload doesn't create the web
              clip. Use the `WebClip` payload to create a web clip.

              Requires: iOS >= 11.3; supervised device
            '';
            required = false;
          };
        }
      ));

  type-id002 =
    {
      counter-id002 ? 10,
      ...
    }@args:
    let
      counters = args // {
        inherit counter-id002;
      };
      decrCounter =
        name:
        if counters ? "counter-${name}" then
          counters // { "counter-${name}" = counters."counter-${name}" - 1; }
        else
          counters;
    in
    if counters ? counter-id002 && counters.counter-id002 <= 0 then
      types.anything
    else
      (types.listOf (type-id001 (decrCounter "id001")));

in
{
  description = ''
    The payload that configures the Home Screen layout.

    The payload defines a layout of apps, folders, & web clips for the Home screen.

    This payload defines a layout of apps, folders, and web clips for the Home
    Screen. This layout is locked and can't be modified by the user.

    If a Home Screen layout puts more than four items in the iPhone Dock the
    location of the fifth and succeeding items may be undefined but they will not be
    omitted.

    To disable deletion of apps, set `allowAppRemoval` to `false` with
    `Restrictions`.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.homescreenlayout profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.homescreenlayout";
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
    "Dock" = mkProfileOpt {
      type = (type-id001 { });
      description = ''
        An array of dictionaries, each of which must conform to the
        icon dictionary format. If this key isn't present, the
        user's Dock is empty.

        Requires: iOS >= 9.3; supervised device
      '';
      required = false;
    };
    "Pages" = mkProfileOpt {
      type = (type-id002 { });
      description = ''
        An array of arrays of dictionaries, each of which must
        conform to the icon dictionary format.

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
    "Dock" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."Type" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."DisplayName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."BundleID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."Pages" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."Pages"."*"."Type" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."Pages"."*"."DisplayName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."Pages"."*"."BundleID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."Pages"."*"."Pages" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."Pages"."*"."URL" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "Dock"."*"."URL" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "Pages" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."Type" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."DisplayName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."BundleID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."Pages" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."Pages"."*"."Type" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."Pages"."*"."DisplayName" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."Pages"."*"."BundleID" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."Pages"."*"."Pages" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."Pages"."*"."URL" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "Pages"."*"."URL" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
  };
}
