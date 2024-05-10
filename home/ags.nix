{ inputs, config, pkgs, ... }:
{
#  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
    enable = true;
    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  home.file.".config/ags" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/logos/dotfiles/ags/";
    recursive = true;
  };
}
