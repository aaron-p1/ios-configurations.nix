{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      systemAttr = f: system: f { pkgs = import nixpkgs { inherit system; }; };
      forAllSystems = f: lib.genAttrs systems (systemAttr f);
    in
    {
      lib = import ./lib { inherit lib; };
      manageiosModules = import ./modules;

      checks = forAllSystems ({ pkgs }: import ./checks { inherit self pkgs lib; });

      packages = forAllSystems (
        { pkgs }: {

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
            pkgs.runCommand "manage-ios.5" { } ''
              mkdir -p $out/share/man/man5
              ${pkgs.nixos-render-docs}/bin/nixos-render-docs -j $NIX_BUILD_CORES \
                options manpage \
                --revision ${self.rev or "dirty"} \
                ${optionsDoc.optionsJSON}/share/doc/nixos/options.json \
                $out/share/man/man5/manage-ios.5

              # for some reason it does not render Required: and Deprecated in on separate lines
              sed -i "s| Deprecated in|\n.br\nDeprecated in|g" $out/share/man/man5/manage-ios.5
            '';
        }
      );

      apps = forAllSystems (
        { pkgs }:
        {
          import-profiles = {
            type = "app";
            program = lib.getExe (import ./pkgs/import-profiles { inherit pkgs; });
          };
        }
      );

      devShells = forAllSystems (
        { pkgs }:
        {
          default = pkgs.mkShell {
            shellHook = ''
              export MANPATH="${self.packages.${pkgs.system}.manpage}/share/man:$MANPATH"
            '';
          };
        }
      );
    };
}
