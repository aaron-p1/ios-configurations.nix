{
  eval,
  pkgs,
  lib,
}:
let
  inherit (builtins) tryEval;

  evalGetPlist = config: (eval { inherit config; }).config.profiles.plist;
  tryEvalGetPlist = config: tryEval (evalGetPlist config);
in
{
  options-can-be-required =
    let
      config.profiles.airplay = {
        enable = true;
        Passwords = [ { DeviceName = "Name"; } ];
      };
      # this should throw an error because Password is required
      result = tryEvalGetPlist config;
    in
    assert result.success == false;
    pkgs.runCommand "options-can-be-required" { } "touch $out";

  checks-if-int-in-range =
    let
      gen-config = port: {
        profiles.airprint = {
          enable = true;
          AirPrint = [
            {
              IPAddress = "127.0.0.1";
              ResourcePath = "ipp/print";
              Port = port;
            }
          ];
        };
      };
      # this should throw an error because Password is required to be a string
      result1 = tryEvalGetPlist (gen-config 100000);
      result2 = tryEvalGetPlist (gen-config (-1));
      result3 = tryEvalGetPlist (gen-config 631);
    in
    assert result1.success == false;
    assert result2.success == false;
    assert result3.success == true;
    pkgs.runCommand "checks-if-int-in-range" { } "touch $out";

  checks-if-str-has-format =
    let
      gen-config = name: {
        profiles.airplay = {
          enable = true;
          AllowList = [ { DeviceID = name; } ];
        };
      };
      result1 = tryEvalGetPlist (gen-config "invalid-mac-address");
      result2 = tryEvalGetPlist (gen-config "00:11:22:33:44:55");
    in
    assert result1.success == false;
    assert result2.success == true;
    pkgs.runCommand "checks-if-str-has-format" { } "touch $out";
}
