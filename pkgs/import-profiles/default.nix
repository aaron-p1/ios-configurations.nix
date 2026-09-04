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
}
