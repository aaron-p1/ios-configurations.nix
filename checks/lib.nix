{ projectLib, pkgs, ... }: {
  can-gen-deploy-pkgs =
    let
      self = {
        iosConfigurations.test = projectLib.iosConfig {
          modules = [ { profiles.enable = true; } ];
        };
      };

      deployPkgs = projectLib.deployPkgs { inherit self pkgs; };
    in
    assert deployPkgs ? deploy;
    assert deployPkgs.deploy ? test;
    deployPkgs.deploy.test;
}
