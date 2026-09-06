{
  eval,
  pkgs,
  ...
}:
let
  inherit (builtins) tryEval;

  evalGetPlist = config: (eval { inherit config; }).config.profiles.plist;
  tryEvalGetPlist = config: tryEval (evalGetPlist config);
in
{
  checks-webcontent-filter-contentfilteruuid-required =
    let
      gen-config = isSupervised: uuid: {
        target.isSupervised = isSupervised;
        profiles.webcontent-filter = {
          enable = true;
          ContentFilterUUID = uuid;
        };
      };
      uuid = "273d6d09-6909-4d41-8eeb-a1997ac52152";
      result1 = tryEvalGetPlist (gen-config false null);
      result2 = tryEvalGetPlist (gen-config false uuid);
      result3 = tryEvalGetPlist (gen-config true null);
      result4 = tryEvalGetPlist (gen-config null null);
    in
    assert result1.success == false;
    assert result2.success == true;
    assert result3.success == true;
    assert result4.success == true;
    pkgs.runCommand "checks-webcontent-filter-contentfilteruuid-required" { } "touch $out";
}
