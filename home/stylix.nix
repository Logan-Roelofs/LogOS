{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={

    
    # Personal base16 scheme
    base00 = "#121212"; # ----
    base01 = "#1A1A1A"; # ---
    base02 = "#212121"; # --
    base03 = "#292929"; # -
    base04 = "#303030"; # +
    base05 = "#D9D9D9"; # ++
    base06 = "#404040"; # +++
    base07 = "#4F4F4F"; # ++++
    base08 = "#BF616A"; # red
    base09 = "#ff851b"; # orange
    base0A = "#EBCB8B"; # yellow
    base0B = "#A3BE8C"; # green
    base0C = "#88C0D0"; # aqua/cyan
    base0D = "#5E81AC"; # blue
    base0E = "#B48EAD"; # purple
    base0F = "#665c54"; # brown

    # Nord
    #base00 = "#2E3440"; # 1 Black	Background
    #base08 = "#BF616A"; # 2 RED 	Error / Failure
    #base0B = "#A3BE8C"; # 3 GREEN	Success
    #base0A = "#EBCB8B"; # 4 YELLOW	
    #base0D = "#5E81AC"; # 5 BLUE	
    #base0E = "#B48EAD"; # 6 MAGENTA	
    #base0C = "#88C0D0"; # 7 CYAN	
    #base05 = "#FFFFFF"; # 8 WHITE	Default Text
    #base03 = "#3B4252"; # 9 		Comment
    #base09 = "#434C5E"; # 10
    #base01 = "#4C566A"; # 11 
    #base02 = "#D8DEE9"; # 12 
    #base04 = "#E5E9F0"; # 13 
    #base06 = "#ECEFF4"; # 14 
    #base0F = "#8FBCBB"; # 15
    #base07 = "#5E81AC"; # 16
    
    # Grovbox
    #base00 = "#1d2021"; # ----
    #base01 = "#3c3836"; # ---
    #base02 = "#504945"; # --
    #base03 = "#665c54"; # -
    #base04 = "#bdae93"; # +
    #base05 = "#d5c4a1"; # ++
    #base06 = "#ebdbb2"; # +++
    #base07 = "#fbf1c7"; # ++++
    #base08 = "#fb4934"; # red
    #base09 = "#fe8019"; # orange
    #base0A = "#fabd2f"; # yellow
    #base0B = "#b8bb26"; # green
    #base0C = "#8ec07c"; # aqua/cyan
    #base0D = "#83a598"; # blue
    #base0E = "#d3869b"; # purple
    #base0F = "#d65d0e"; # brown

    # Green Machine
    #base00 = "#001100";
    #base01 = "#003300";
    #base02 = "#005500";
    #base03 = "#007700";
    #base04 = "#009900";
    #base05 = "#00bb00";
    #base06 = "#00dd00";
    #base07 = "#00ff00";
    #base08 = "#007700";
    #base09 = "#009900";
    #base0A = "#007700";
    #base0B = "#00bb00";
    #base0C = "#005500";
    #base0D = "#009900";
    #base0E = "#00bb00";
    #base0F = "#005500";
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
