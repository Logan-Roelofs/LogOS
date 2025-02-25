{ inputs, config, pkgs, username, ... }: {
  imports = [
    ./apps.nix
    ./modules/hyprland.nix
    ./modules/zsh.nix
    ./modules/nvim.nix
    ./modules/vscod.nix
    ./modules/gtk.nix
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
}
