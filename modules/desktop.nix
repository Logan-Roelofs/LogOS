{ config, pkgs, inputs, ... }:{

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };
  
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    nerdfonts
  ];

  security.polkit.enable = true;

  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    swww
    hyprpicker
    fd
    bun
    dart-sass
    brightnessctl
    swww
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    asusctl
    supergfxctl
    slurp
    
    loupe
    gnome.adwaita-icon-theme
    gnome.nautilus
    baobab
#    gnome.gnome-calendar
    gnome.gnome-boxes
    gnome.gnome-system-monitor
    gnome.gnome-control-center
    gnome.gnome-weather
#  gnome.gnome-calculator
    gnome.gnome-clocks
    gnome.gnome-software # for flatpak
  ];
  
}
