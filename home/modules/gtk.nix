{ inputs, config, pkgs, ... }: {
  gtk.enable = true;
  gtk.theme.package = pkgs.adwsteamgtk;
  gtk.theme.name = "Adwaita-dark";
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
}
