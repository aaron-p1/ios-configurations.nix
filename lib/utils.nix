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

      expandSettings =
        cval:
        if isAttrs cval.value && (cval.value ? __type) && cval.value.__type == "settings" then
          attrsToList cval.value.value
        else
          [ cval ];

      configValues = concatMap expandSettings (attrsToList config);
      filledOptions = filter ({ value, ... }: !valueIsEmpty value) configValues;

      gen-indent = n: concatStringsSep "" (genList (_: "  ") n);

      value-to-plist-lines =
        value:
        let
          lines =
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
