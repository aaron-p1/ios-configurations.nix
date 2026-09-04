{
  pkgs,
  lib,
  self,
}:
let
  eval =
    modules:
    self.lib.mkIosConfig {
      inherit pkgs;
      modules = lib.toList modules;
    };
in
import ./profiles.nix { inherit eval pkgs lib; }
