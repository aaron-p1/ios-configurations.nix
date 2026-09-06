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

      iosModules = {
        default = ./modules;
      };

      packages = forAllSystems (
        { pkgs, ... }: {
          manpage =
            let
              optionsDoc = (
                pkgs.nixosOptionsDoc {
                  inherit ((self.lib.iosConfig { inherit pkgs; })) options;
                  transformOptions = o: o // { declarations = [ ]; };
                  warningsAreErrors = false;
                }
              );
            in
            pkgs.runCommand "ios-configurations.5" { } ''
              mkdir -p $out/share/man/man5
              ${pkgs.nixos-render-docs}/bin/nixos-render-docs -j $NIX_BUILD_CORES \
                options manpage \
                --revision ${self.rev or "dirty"} \
                ${optionsDoc.optionsJSON}/share/doc/nixos/options.json \
                $out/share/man/man5/ios-configurations.5

              # for some reason it does not render Required: and Deprecated in on separate lines
              sed -i "s| Deprecated in|\n.br\nDeprecated in|g" $out/share/man/man5/ios-configurations.5
            '';

          import-profiles = import ./pkgs/import-profiles { inherit pkgs; };
        }
      );

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
