{ inputs, config, pkgs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
    enable = true;
    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gvfs
      gnome.gvfs
      gtksourceview
      webkitgtk
      accountsservice
      pavucontrol
      bun
      dart-sass
      fd
      brightnessctl
      swww
      slurp
      wf-recorder
      wl-clipboard
      wayshot
      swappy
      hyprpicker
      networkmanager
      gtk3
    ];
  };
  home.file.".config/ags" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/logos/dotfiles/ags/";
    recursive = true;
  };

}
