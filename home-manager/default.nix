{ asztal, lib, pkgs, inputs, username,... }:
let
  hyprlandConfig = import ./hyprland.nix { inherit lib pkgs inputs; };
  agsConfig = import ./ags.nix { inherit lib pkgs inputs asztal; };
  themeConfig = import ./theme.nix { inherit lib pkgs inputs asztal; };
  neovimConfig = import ./neovim.nix { inherit lib pkgs inputs asztal; };
  firefoxConfig = import ./firefox.nix { inherit lib pkgs inputs asztal; };
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
#    emacs
  ];

   
  # Import the Hyprland configuration
  imports = [
    hyprlandConfig
    agsConfig
    themeConfig
    neovimConfig
    firefoxConfig
  ];

}
