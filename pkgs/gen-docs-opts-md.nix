{ pkgs, manpage, ... }:
pkgs.writeShellScriptBin "gen-docs-opts-md" ''
  if [ ! -d "docs" ]; then
    echo "No `docs` dir found. Maybe in wrong directory?"
    exit 1
  fi

  ${pkgs.pandoc}/bin/pandoc \
    --from=man \
    --to=markdown \
    --output="docs/options.md" \
    ${manpage}/share/man/man5/ios-configurations.5
''
