{ config, pkgs, lib, inputs, username, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.KITTY_DISABLE_WAYLAND = "1";
  # Define Common System Fonts
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    nerdfonts
    monaspace
  ];
  services.gvfs.enable = true;
}