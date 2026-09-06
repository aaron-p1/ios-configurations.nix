{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  _class = "ios";

  options.deploy.script = mkOption {
    type = types.package;
    readOnly = true;
    description = "The script that deploys the config to a device.";
  };

  config.deploy.script =
    let
      cfgProfiles = config.profiles;

      profilesScriptContent = # bash
        ''
          echo "Deploying profiles..."
          ios profile add ${cfgProfiles.mobileconfig}
        '';

      profilesScript = if cfgProfiles.enable then profilesScriptContent else "";
    in
    pkgs.writeShellApplication {
      name = "deploy-ios-config";
      runtimeInputs = [ pkgs.go-ios ];

      text = ''
        set -euo pipefail

        ${profilesScript}
      '';
    };
}
