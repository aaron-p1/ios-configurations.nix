{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    escapeShellArgs
    optional
    optionalString
    ;

  defaultProfileDeployCmdList = [
    "ios"
    "profile"
    "add"
    config.profiles.mobileconfig
  ]
  ++ (optional (config.target.udid != null) [
    "--udid"
    config.target.udid
  ]);

  defaultProfileDeployCmd = escapeShellArgs defaultProfileDeployCmdList;
in
{
  _class = "ios";

  options.deploy = {
    script = mkOption {
      type = types.package;
      readOnly = true;
      description = "The script that deploys the config to a device.";
    };

    profileDeployCmd = mkOption {
      type = types.lines;
      default = defaultProfileDeployCmd;
      description = ''
        The commands to deploy the profile to a device.
        This is used by the deploy script.

        default: `ios profile add <profile> [--udid <udid>]`
      '';
    };
  };

  config.deploy.script = pkgs.writeShellApplication {
    name = "deploy-ios-config";
    runtimeInputs = [ pkgs.go-ios ];

    text = ''
      set -euo pipefail

      ${optionalString config.profiles.enable
        # bash
        ''
          echo "Deploying profiles..."
          ${config.deploy.profileDeployCmd}
        ''
      }
    '';
  };
}
