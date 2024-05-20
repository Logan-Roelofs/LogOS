{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={
    base00 = "2E3440";
    #base00 = "1e2430";
    base01 = "88C0D0";
    base02 = "BF616A";
    base03 = "5E81AC";
    base04 = "EBCB8B";
    base05 = "A3BE8C";
    base06 = "D08770";
    base07 = "E5E9F0";
    base08 = "4C566A";
    base09 = "88C0D0";
    base0A = "BF616A";
    base0B = "5E81AC";
    base0C = "EBCB8B";
    base0D = "A3BE8C";
    base0E = "D08770";
    base0F = "8FBCBB";
  };
  stylix.autoEnable = true;
  stylix.image = ../dotfiles/wp/zen.png;
  stylix.targets.gtk.enable = false;
  stylix.polarity = "dark";
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
  };
}
