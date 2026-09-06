{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  _class = "ios";

  imports = [
    ./profiles
    ./deploy.nix
  ];

  options = {
    target = {
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

      udid = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          The UDID of the target device used for deployment.
          If null, the deployment will run on the default device selected by `go-ios`.
        '';
      };
    };
  };
}
