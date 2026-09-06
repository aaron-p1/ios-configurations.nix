# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "TopLevel";
  description = ''
    The top-level payload properties for all profiles.
  '';
  options = {
    "PayloadIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        The reverse-DNS style identifier (`com.example.myprofile`,
        for example) that identifies the profile. The system uses
        this string to determine whether to replace an existing
        profile or add it as a new profile.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "PayloadUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The globally unique identifier for the profile. The actual
        content is unimportant. In macOS, you can use `uuidgen` to
        generate reasonable UUIDs.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "PayloadType" = mkProfileOpt {
      type = (
        types.enum [
          "Configuration"
        ]
      );
      description = ''
        The type of payload. The only supported value is
        `Configuration`.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "PayloadVersion" = mkProfileOpt {
      type = (
        types.enum [
          1
        ]
      );
      description = ''
        The version number of the profile format, which needs to be
        `1`. This number represents the version of the configuration
        profile as a whole, not of the individual profiles within
        it.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "PayloadContent" = mkProfileOpt {
      type = (types.listOf (types.attrsOf types.anything));
      description = ''
        The array of payload dictionaries. If `IsEncrypted` is
        `true`, this array isn't needed.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "EncryptedPayloadContent" = mkProfileOpt {
      type = ios-config-utils.plistDataType;
      description = ''
        Enabled if `IsEncrypted` is `true`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The description of the profile, shown on the Detail screen
        for the profile. Make this description detailed enough to
        help the user decide whether to install the profile.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadDisplayName" = mkProfileOpt {
      type = types.str;
      description = ''
        The human-readable name for the profile, which doesn't need
        to be unique. The system displays this value on the Detail
        screen.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadOrganization" = mkProfileOpt {
      type = types.str;
      description = ''
        The human-readable string that contains the name of the
        organization that provided the profile.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadRemovalDisallowed" = mkProfileOpt {
      type = types.bool;
      description = ''
        If present and set to `true`, the user can't delete the
        profile unless the profile has a removal password and the
        user provides it.

        On macOS 10.15 and later, this key only affects removal of
        _manually_ installed profiles. If set to `true` and no
        profile removal payload is present, removing the profile
        requires admin auth.

        On macOS versions prior to 10.15, this key prevents admins
        from removing MDM installed profiles. However, as of macOS
        10.15, users can never remove MDM profiles, not even the
        admin.

        On iOS users can't remove a MDM profile.

        Requires a supervised device.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
    "PayloadScope" = mkProfileOpt {
      type = (
        types.enum [
          "System"
          "User"
        ]
      );
      description = ''
        A string that defines whether to install the profile for the
        system or the user. In many cases, it determines the
        location of certificate items, such as keychains. Though
        it's not possible to declare different payload scopes,
        payloads like VPN can automatically install their items in
        both scopes, if needed.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "RemovalDate" = mkProfileOpt {
      type = ios-config-utils.dateDataType;
      description = ''
        The date when the system automatically removes the profile.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "DurationUntilRemoval" = mkProfileOpt {
      type = types.float;
      description = ''
        The number of seconds until the profile is automatically
        removed. If the `RemovalDate` key is present, the system
        uses whichever field yields the earliest date.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadExpirationDate" = mkProfileOpt {
      type = ios-config-utils.dateDataType;
      description = ''
        The date when a profile is no longer valid and the system
        presents an update button to the user.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "TargetDeviceType" = mkProfileOpt {
      type = (
        types.enum [
          0
          1
          2
          3
          4
          5
          6
        ]
      );
      description = ''
        The type of platform of the target device. Specifying the
        platform type helps prevent unintended installations.

        For interactive installations on iOS devices, specifying a
        target platform avoids interstitial alerts that prompt the
        user to choose a profile target when multiple targets are
        eligible.

        Allowed values:

        - `0`: Any/unspecified
        - `1`: iPhone/iPad/iPod Touch
        - `2`: Apple Watch
        - `3`: HomePod
        - `4`: Apple TV
        - `5`: Mac
        - `6`: Vision Pro

        Requires: iOS >= 12.2
      '';
      required = false;
    };
    "ConsentText" = mkProfileOpt {
      type = (
        ios-config-utils.subopts {
          "ConsentTextItem" = mkProfileOpt {
            type = (types.attrsOf types.str);
            description = ''
              The dictionary containing a key that consists of the IETF
              BCP 47 identifier for a language (for example, en or jp) and
              a value that consists of the agreement localized to that
              language.

              Requires: iOS >= 4.0
            '';
            required = true;
          };
        }
      );
      description = ''
        A dictionary that includes:

        - A key that contains the IETF BCP 47 identifier for a
        language, such as _en_ or _jp_
        - A value that contains the agreement localized to language
        specified by the key

        The dictionary can also contain an optional key, `default`,
        with its value consisting of the unlocalized (usually in
        _en_) agreement.

        The system always displays the agreement in a dialog, and
        the user needs to agree before the system can install the
        profile.

        The system chooses a localized version in the order of
        preference that the user specifies in macOS, or based on the
        user's current language setting in iOS. If there's no exact
        match, the system uses the default localization. If there's
        no default localization, the system uses the _en_
        localization. If there's no _en_ localization, the system
        uses the first available localization.

        > Tip:
        > Provide a default value, if possible. The system won't
        display a warning if the user's locale doesn't match any
        localization in the `ConsentText` dictionary.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
  };
  supportData = {
    "PayloadIdentifier" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadVersion" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadContent" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EncryptedPayloadContent" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadDescription" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadDisplayName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadOrganization" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadRemovalDisallowed" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "PayloadScope" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "RemovalDate" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "DurationUntilRemoval" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PayloadExpirationDate" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "TargetDeviceType" = {
      minIos = "12.2";
      maxIos = null;
      supervised = false;
    };
    "ConsentText" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ConsentText"."ConsentTextItem" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
  };
}
