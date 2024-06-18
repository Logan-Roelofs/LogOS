{ inputs, config, pkgs, ... }: {
  programs.hyprlock.enable = true;

  #  home.file.".config/hyprlock" = {
  #    source = config.lib.file.mkOutOfStoreSymlink
  #      "${config.home.homeDirectory}/.config/logos/dotfiles/hyprlock/";
  #    recursive = true;
  #  };
  home.file.".config/hyprlock/info.sh".enable = true;
  home.file.".config/hyprlock/info.sh" = {
    source = ../dotfiles/hyprlock/info.sh;
  };
  home.file.".config/hyprlock/info.sh".executable = null;

  programs.hyprlock.settings = {
    general = {
      disable_loading_bar = true;
      grace = 0;
      ignore_empty_input = true;
      hide_cursor = true;
      no_fade_in = true;
    };

    background = [{
      path = "screenshot";
      blur_passes = 3;
      blur_size = 7;
    }];

    # Information
    label = [{
      text = ''cmd[update:1000] echo -e "$(~/.config/hyprlock/info.sh)"'';
      color = "#CECDC3";
      #font_size = 12;
      position = "0, 0";
      halign = "right";
      valign = "bottom";
    }];

    input-field = [{
      size = "250, 60";
      position = "0, 0";
      monitor = "";
      fade_on_empty = false;
      font_color = "#CECDC3";
      inner_color = "#100F0F";
      outline_thickness = 0;
      outer_color = "#100F0F";
      dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.5; # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true;
      hide_input = false;
      valign = "center";
      halign = "center";
      placeholder_text = ''<span foreground="##1C1B1A"> $USER</span>'';
      shadow_passes = 10;
    }];
  };
}
