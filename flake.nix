{
  description = "Use the Nix module system to configure iOS devices";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      systemAttr =
        f: system:
        f {
          inherit system;
          pkgs = import nixpkgs { inherit system; };
        };
      forAllSystems = f: lib.genAttrs systems (systemAttr f);
    in
    {
      lib = import ./lib { inherit lib; };

      iosModules.default = {
        imports = [ ./modules ];
        _module.args.ios-config-utils = import ./utils.nix { inherit lib; };
      };

      packages = forAllSystems (
        { pkgs, ... }: {
          manpage = import ./pkgs/manpage.nix { inherit self pkgs; };
          import-profiles = import ./pkgs/import-profiles { inherit pkgs; };
        }
      );

      templates = rec {
        default = usage;
        usage = {
          path = ./templates/usage;
          description = "Default template for using this flake to configure iOS devices";
        };
      };

      formatter = forAllSystems ({ pkgs, ... }: pkgs.nixfmt-tree);
      checks = forAllSystems ({ pkgs, ... }: import ./checks { inherit self pkgs lib; });

      devShells = forAllSystems (
        { system, pkgs, ... }:
        {
          default = pkgs.mkShell {
            shellHook = ''
              export MANPATH="${self.packages.${system}.manpage}/share/man:$MANPATH"
            '';
          };
        }
      );
    };
}
