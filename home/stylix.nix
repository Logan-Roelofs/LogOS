{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={
    base00 = "171717"; # 1 A
    base01 = "171717"; # 11 A
    base02 = "171717"; # 12 A
    base03 = "171717"; # 9 A
    base04 = "171717"; # 13 A
    base05 = "171717"; # 8 A
    base06 = "171717"; # 14 A
    base07 = "171717"; # 16 A
    base08 = "FF0000"; # 
    base09 = "00FF00"; # 
    base0A = "0000FF"; # 
    base0B = "FFFFFF"; # 
    base0C = "000000"; # 
    base0D = "FFFF00"; # 
    base0E = "808000"; #
    base0F = "800080"; #

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
