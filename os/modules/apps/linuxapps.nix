{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    blueberry # Bluetooth manager
    wl-clipboard
    wl-clipboard-x11 # Clipboard manager
    remmina # Remote desktop client
    rofi-wayland # Application launcher
  ];
}