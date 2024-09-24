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
  PROJECT_ROOT = "${toString ./.}";
  sourcePath = "../dotfiles/ags/";
in {
  source = builtins.trace PROJECT_ROOT (config.lib.file.mkOutOfStoreSymlink PROJECT_ROOT);
  recursive = true;
};
}
