{ self, pkgs, ... }:
let
  optionsDoc = (
    pkgs.nixosOptionsDoc {
      inherit (self.lib.iosConfig { } pkgs) options;
      transformOptions = o: o // { declarations = [ ]; };
      warningsAreErrors = false;
    }
  );
in
pkgs.runCommand "ios-configurations.5" { } ''
  mkdir -p $out/share/man/man5
  ${pkgs.nixos-render-docs}/bin/nixos-render-docs -j $NIX_BUILD_CORES \
    options manpage \
    --revision ${self.rev or "dirty"} \
    ${optionsDoc.optionsJSON}/share/doc/nixos/options.json \
    $out/share/man/man5/ios-configurations.5

  # for some reason it does not render Required: and Deprecated in on separate lines
  sed -i "s| Deprecated in|\n.br\nDeprecated in|g" $out/share/man/man5/ios-configurations.5
''
