{ lib }: {
  iosConfig =
    {
      pkgs,
      modules ? [ ],
      specialArgs ? { },
    }:
    lib.evalModules {
      class = "ios";
      specialArgs = specialArgs // {
        inherit pkgs;
        utils = import ./utils.nix { inherit lib; };
      };
      modules = [ ../modules/default.nix ] ++ modules;
    };
}
