{ pkgs }:
let
  python = pkgs.python3.withPackages (ps: [ ps.pyyaml ]);
in
pkgs.writeShellApplication {
  name = "import-profiles";
  runtimeInputs = [ python ];

  text = ''
    exec python3 ${./import-profiles.py} "$@"
  '';

  meta = with pkgs.lib; {
    description = ''
      Import profiles from Apple Configuration Profile Reference.
      https://github.com/apple/device-management/blob/release/mdm/profiles
    '';
    license = licenses.mit;
  };
}
