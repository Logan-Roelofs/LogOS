{ inputs, config, pkgs, username, ... }: {
  imports = [
    ./home/ags.nix
    ./home/hyprland.nix
    ./home/theme.nix
    ./home/stylix.nix
    ./home/apps.nix
    ./home/zsh.nix
  ];
  
  home.username = "logan";
  home.homeDirectory = "/home/logan";
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; 
}
