{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={
    base00 = "2E3440";
    #base00 = "1e2430";
    base01 = "3B4252";
    base02 = "434C5E";
    base03 = "4C566A";
    base04 = "D8DEE9";
    base05 = "E5E9F0";
    base06 = "ECEFF4";
    base07 = "8FBCBB";
    base08 = "88C0D0";
    base09 = "81A1C1";
    base0A = "5E81AC";
    base0B = "BF616A";
    base0C = "D08770";
    base0D = "EBCB8B";
    base0E = "A3BE8C";
    base0F = "B48EAD";
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
