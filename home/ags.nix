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
home.file.".config/ags" = let
  sourcePath = "../dotfiles/ags/";
in {
  source = builtins.trace sourcePath (config.lib.file.mkOutOfStoreSymlink sourcePath);
  recursive = true;
};
}
