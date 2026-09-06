# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The profile that configures web clips on the device.

    Use this payload to add web clips to the Home Screen of the user's iOS device or
    to the Dock on a Mac. Web clips provide fast access to favorite webpages.

    For iOS devices, if you prevent the user from removing the web clip, the only
    way to remove it is to remove the configuration profile that installed it. Also,
    for iOS devices it must have a display name and an icon URL for the payload to
    be valid.

    A full-screen web clip on iOS devices opens the URL as a web app without a
    browser; there's no URL, search bar, or bookmarks.

    For Shared iPad devices, the system supports this payload on the user channel
    only.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.webClip.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.webClip.managed";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "ios-configurations.webClip.managed";
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
    "Precomposed" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system prevents SpringBoard from adding shine
        to the icon.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "FullScreen" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system launches the web clip as a full-screen
        web app.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "URL" = mkProfileOpt {
      type = types.str;
      description = ''
        The URL of the web clip.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "Icon" = mkProfileOpt {
      type = utils.plistDataType;
      description = ''
        The PNG icon to show on the Home Screen. If not set, the
        system displays a white square. For best results, provide a
        square image that's no larger than 400 x 400 pixels and less
        than 1 MB when uncompressed. The graphics file is
        automatically scaled and cropped to fit, if necessary, and
        converted to PNG format. Web clip icons are 144 x 144 pixels
        for iPad devices with a Retina display, and 114 x 114 pixels
        for iPhone devices. To prevent the device from adding a
        shine to the image, set `Precomposed` to `true`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IsRemovable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables removing the web clip.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "Label" = mkProfileOpt {
      type = types.str;
      description = ''
        The name of the web clip that the system displays on the
        Home Screen.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "IgnoreManifestScope" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, a full screen web clip can navigate to an
        external web site without showing Safari UI. Otherwise,
        Safari UI appears when navigating away from the web clip's
        URL. This key has no effect when `FullScreen` is `false`.
        Available in iOS 14 and later.

        Requires: iOS >= 14.0
      '';
      required = false;
    };
    "TargetApplicationBundleIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        The application bundle identifier of the application that
        opens the URL. To use this property, install the profile
        through MDM. Available in iOS 14 and later.

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
    "Precomposed" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "FullScreen" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "URL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Icon" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IsRemovable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Label" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IgnoreManifestScope" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "TargetApplicationBundleIdentifier" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
  };
}
