{ inputs, config, pkgs, ... }: {

  gtk.enable = true;
  gtk.theme.package = pkgs.adwaita-gtk3-theme;
  gtk.theme.name = "Adwaita-dark";
  gtk.cursorTheme.package = pkgs.bibata-cursor;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.iconTheme.package = gruvboxPlus;
  gtk.iconTheme.name = "GruvboxPlus";
}
