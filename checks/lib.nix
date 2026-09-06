{ projectLib, pkgs, ... }: {
  can-gen-deploy-pkgs =
    let
      self = {
        iosConfigurations.test = projectLib.iosConfig {
          modules = [ { profiles.enable = true; } ];
        };
      };

      deployAttrs = {
        inherit self;
        pkgsFor = _: pkgs;
      };

      deployPkgs = projectLib.deployPkgs deployAttrs;
    in
    assert deployPkgs ? x86_64-linux;
    assert deployPkgs.x86_64-linux ? deploy;
    assert deployPkgs.x86_64-linux.deploy ? test;
    assert deployPkgs ? aarch64-linux;
    assert deployPkgs.aarch64-linux ? deploy;
    assert deployPkgs.aarch64-linux.deploy ? test;
    assert deployPkgs ? x86_64-darwin;
    assert deployPkgs.x86_64-darwin ? deploy;
    assert deployPkgs.x86_64-darwin.deploy ? test;
    assert deployPkgs ? aarch64-darwin;
    assert deployPkgs.aarch64-darwin ? deploy;
    assert deployPkgs.aarch64-darwin.deploy ? test;
    deployPkgs.x86_64-linux.deploy.test;
}
