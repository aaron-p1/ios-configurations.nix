{ lib }:
let
  inherit (builtins) mapAttrs;
  inherit (lib) evalModules;
in
{
  iosConfig =
    {
      modules ? [ ],
      specialArgs ? { },
    }:
    # pkgs is needed for eval because plist <data> needs to be base64
    pkgs:
    evalModules {
      class = "ios";
      inherit specialArgs;
      modules = [
        { _module.args.ios-config-utils = import ./utils.nix { inherit lib; }; }
        { _module.args.pkgs = pkgs; }
        ../modules/default.nix
      ]
      ++ modules;
    };

  deployPkgs =
    {
      self,
      nixpkgs ? null,
      pkgsFor ? (system: import nixpkgs { inherit system; }),
      systems ? null,
    }:
    let
      configs = self.iosConfigurations or { };

      deployPkgsForSystem = pkgs: {
        deploy = mapAttrs (_: fn: (fn pkgs).config.deploy.script) configs;
      };

      usedSystems =
        if systems == null then
          [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ]
        else
          systems;

      forAllSystems = f: lib.genAttrs usedSystems (system: f (pkgsFor system));
    in
    forAllSystems deployPkgsForSystem;
}
