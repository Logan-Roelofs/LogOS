{ inputs, config, pkgs, ... }: {

 gtk.enable = true;
 gtk.theme = "Adwaita";
 gtk.package = pkgs.adementary-theme;
}
