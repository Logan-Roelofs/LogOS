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
    ];
  };
  home.file.".config/ags" = {
    source = builtins.trace
      "${config.home.homeDirectory}/.config/logos/dotfiles/ags/"
      (config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.config/logos/dotfiles/ags/");
    recursive = true;
  };
}
