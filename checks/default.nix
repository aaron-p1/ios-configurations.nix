{
  pkgs,
  lib,
  self,
}:
let
  inherit (lib) assertMsg hasInfix;

  eval =
    modules:
    self.lib.iosConfig {
      inherit pkgs;
      modules = lib.toList modules;
    };

  testUtils = rec {
    assertVal =
      fn: value: msg:
      assertMsg (fn value) (msg + ":\n" + (toString value));

    assertContains = str: value: assertVal (hasInfix str) value (''Does not contain "${str}"'');
    assertDoesNotContain = str: value: assertVal (x: !(hasInfix str x)) value (''Contains "${str}"'');
  };
in
(import ./utils.nix { inherit pkgs lib testUtils; })
// (import ./profiles {
  inherit
    eval
    pkgs
    lib
    testUtils
    ;
})
