# Generated from import-profiles.py. Do not edit.
{ lib, ios-config-utils, ... }:
let
  inherit (lib) types;
  inherit (ios-config-utils) mkProfileOpt;
in
{
  payloadType = "com.apple.cellularprivatenetwork.managed";
  description = ''
    The payload that provides device info on private network deployments, including
    geographical location, preference over Wi-Fi, and network deployment type.

    Payload can be used to provide device info on private network deployments
    including geographical location, preference over Wi-Fi, and network deployment
    type. Only five Cellular Private Networks can be configured simultaneously.
  '';
  options = {
    enable = lib.mkEnableOption "Enable the com.apple.cellularprivatenetwork.managed profile";
    "Geofences" = mkProfileOpt {
      type = (
        types.listOf (
          ios-config-utils.subopts {
            "Longitude" = mkProfileOpt {
              type = (ios-config-utils.floatBetween (-180.0) (180.0));
              description = ''
                The longitude of the geofence.

                Requires: iOS >= 17.0
              '';
              required = true;
            };
            "Latitude" = mkProfileOpt {
              type = (ios-config-utils.floatBetween (-90.0) (90.0));
              description = ''
                The latitude of the geofence.

                Requires: iOS >= 17.0
              '';
              required = true;
            };
            "Radius" = mkProfileOpt {
              type = (ios-config-utils.floatBetween (100.0) (6500.0));
              description = ''
                Specifies the radius of the geofence in meters. Set this
                value slightly greater than the private cellular network
                coverage area.

                Requires: iOS >= 17.0
              '';
              required = true;
            };
            "GeofenceId" = mkProfileOpt {
              type = types.str;
              description = ''
                A geofence identifier that's unique within a list of
                geofences.

                Requires: iOS >= 17.0
              '';
              required = true;
            };
          }
        )
      );
      description = ''
        A list of up to 1000 geofences for private networks.
        Geofencing is only used on iPhone.

        Requires: iOS >= 17.0
      '';
      required = false;
    };
    "DataSetName" = mkProfileOpt {
      type = types.str;
      description = ''
        The name of the private network configuration data set.

        Requires: iOS >= 17.0
      '';
      required = true;
    };
    "VersionNumber" = mkProfileOpt {
      type = types.str;
      description = ''
        The version number of this dataset that the system uses to
        track updates.

        Requires: iOS >= 17.0
      '';
      required = true;
    };
    "CellularDataPreferred" = mkProfileOpt {
      type = types.bool;
      description = ''
        Set to `true` to prefer this private network over Wi-Fi.

        Requires: iOS >= 17.0
      '';
      required = false;
    };
    "EnableNRStandalone" = mkProfileOpt {
      type = types.bool;
      description = ''
        Set to `true` if this private network is NR Standalone.

        Requires: iOS >= 17.0
      '';
      required = false;
    };
    "NetworkIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        A string using the 3GPP "Coordinated NID" (option 1 or
        option 2) format (defined in 3GPP 31.102, Section 12.7.1).
        The device uses this value to match a SIM present on the
        device.

        All combinations of `NetworkIdentifier` and
        `CsgNetworkIdentifier` must be unique across all profiles
        installed on the device.

        Requires: iOS >= 18.0
      '';
      required = false;
    };
    "CsgNetworkIdentifier" = mkProfileOpt {
      type = types.str;
      description = ''
        A string using the 3GPP "CSG_ID" format (defined in 3GPP
        23.003, Section 4.7). The device uses this value to match a
        SIM present on the device.

        All combinations of `NetworkIdentifier` and
        `CsgNetworkIdentifier` must be unique across all profiles
        installed on the device.

        Requires: iOS >= 18.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Geofences" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Geofences"."*"."Longitude" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Geofences"."*"."Latitude" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Geofences"."*"."Radius" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "Geofences"."*"."GeofenceId" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "DataSetName" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "VersionNumber" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "CellularDataPreferred" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "EnableNRStandalone" = {
      minIos = "17.0";
      maxIos = null;
      supervised = false;
    };
    "NetworkIdentifier" = {
      minIos = "18.0";
      maxIos = null;
      supervised = false;
    };
    "CsgNetworkIdentifier" = {
      minIos = "18.0";
      maxIos = null;
      supervised = false;
    };
  };
}
