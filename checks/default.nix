{
  pkgs,
  lib,
  self,
}:
let
  eval =
    modules:
    self.lib.iosConfig {
      inherit pkgs;
      modules = lib.toList modules;
    };
in
import ./profiles { inherit eval pkgs lib; }
