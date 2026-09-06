# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.networkusagerules";
  description = ''
    The payload that configures network-usage rules.

    Network Usage Rules allow enterprises to specify how devices use networks, such
    as cellular data networks. iOS 9-12 support only ApplicationRules. In iOS 13,
    ApplicationRules, SIMRules, or both must be present.

    Network usage rules allow enterprises to specify how devices use networks, such
    as cellular data networks. iOS 9-12 require the application rules. In iOS 13,
    application rules, SIM rules, or both must be present.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.networkusagerules profile";
    "ApplicationRules" = mkProfileOpt {
      type = (
        types.listOf (
          ios-config-utils.subopts {
            "AppIdentifierMatches" = mkProfileOpt {
              type = (types.listOf types.str);
              description = ''
                A list of managed app identifiers, as strings, that must
                follow the associated rules. If this key is missing, the
                rules apply to all managed apps on the device.



                Each string in the `AppIdentifierMatches` array may either
                be an exact app identifier match (for example,
                `com.mycompany.myapp`) or it may specify a prefix match for
                the bundle ID by using the \* wildcard character. If used,
                this character must appear after a period (.) and may only
                appear once, at the end of the string; for example,
                `com.mycompany.*`.

                Requires: iOS >= 9.0
              '';
              required = false;
            };
            "AllowRoamingCellularData" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `false`, disables cellular data while roaming for all
                matching managed apps.

                Requires: iOS >= 9.0
              '';
              required = false;
            };
            "AllowCellularData" = mkProfileOpt {
              type = types.bool;
              description = ''
                If `false`, disables cellular data for all matching managed
                apps.

                Requires: iOS >= 9.0
              '';
              required = false;
            };
          }
        )
      );
      description = ''
        An array of application rules, that apply to only managed
        apps.

        Requires: iOS >= 9.0
      '';
      required = false;
    };
    "SIMRules" = mkProfileOpt {
      type = (
        types.listOf (
          ios-config-utils.subopts {
            "ICCIDs" = mkProfileOpt {
              type = (types.listOf types.str);
              description = ''
                One or more ICCIDs of SIM cards for which the
                `WiFiAssistPolicy` applies. All ICCIDs in all installed
                Network Usage Rules payloads must be unique. An example
                ICCID is `89310410106543789301`.

                Requires: iOS >= 13.0
              '';
              required = true;
            };
            "WiFiAssistPolicy" = mkProfileOpt {
              type = (
                types.enum [
                  2
                  3
                ]
              );
              description = ''
                The Wi-Fi Assist policy to apply to the SIM cards specified
                in the ICCIDs. Allowed values:

                - `2`: Use the default system policy for the specified SIM
                card(s).
                - `3`: Make Wi-Fi Assist switch more aggressively from a
                poor Wi-Fi connection to cellular data for the specified SIM
                card(s). This setting may increase cellular data use and may
                impact battery life.

                For more information, see [About Wi-Fi
                Assist](https://support.apple.com/en-us/HT205296).

                Requires: iOS >= 13.0
              '';
              required = true;
            };
          }
        )
      );
      description = ''
        An array of SIM rules, that apply to all apps.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "ApplicationRules" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "ApplicationRules"."*"."AppIdentifierMatches" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "ApplicationRules"."*"."AllowRoamingCellularData" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "ApplicationRules"."*"."AllowCellularData" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "SIMRules" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "SIMRules"."*"."ICCIDs" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "SIMRules"."*"."WiFiAssistPolicy" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
  };
}
