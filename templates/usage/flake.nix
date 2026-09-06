{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
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
    let
      inherit (nixpkgs) lib;
      inherit (ios-config.lib) iosConfig deployPkgs;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      systemAttrs =
        f: system:
        f {
          pkgs = import nixpkgs { inherit system; };
          system = system;
        };
      forAllSystems = f: lib.genAttrs systems (systemAttrs f);
    in
    {
      iosConfigurations = {
        # TODO: target should be renamed to device name.
        target = iosConfig {
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
      packages = forAllSystems ({ pkgs, ... }: deployPkgs { inherit self pkgs; });

      # DevShell for making man page available:
      # $ nix develop
      # $ man ios-configurations
      devShells = forAllSystems (
        { pkgs, system, ... }: {
          default = pkgs.mkShell {
            # info about connected iOS devices:
            # (libimobiledevice commands require "-n" for devices accessed wirelessly)
            # $ idevice_id -nl
            # $ ideviceinfo
            buildInputs = [ pkgs.libimobiledevice ];

            shellHook = ''
              export PATH="${ios-config.packages.${system}.manpage}:$PATH"
            '';
          };
        }
      );
    };
}
