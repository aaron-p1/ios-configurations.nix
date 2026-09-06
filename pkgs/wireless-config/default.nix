{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "wireless-config";
  src = ./.;
  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = [ pkgs.libimobiledevice ];

  buildPhase = ''
    $CC -O2 -Wall -o wireless-config wireless-config.c \
      $(pkg-config --cflags --libs libimobiledevice-1.0 libplist-2.0)
  '';

  installPhase = ''
    install -Dm755 wireless-config $out/bin/wireless-config
  '';

  meta = with pkgs.lib; {
    description = "Turn off and on wireless lockdownd on iOS devices";
    license = licenses.mit;
  };
}
