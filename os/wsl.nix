{ config, pkgs, lib, inputs, username, home-manager, ... }: {
 wsl.useWindowsDriver = true;
  programs.sway.enable = true;
  wsl.enable = true;
  wsl.defaultUser = "${username}";
  wsl.startMenuLaunchers = true;
  environment.variables = {
    DONT_PROMPT_WSL_INSTALL = "true";
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.shellAliases = {
    sudo = "/run/wrappers/bin/sudo";
  };
  nixpkgs.config.allowUnfree = true;
  services.xrdp.defaultWindowManager = "xterm";
  environment.systemPackages = [
    pkgs.vscodium
    pkgs.emacs
    pkgs.firefox-unwrapped
    pkgs.xdg-utils
    pkgs.git
  ];
  system.stateVersion = "24.05"; # Do not change 
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
