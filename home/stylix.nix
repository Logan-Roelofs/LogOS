{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={
    base00 = "171717";
    #base00 = "1e2430";
    base01 = "2e3440";
    base02 = "3b4252";
    base03 = "434c5e";
    base04 = "d8dee9";
    base05 = "e5e9f0";
    base06 = "eceff4";
    base07 = "8fbcbb";
    base08 = "88c0d0";
    base09 = "81a1c1";
    base0A = "5e81ac";
    base0B = "bf616a";
    base0C = "d08770";
    base0D = "ebcb8b";
    base0E = "a3be8c";
    base0F = "b48ead";
  };
  stylix.image = ../dotfiles/wp/zen.png;
  stylix.targets.gtk.enable = false;
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
  };
}
