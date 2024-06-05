{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={
    base00 = "222630";
    base01 = "464953";
    base02 = "6a6d77";
    base03 = "8d909a";
    base04 = "b1b4bd";
    base05 = "d4d7e0";
    base06 = "dbdde5";
    base07 = "e1e3e9";
    base08 = "6777a7";
    base09 = "5f7d88";
    base0A = "6678a0";
    base0B = "657c87";
    base0C = "727889";
    base0D = "6b7a87";
    base0E = "6f76a1";
    base0F = "767692";

    # Nord
    #base00 = "171717";
    #base01 = "3B4252";
    #base02 = "434C5E";
    #base03 = "4C566A";
    #base04 = "D8DEE9";
    #base05 = "E5E9F0";
    #base06 = "ECEFF4";
    #base07 = "8FBCBB";
    #base08 = "BF616A";
    #base09 = "D08770";
    #base0A = "EBCB8B";
    #base0B = "A3BE8C";
    #base0C = "88C0D0";
    #base0D = "81A1C1";
    #base0E = "B48EAD";
    #base0F = "5E81AC";
  };
  
  stylix.fonts = {
    monospace = {
      package = pkgs.monaspace;
      name = "Monaspace Xenon Var Regular";
    };
  };

  stylix.autoEnable = true;
  stylix.targets.hyprland.enable = false;
  stylix.targets.nixvim.enable = false;

  stylix.image = ../dotfiles/wp/zen.png;
  stylix.targets.gtk.enable = false;
  stylix.polarity = "dark";
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
  };
}
