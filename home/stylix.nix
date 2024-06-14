{ pkgs, inputs, ... }: {
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme = {
    # Personal base16 scheme
    base00 = "#100F0F"; # ----    Main bg
    base01 = "#1C1B1A"; # ---     Sidebar bg
    base02 = "#282726"; # --      Highlight bg
    base03 = "#575653"; # -       Comments          (Text 2)
    base04 = "#878580"; # +       NA
    base05 = "#CECDC3"; # ++      Default Text      (Text 1)
    base06 = "#000FFF"; # +++     NA
    base07 = "#FFFF00"; # ++++    NA
    base08 = "#BF616A"; # red     Error / Failure
    base09 = "#FF0000"; # orange
    base0A = "#EBCB8B"; # yellow  Warning
    base0B = "#A3BE8C"; # green   Success
    base0C = "#8FBCBB"; # ---     Random stuff
    base0D = "#88C0D0"; # --      Random stuff
    base0E = "#81A1C1"; # ---     Random stuff
    base0F = "#5E81AC"; # ----    Syntax stuff

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
