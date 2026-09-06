{ lib }:
let
  inherit (builtins)
    filter
    concatLists
    genList
    concatStringsSep
    toJSON
    ;
  inherit (lib)
    types
    attrsToList
    concatMap
    optionalAttrs
    trim
    pipe
    splitString
    isString
    isInt
    isFloat
    isList
    isAttrs
    ;

  tagVal = tag: value: {
    __type = tag;
    value = value;
  };
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

  intMin = lowest: types.addCheck types.int (x: x >= lowest);
  intMax = highest: types.addCheck types.int (x: x <= highest);

  floatBetween =
    lowest: highest:
    assert lowest <= highest || throw "floatBetween: lowest must be smaller than highest";
    lib.types.addCheck lib.types.float (x: x >= lowest && x <= highest)
    // {
      name = "floatBetween";
      description = "floating point number between ${builtins.toJSON lowest} and ${builtins.toJSON highest} (both inclusive)";
      descriptionClass = "noun";
    };

  plistDataType =
    let
      baseType = types.either types.str types.path;
    in
    baseType
    // {
      name = "plist-data";
      description = ''Written as string or path, read as { __type = "data", value = ... }'';
      merge = loc: defs: tagVal "data" (baseType.merge loc defs);
    };

  settingsOf =
    type:
    let
      baseType = types.attrsOf type;
    in
    baseType
    // {
      name = "settings-data";
      description = ''Written as attrs, read as { __type = "settings", value = {...} }'';
      merge = loc: defs: tagVal "settings" (baseType.merge loc defs);
    };

  subopts = options: types.submodule { options = options; };

  toPlist =
    { ... }@attrs:
    pkgs:
    let
      lines = (
        toPlistValueLines {
          value = attrs;
          inherit pkgs;
          indent = 1;
        }
      );
    in
    # xml
    ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      ${concatStringsSep "\n" (map (line: "  ${line}") lines)}
      </plist>
    '';

  toPlistValueLines =
    {
      value,
      # needed for base64 encoding, because it builds a drv to encode the data
      pkgs,
      indent ? 0,
    }:
    let
      gen-indent = n: concatStringsSep "" (genList (_: "  ") n);
      addIndent = indent: map (line: "${gen-indent indent}${line}");

      attrsToPlistLines =
        attrs:
        let
          valueIsEmpty = value: if isList value then value == [ ] else value == null;

          expandSettings =
            cval:
            if isAttrs cval.value && (cval.value ? __type) && cval.value.__type == "settings" then
              attrsToList cval.value.value
            else
              [ cval ];

          filledValues = pipe attrs [
            attrsToList
            (concatMap expandSettings)
            (filter ({ value, ... }: !valueIsEmpty value))
          ];

          genKeyVal =
            { name, value }:
            [ "<key>${name}</key>" ]
            ++ (toPlistValueLines {
              inherit value pkgs;
              indent = indent + 1;
            });

          nestedPlistLines = addIndent 1 (concatLists (map genKeyVal filledValues));
        in
        if nestedPlistLines == [ ] then
          [ "<dict/>" ]
        else
          [ "<dict>" ] ++ nestedPlistLines ++ [ "</dict>" ];

    in
    if isString value then
      [ "<string>${value}</string>" ]
    else if isInt value then
      [ "<integer>${toString value}</integer>" ]
    else if isFloat value then
      # toString has trailing 0s
      [ "<real>${toJSON value}</real>" ]
    else if value == true then
      [ "<true/>" ]
    else if value == false then
      [ "<false/>" ]
    else if isList value then
      let
        nestedLines = concatMap (
          item:
          toPlistValueLines {
            inherit pkgs;
            value = item;
            indent = indent + 1;
          }
        ) value;
      in
      [ "<array>" ] ++ (addIndent 1 nestedLines) ++ [ "</array>" ]
    else if isAttrs value && (value ? __type) && value.__type == "data" then
      let
        data = pipe value.value [
          (toBase64 pkgs)
          (trim)
          (splitString "\n")
          (addIndent 1)
        ];
      in
      [ "<data>" ] ++ data ++ [ "</data>" ]
    else if isAttrs value then
      attrsToPlistLines value
    else
      throw "Unsupported value type: ${toString value}";

  toBase64 =
    pkgs: value:
    let
      cmdAttrs =
        if builtins.isPath value || builtins.isAttrs value then
          { valuePath = value; }
        else
          {
            value = value;
            passAsFile = [ "value" ];
          };

      drv = pkgs.runCommandLocal "value.b64" cmdAttrs ''base64 < "$valuePath" > $out'';
    in
    builtins.readFile drv;
}
