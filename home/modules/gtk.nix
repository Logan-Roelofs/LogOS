{ inputs, config, pkgs, ... }: {

 gtk.enable = true;
 gtk.theme = "Adwaita";
 gtk.package = home.packages.pkgs.adementary-theme;
}
