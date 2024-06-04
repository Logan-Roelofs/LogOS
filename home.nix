{ inputs, config, pkgs, ... }: {
  imports = [
    ./home/ags.nix
    ./home/hyprland.nix
    ./home/theme.nix
    ./home/stylix.nix
  ];
  
  home.username = "logan";
  home.homeDirectory = "/home/logan";

  programs.kitty.enable = true;

  home.packages = [
    pkgs.hello
  ];
  
  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; 
}
