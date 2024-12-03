{ config, pkgs, lib, inputs, username, ... }: {
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    nerdfonts
    monaspace
  ];
  environment.systemPackages = with pkgs;
    [
      adwaita-icon-theme # Icon theme
    ];
}
