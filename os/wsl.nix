{ config, pkgs, lib, inputs, username, home-manager, ... }: {
 wsl.useWindowsDriver = true;
  programs.sway.enable = true;
  wsl.enable = true;
  wsl.defaultUser = "${username}";
  wsl.startMenuLaunchers = true;
  environment.variables = {
    DONT_PROMPT_WSL_INSTALL = "true";
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.vscodium
    pkgs.emacs
    pkgs.spotify
    pkgs.firefox-unwrapped
    pkgs.xdg-utils
    pkgs.git
    pkgs.gtk2-x11
    pkgs.gtk2
    pkgs.gnome
  ];
  system.stateVersion = "24.05"; # Do not change 
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
