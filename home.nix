{ inputs, config, pkgs, ... }: {
  imports = [
    ./home/ags.nix
    ./home/hyprland.nix
    ./home/theme.nix
    ./home/stylix.nix
  ];
  
  home.username = "logan";
  home.homeDirectory = "/home/logan";

  home.packages = [
    pkgs.kitty
  ];
  
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  
  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
