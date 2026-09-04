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
      manageiosModules = ./modules;

      checks = forAllSystems ({ pkgs }: import ./checks { inherit self pkgs lib; });

      apps = forAllSystems (
        { pkgs }:
        {
          import-profiles = {
            type = "app";
            program = lib.getExe (import ./pkgs/import-profiles { inherit pkgs; });
          };
        }
      );
    };
}
