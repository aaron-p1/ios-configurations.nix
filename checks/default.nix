{
  pkgs,
  lib,
  self,
}:
let
  inherit (lib) assertMsg hasInfix;

  eval = modules: self.lib.iosConfig { modules = lib.toList modules; } pkgs;

  testUtils = rec {
    assertVal =
      fn: value: msg:
      assertMsg (fn value) (msg + ":\n" + (toString value));

    assertContains = str: value: assertVal (hasInfix str) value (''Does not contain "${str}"'');
    assertDoesNotContain = str: value: assertVal (x: !(hasInfix str x)) value (''Contains "${str}"'');
  };

  testArgs = {
    inherit
      eval
      pkgs
      lib
      testUtils
      ;
    projectLib = self.lib;
  };

  system = pkgs.stdenv.hostPlatform.system;
in
{
  can-build-deploy-script = (eval { }).config.deploy.script;

  can-build-wireless-config-pkg = self.packages.${system}.wireless-config;
}
// (import ./lib.nix testArgs)
// (import ./utils.nix testArgs)
// (import ./profiles testArgs)
