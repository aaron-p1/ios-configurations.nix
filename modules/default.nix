{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  _class = "ios";

  imports = [
    ./profiles
  ];

  options = {
    targetData = {
      version = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          The iOS version of the target device.
          Only used for validating profile options.
        '';
      };
      isSupervised = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Whether the target device is supervised.
          Only used for validating profile options.
        '';
      };
    };
  };
}
