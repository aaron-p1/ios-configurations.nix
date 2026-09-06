{ self, pkgs, ... }:
let
  inherit (builtins) replaceStrings concatStringsSep;
  inherit (pkgs.lib) escape;

  optionsDoc = (
    pkgs.nixosOptionsDoc {
      inherit (self.lib.iosConfig { } pkgs) options;
      transformOptions = o: o // { declarations = [ ]; };
      warningsAreErrors = false;
    }
  );

  docMeta = {
    header = [
      "IOS-CONFIGURATIONS"
      "5"
      "2026-09-06"
      "ios-configurations.nix"
      "iOS Config Options"
    ];
    name = "ios-configurations.nix - iOS Config Options";
    description = ''
      This document shows all available options for building iOS
      configurations with the ios-configurations.nix flake.
    '';
  };

  esc = escape [ "-" ];
  man = s: replaceStrings [ "." ] [ "\\&." ] (esc s);

  thLine = concatStringsSep " " (map (s: ''"${man s}"'') docMeta.header);

  header = pkgs.writeText "options-manpage-header.roff" ''
    .TH ${thLine}
    .\" disable hyphenation
    .nh
    .\" disable justification (adjust text to left margin only)
    .ad l
    .\" enable line breaks after slashes
    .cflags 4 /
    .SH "NAME"
    ${man docMeta.name}
    .SH "DESCRIPTION"
    .PP
    ${man docMeta.description}
    .SH "OPTIONS"
    .PP
  '';

  footer = pkgs.writeText "options-manpage-footer.roff" "";
in
pkgs.runCommand "ios-configurations.5" { } ''
  mkdir -p $out/share/man/man5
  ${pkgs.nixos-render-docs}/bin/nixos-render-docs -j $NIX_BUILD_CORES \
    options manpage \
    --revision ${self.rev or "dirty"} \
    --header ${header} \
    --footer ${footer} \
    ${optionsDoc.optionsJSON}/share/doc/nixos/options.json \
    $out/share/man/man5/ios-configurations.5

  # for some reason it does not render Required: and Deprecated in on separate lines
  sed -i "s| Deprecated in|\n.br\nDeprecated in|g" $out/share/man/man5/ios-configurations.5
''
