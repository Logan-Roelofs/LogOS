{ pkgs, inputs,... }: # You can include necessary arguments here if needed

{
  wayland.windowManager.hyprland = {
    enable = true;
#    plugins = [
#      inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
#    ];
    settings = { 
      
      misc = {
        "force_default_wallpaper" = "0";
        "disable_hyprland_logo" = "true";
      };

      xwayland = {
        force_zero_scaling = true;
      };

      exec-once = [
      "ags"
      ];

      decoration = {
        "rounding" = "10";
        "shadow_range" = "4";
        "shadow_render_power" = "3";
        "drop_shadow" = "true";
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        "enabled" = "true";
        "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];      
      };

      general = {
        "gaps_in" = "5";
        "gaps_out" = "10";
        "border_size" = "3";

        "col.active_border" = "rgba(0e7ac2ee) rgba(20c20eee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        "layout" = "dwindle";
        "allow_tearing" = "false";

      };
      
      input = {
        "natural_scroll" = "true";
      };

      monitor = [
      ",preferred,auto,1"
      "eDP-1,preferred,auto,1.333333"
      ];

      env = [
        "XCURSOR_SIZE,24"
      ];
      
      "$mainMod" = "SUPER";
      
      windowrule = [
        "opacity 0.95 override 0.8 override,^(kitty)$"
        "opacity 0.95 override 0.8 override,^(kitty)$"
        "tile, title:^(*)$"
      ];
      bind =[
          "$mainMod, Q, exec, kitty"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, ags -t applauncher"
          "$mainMod, V, togglefloating,"
          "$mainMod, J, togglesplit, # dwindle"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
