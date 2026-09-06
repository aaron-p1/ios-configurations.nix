# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "CommonPayloadKeys";
  description = ''
    The properties common to all payloads.
  '';
  options = {
    "PayloadIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        The reverse-DNS-style identifier for the payload. This
        identifier is usually the same as the `TopLevel` value, with
        an additional appended component. This string must be unique
        within the profile.

        During a profile replacement, the system updates payloads
        with the same `PayloadIdentifier` and `PayloadUUID` in the
        old and new profiles.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "PayloadUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The globally unique identifier for the payload. The actual
        content is unimportant, but must be globally unique. In
        macOS, use `uuidgen` to generate UUIDs.

        During a profile replacement, the system updates payloads
        with the same `PayloadIdentifier` and `PayloadUUID` in the
        old and new profiles.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "PayloadType" = mkProfileOpt {
      type = types.str;
      description = ''
        The payload type, which each payload domain's reference page
        specifies.

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
        The version of this specific payload.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "PayloadDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        The human-readable description of this payload. This
        description appears on the Detail screen.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadDisplayName" = mkProfileOpt {
      type = types.str;
      description = ''
        The human-readable name for the profile payload. The name
        appears on the Detail screen and doesn't need to be unique.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PayloadOrganization" = mkProfileOpt {
      type = types.str;
      description = ''
        The human-readable string containing the name of the
        organization that provides the profile. This value doesn't
        need to match the organization payload value in the
        enclosing dictionary.

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
  };
}
