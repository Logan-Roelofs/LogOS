{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [ 
    waypaper
    swww
  ];
  #home.file.".config/waypaper" = {
  #  source = config.lib.file.mkOutOfStoreSymlink
  #    "${config.home.homeDirectory}/.config/logos/dotfiles/newags/";
  #  recursive = true;
  #};
}