{ config, pkgs, lib, inputs, username, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.KITTY_DISABLE_WAYLAND = "1";
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    nerdfonts
    monaspace
  ];
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme # Icon theme
    nautilus # File manager
    gnome-system-monitor # System monitor
    gnome-control-center # System settings
  ];
  services.gvfs.enable = true;
}