{ inputs, config, pkgs, ... }: {
  gtk.enable = true;
  gtk.theme.package = pkgs.theme-vertex;
  gtk.theme.name = "theme-vertex";
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
}
