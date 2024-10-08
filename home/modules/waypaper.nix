{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [ 
    waypaper
    swww
  ];
  builtins.path = 
  home.file.".config/waypaper" = {
    source = builtins.path = "./wallpapers";
    recursive = true;
  };
}