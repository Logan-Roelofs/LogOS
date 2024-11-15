{ config, pkgs, lib, inputs, username, home-manager, ... }: {
 wsl.useWindowsDriver = true;
  programs.sway.enable = true;
  wsl.enable = true;
  wsl.defaultUser = "${username}";
  wsl.startMenuLaunchers = true;
  environment.variables = {
    DONT_PROMPT_WSL_INSTALL = "true";
    LIBGL_ALWAYS_INDIRECT = "1";
    DISPLAY= "$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0";
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  security.sudo.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.xrdp.defaultWindowManager = "xterm";
  environment.systemPackages = [
    pkgs.vscodium
    pkgs.emacs
    pkgs.spotify
    pkgs.firefox-unwrapped
    pkgs.xdg-utils
    pkgs.git
    pkgs.gtk2-x11
    pkgs.gtk2
    pkgs.xfce.xfce4-session
    pkgs.sudo
  ];
  system.stateVersion = "24.05"; # Do not change 
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
