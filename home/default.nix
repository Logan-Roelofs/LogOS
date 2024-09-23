{ inputs, config, pkgs, username, ... }: {
  imports = [
    ./ags.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./stylix.nix
    ./apps.nix
    ./zsh.nix
    ./nvim.nix
    ./vscod.nix
  ];

  home.username = "logan";
  home.homeDirectory = "/home/logan";
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
