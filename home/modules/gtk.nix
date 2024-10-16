{ inputs, config, pkgs, ... }: {
  gtk.enable = true;
  gtk.theme.package = pkgs.adwsteamgtk;
  gtk.theme.name = "Adwaita-dark";
  gtk.cursorTheme.package = pkgs.bibata-cursor;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.iconTheme.package = pkgs.gruvboxPlus;
  gtk.iconTheme.name = "GruvboxPlus";
}
