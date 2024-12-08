{ config, pkgs, lib, inputs, username, ... }: {
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    #pkgs.nerdfonts
    monaspace
  ];
  environment.systemPackages = with pkgs;
    [
      adwaita-icon-theme # Icon theme
    ];
}
