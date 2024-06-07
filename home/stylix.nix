{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={

    base00 = "#2E3440"; # 1 Black	Background
    base08 = "#BF616A"; # 2 RED 	Error / Failure
    base0B = "#A3BE8C"; # 3 GREEN	Success
    base0A = "#EBCB8B"; # 4 YELLOW	
    base0D = "#5E81AC"; # 5 BLUE	
    base0E = "#B48EAD"; # 6 MAGENTA	
    base0C = "#88C0D0"; # 7 CYAN	
    base05 = "#FFFFFF"; # 8 WHITE	Default Text
    base03 = "#3B4252"; # 9 		Comment
    base09 = "#434C5E"; # 10
    base01 = "#4C566A"; # 11 
    base02 = "#D8DEE9"; # 12 
    base04 = "#E5E9F0"; # 13 
    base06 = "#ECEFF4"; # 14 
    base0F = "#8FBCBB"; # 15
    base07 = "#5E81AC"; # 16

    # Nord
    #base00 = "#2E3440";
    #base01 = "#3B4252";
    #base02 = "#434C5E";
    #base03 = "#4C566A";
    #base04 = "#D8DEE9";
    #base05 = "#E5E9F0";
    #base06 = "#ECEFF4";
    #base07 = "#8FBCBB";
    #base08 = "#BF616A";
    #base09 = "#D08770";
    #base0A = "#EBCB8B";
    #base0B = "#A3BE8C";
    #base0C = "#88C0D0";
    #base0D = "#81A1C1";
    #base0E = "#B48EAD";
    #base0F = "#5E81AC";
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
