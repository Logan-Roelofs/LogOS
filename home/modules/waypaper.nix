{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [ 
    waypaper
    swww
  ];
  home.file.".config/waypaper" = {
    source = ./wallpapers;
    recursive = true;
  };
}