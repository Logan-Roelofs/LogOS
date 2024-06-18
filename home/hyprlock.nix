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
      grace = 1;
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
      font_size = 12;
      position = "-20, -510";
      halign = "right";
      valign = "center";
    }];

    input-field = [{
      size = "200, 50";
      position = "0, -80";
      monitor = "";
      dots_center = true;
      fade_on_empty = false;
      font_color = "#1C1B1A";
      inner_color = "#CECDC3";
      outer_color = "#1C1B1A";
      outline_thickness = 5;
      placeholder_text = ''<span foreground="##CECDC3">Password...</span>'';
      shadow_passes = 10;
    }];
  };
}
