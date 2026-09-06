{ projectLib, pkgs, ... }: {
  can-gen-deploy-pkgs =
    let
      self = {
        iosConfigurations.test = projectLib.iosConfig {
          inherit pkgs;
          modules = [ { profiles.enable = true; } ];
        };
      };

      deployPkgs = projectLib.deployPkgs self;
    in
    assert deployPkgs ? test;
    deployPkgs.test;
}
