{ lib }:
let
  inherit (builtins)
    filter
    concatLists
    genList
    concatStringsSep
    ;
  inherit (lib)
    attrsToList
    isString
    isInt
    isList
    ;
in
{
  mkProfileOpt =
    { type, description }:
    lib.mkOption {
      inherit description;
      type = lib.types.nullOr type;
      default = null;
    };

  profileConfigToPlist =
    { config, indent }:
    let
      filledOptions = filter ({ value, ... }: value != null) (attrsToList config);

      gen-indent = n: concatStringsSep "" (genList (_: "  ") n);

      value-to-plist-lines =
        value:
        let
          lines =
            if isString value then
              [ "<string>${value}</string>" ]
            else if isInt value then
              [ "<integer>${toString value}</integer>" ]
            else if isList value then
              [ "<array>" ] ++ lib.concatMap value-to-plist-lines value ++ [ "</array>" ]
            else
              throw "Unsupported value type: ${toString value}";
        in
        map (line: "${gen-indent 1}${line}") lines;

      option-plist-lines = concatLists (
        map (
          { name, value }: [ "${gen-indent 1}<key>${name}</key>" ] ++ (value-to-plist-lines value)
        ) filledOptions
      );

      plist-lines = map (line: "${gen-indent indent}${line}") (
        [ "<dict>" ] ++ option-plist-lines ++ [ "</dict>" ]
      );
    in
    if filledOptions == [ ] then null else concatStringsSep "\n" plist-lines;
}
