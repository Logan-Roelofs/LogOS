{ inputs, config, pkgs, ... }: {
  xdg.desktopEntries = {
    control-center = {
      name = "control-center";
      genericName = "Control Center";
      exec = "env XDG_CURRENT_DESKTOP=GNOME gnome-control-center %U";
      terminal = false;
      categories = [ "Application" ];
    };
  };
}