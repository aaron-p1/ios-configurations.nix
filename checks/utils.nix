{
  pkgs,
  lib,
  testUtils,
}:
let
  inherit (testUtils) assertContains;

  libUtils = import ../lib/utils.nix { inherit lib; };
  inherit (libUtils) toPlist;
in
{
  toPlist-outputs-header =
    let
      plist = toPlist { } pkgs;
    in
    assert assertContains "<?xml" plist;
    assert assertContains "<!DOCTYPE plist PUBLIC" plist;
    assert assertContains ''"-//Apple//DTD PLIST 1.0//EN"'' plist;
    assert assertContains ''"http://www.apple.com/DTDs/PropertyList-1.0.dtd"'' plist;
    assert assertContains ''<plist version="1.0">'' plist;
    assert assertContains "</plist>" plist;
    pkgs.runCommand "toPlist-outputs-header" { } "touch $out";

  toPlist-outputs-empty-dict =
    let
      plist = toPlist { } pkgs;
    in
    assert assertContains "<dict/>" plist;
    pkgs.runCommand "toPlist-outputs-empty-dict" { } "touch $out";

  toPlist-outputs-all-data-types =
    let
      plist = toPlist {
        string = "string";
        integer = 42;
        real = 3.14;
        booleanTrue = true;
        booleanFalse = false;
        data = {
          __type = "data";
          value = "data";
        };
        array = [ "array" ];
        dict = {
          key = "value";
        };
      } pkgs;
    in
    assert assertContains "    <string>string</string>" plist;
    assert assertContains "    <integer>42</integer>" plist;
    assert assertContains "    <real>3.14</real>" plist;
    assert assertContains "    <true/>" plist;
    assert assertContains "    <false/>" plist;
    assert assertContains "    <data>" plist;
    assert assertContains "      ZGF0YQ==" plist;
    assert assertContains "    <array>" plist;
    assert assertContains "      <string>array</string>" plist;
    assert assertContains "    <dict>" plist;
    assert assertContains "      <key>key</key>" plist;
    assert assertContains "      <string>value</string>" plist;
    pkgs.runCommand "toPlist-outputs-all-data-types" { } "touch $out";

  toPlist-can-expand-settings =
    let
      plist = toPlist {
        existingKey = "existingValue";
        settings = {
          __type = "settings";
          value = {
            key1 = "value1";
            key2 = "value2";
          };
        };
      } pkgs;
    in
    assert assertContains "    <key>existingKey</key>" plist;
    assert assertContains "    <string>existingValue</string>" plist;
    assert assertContains "    <key>key1</key>" plist;
    assert assertContains "    <string>value1</string>" plist;
    assert assertContains "    <key>key2</key>" plist;
    assert assertContains "    <string>value2</string>" plist;
    pkgs.runCommand "toPlist-can-expand-settings" { } "touch $out";
}
