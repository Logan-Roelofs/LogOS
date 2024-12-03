{ config, pkgs, lib, inputs, username, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.KITTY_DISABLE_WAYLAND = "1";
  environment.systemPackages = with pkgs; [
    nautilus # File manager
    gnome-system-monitor # System monitor
    gnome-control-center # System settings
  ];
  services.gvfs.enable = true;
}

