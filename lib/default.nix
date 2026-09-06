{ lib }:
let
  inherit (builtins) mapAttrs;
  inherit (lib) evalModules;
in
{
  iosConfig =
    {
      pkgs,
      modules ? [ ],
      specialArgs ? { },
    }:
    evalModules {
      class = "ios";
      specialArgs = specialArgs // {
        inherit pkgs;
        utils = import ./utils.nix { inherit lib; };
      };
      modules = [ ../modules/default.nix ] ++ modules;
    };

  deployPkgs =
    self:
    let
      configs = self.iosConfigurations or { };
    in
    mapAttrs (_: cfg: cfg.config.deploy.script) configs;
}
