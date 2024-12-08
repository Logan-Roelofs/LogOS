{ inputs, config, pkgs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [ electron_30 bun nodejs waypaper swww ];
  home.file.".config/wp/" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/logos/dotfiles/wp/";
    recursive = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      misc = {
        "force_default_wallpaper" = "0";
        "disable_hyprland_logo" = "true";
      };

      xwayland = { force_zero_scaling = true; };

      env = [
        # https://wiki.hyprland.org/FAQ/

        # XDG Specifications
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        # QT
        "QT_AUTO_SCREEN_SCALE_FACTOR,1" # enable automatic scaling
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      plugin = { hyprwinwrap = { class = "waves"; }; };

      exec-once = [
        "ags"
        #''kitty --class="kitty-bg" "/home/logan/.config/hypr/cava.sh"''
        #"firefox ~/.config/wp/move.html -kiosk"
      ];

      decoration = {
        "rounding" = "10";
        "shadow_range" = "4";
        "shadow_render_power" = "3";
        "drop_shadow" = "true";
        #        "col.shadow" = "rgba(1a1a1aee)";
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
        "col.active_border" = "rgba(51a4e7ee)";
        "col.inactive_border" = "rgba(595959aa)";
        "layout" = "dwindle";
        "allow_tearing" = "false";
      };

      input = { "natural_scroll" = "true"; };

      #monitor = [ ",preferred,auto,1" "eDP-1,preferred,auto,1" ];
      monitor = [ ",preferred,auto,1" "eDP-1,preferred,auto,1.333333" ];

      "$mainMod" = "SUPER";

      windowrule = [ "tile,^(kitty)$" "tile,^(steam_app_2379780)$" ];

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, /home/logan/.config/rofi/launchers/type-3/launcher.sh"
        "$mainMod, J, togglesplit, # dwindle"
        ''$mainMod, S, exec, grim -g "$(slurp)" -| wl-copy --type image/png''
        ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" -| swappy -f -''

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
  # desktop entry for gnomes control-center
  xdg.desktopEntries = {
    control-center = {
      name = "control-center";
      genericName = "Control Center";
      exec = "env XDG_CURRENT_DESKTOP=GNOME gnome-control-center %U";
      terminal = false;
      categories = [ "Application" ];
    };
  };
  # rofi app launcher
  home.file.".config/rofi" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/logos/dotfiles/rofi/";
    recursive = true;
  };
  # ags
  programs.ags = {
    enable = true;
    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gvfs
      gnome.gvfs
      gtksourceview
      webkitgtk_6_0
      accountsservice
      pavucontrol
      bun
      dart-sass
      fd
      brightnessctl
      swww
      slurp
      wf-recorder
      wl-clipboard
      wayshot
      swappy
      hyprpicker
      networkmanager
      gtk3
    ];
  };
  home.file.".config/ags" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/logos/dotfiles/ags/";
    recursive = true;
  };
  # wall papaer
  home.file.".config/waypaper" = {
    source = ../../dotfiles/wp;
    recursive = true;
  };
}
