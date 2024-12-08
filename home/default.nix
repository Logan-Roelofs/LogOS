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
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11";
  font.packages = [ ... ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
}
