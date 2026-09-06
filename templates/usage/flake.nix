{
  inputs = {
    ios-config = {
      url = "github:aaron-p1/ios-configurations.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ios-config,
    }:
    {
      iosConfigurations = {
        # TODO: target should be renamed to device name.
        target = ios-config.lib.iosConfig {
          modules = [
            {
              target = {
                version = null;
                isSupervised = null;
                udid = null;
              };
              profiles.enable = false;
            }
          ];
        };
      };

      # Deployment is done with `nix run .#deploy.<device name>`.
      packages = ios-config.lib.deployPkgs { inherit self nixpkgs; };
    };
}
