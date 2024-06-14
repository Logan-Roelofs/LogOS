{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation {
  name = "my-electron-app";
  src = ./.;

  buildInputs = [ pkgs.electron_13 pkgs.nodejs ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./* $out
    echo "#!${pkgs.stdenv.shell}" > $out/bin/start-my-app
    echo "exec electron $out/main.js" >> $out/bin/start-my-app
    chmod +x $out/bin/start-my-app
  '';

  meta = {
    description = "An example Electron application";
    maintainers = with pkgs.stdenv.lib.maintainers; [ ];
  };
}
