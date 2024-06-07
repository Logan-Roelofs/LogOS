{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={

    base00 = "#2E3440"; # 1 
    base08 = "#88C0D0"; # 2 
    base0B = "#BF616A"; # 3
    base0A = "#5E81AC"; # 4
    base0D = "#EBCB8B"; # 5 
    base0E = "#A3BE8C"; # 6
    base0C = "#D08770"; # 7 
    base05 = "#E5E9F0"; # 8 
    base03 = "#4C566A"; # 9 COMMET COLOR
    base09 = "#81A1C1"; # 10
    base01 = "#3B4252"; # 11 
    base02 = "#434C5E"; # 12 
    base04 = "#D8DEE9"; # 13 
    base06 = "#ECEFF4"; # 14 
    base0F = "#B48EAD"; # 15
    base07 = "#8FBCBB"; # 16

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
#  stylix.targets.nixvim.enable = false;
  
  stylix.image = ../dotfiles/wp/zen.png;
  stylix.targets.gtk.enable = false;
  stylix.polarity = "dark";
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
  };
}
