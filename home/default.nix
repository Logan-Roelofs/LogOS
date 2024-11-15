{ inputs, config, pkgs, username, ... }: {
  imports = [
    ./apps.nix
    ./modules/ags.nix
    ./modules/hyprland.nix
    ./modules/zsh.nix
    ./modules/nvim.nix
    ./modules/vscod.nix
    ./modules/waypaper.nix
    ./modules/gtk.nix
    ./modules/rofi.nix
    ./modules/desktop.nix
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11";
}
