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
    optionalAttrs
    trim
    pipe
    splitString
    isString
    isInt
    isList
    isAttrs
    ;
in
rec {
  mkProfileOpt =
    {
      type,
      description,
      required ? false,
    }:
    let
      optionAttrs = {
        inherit description;
        type = if required then type else lib.types.nullOr type;
      }
      // (optionalAttrs (!required) { default = null; });
    in
    lib.mkOption optionAttrs;

  plistDataType =
    let
      tagData = value: {
        __type = "data";
        value = value;
      };
    in
    lib.types.str
    // {
      name = "plist-data";
      description = ''Written as string, read as { __type = "data", value = ... }'';
      merge = loc: defs: tagData (lib.types.str.merge loc defs);
    };

  profileConfigToPlist = args: concatStringsSep "\n" (profileConfigToPlist' args);

  profileConfigToPlist' =
    {
      config,
      # needed for base64 encoding, because it builds a drv to encode the data
      pkgs,
      indent ? 0,
    }:
    let
      valueIsEmpty = value: if isList value then value == [ ] else value == null;

      filledOptions = filter ({ value, ... }: !valueIsEmpty value) (attrsToList config);

      gen-indent = n: concatStringsSep "" (genList (_: "  ") n);

      value-to-plist-lines =
        value:
        let
          lines =
            if isString value then
              [ "<string>${value}</string>" ]
            else if isInt value then
              [ "<integer>${toString value}</integer>" ]
            else if value == true then
              [ "<true/>" ]
            else if value == false then
              [ "<false/>" ]
            else if isList value then
              [ "<array>" ] ++ lib.concatMap value-to-plist-lines value ++ [ "</array>" ]
            else if isAttrs value && (value ? __type) && value.__type == "data" then
              let
                data = pipe value.value [
                  (toBase64 pkgs)
                  (trim)
                  (splitString "\n")
                  (map (line: "${gen-indent 1}${line}"))
                ];
              in
              [ "<data>" ] ++ data ++ [ "</data>" ]
            else if isAttrs value then
              let
                nestedLines = profileConfigToPlist' {
                  inherit pkgs;
                  config = value;
                };
              in
              if nestedLines == [ ] then [ "<dict/>" ] else nestedLines
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
    plist-lines;

  toBase64 =
    pkgs: value:
    let
      drv = pkgs.runCommandLocal "value.b64" {
        inherit value;
        passAsFile = [ "value" ];
      } ''base64 < "$valuePath" > $out'';
    in
    builtins.readFile drv;
}
