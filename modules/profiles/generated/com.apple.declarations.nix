# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.declarations";
  description = ''
    The payload that applies a set of declarations to the device through the
    Settings app.

    This profile applies a set of declarations to the device. Users use this profile
    to install declarations without requiring an MDM enrollment. A device management
    server can't install a configuration profile containing this payload type.
    Device management servers need to use declarative device management to install
    declarations.

    > Important:
    > When a user installs the profile, the device only applies configuration
    declarations that allow a "local" enrollment. Consult the documentation for each
    configuration type to see if you can use it.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.declarations profile";
    "Declarations" = mkProfileOpt {
      type = (types.listOf ios-config-utils.plistDataType);
      description = ''
        The set of declarations to apply. The array items are
        Base64-encoded data representations of the declaration JSON
        data.

        Requires: iOS >= 17.0
      '';
      required = true;
    };
  };
  supportData = {
    "enable" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Declarations" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
  };
}
