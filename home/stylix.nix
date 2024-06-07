{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={

    base00 = "#2E3440"; # 1 A
    base08 = "#BF616A"; # 2 
    base0B = "#A3BE8C"; # 3
    base0A = "#EBCB8B"; # 4
    base0D = "#81A1C1"; # 5 
    base0E = "#B48EAD"; # 6
    base0C = "#88C0D0"; # 7 
    base05 = "#E5E9F0"; # 8 A
    base03 = "#4C566A"; # 9 A
    base09 = "#D08770"; # 10
    base01 = "#3B4252"; # 11 A
    base02 = "#434C5E"; # 12 A
    base04 = "#D8DEE9"; # 13 A
    base06 = "#ECEFF4"; # 14 A
    base0F = "#5E81AC"; # 15
    base07 = "#8FBCBB"; # 16 A

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
