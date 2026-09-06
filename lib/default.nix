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
    { self, pkgs }:
    let
      configs = self.iosConfigurations or { };
    in
    {
      deploy = mapAttrs (_: fn: (fn pkgs).config.deploy.script) configs;
    };
}
