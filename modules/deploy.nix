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
    optionals
    optionalString
    ;

  defaultProfileDeployCmdList = [
    "${pkgs.go-ios}/bin/ios"
    "profile"
    "add"
    config.profiles.mobileconfig
  ]
  ++ (optionals (config.target.udid != null) [
    "--udid"
    config.target.udid
  ]);

  defaultProfileDeployCmd = ''
    ${escapeShellArgs defaultProfileDeployCmdList} \
      2>&1 | ${pkgs.jq}/bin/jq -Rr --unbuffered '. as $line | try fromjson catch $line'
  '';
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
      defaultText = lib.literalExpression ''
        '''
        ''${pkgs.go-ios}/bin/ios profile add ''${config.profiles.mobileconfig} \
          ''${optionalString (config.target.udid != null) "--udid ''${config.target.udid}"} \
          2>&1 | ''${jq}/bin/jq -Rr --unbuffered '. as $line | try fromjson catch $line'
        '''
      '';
    };
  };

  config.deploy.script = pkgs.writeShellScriptBin "deploy-ios-config" ''
    set -euo pipefail

    ${optionalString config.profiles.enable
      # bash
      ''
        set +e
        (
          set -e
          echo "Deploying profiles..."
          ${config.deploy.profileDeployCmd}
          echo -e "\n\e[32mSuccessfully deployed profile\e[0m"
        )
        rc=$?
        set -e

        if [ $rc -ne 0 ]; then
          echo -e "\n\e[31mFailed to deploy profile (exit code $rc)\e[0m"
          exit $rc
        fi
      ''
    }
  '';
}
