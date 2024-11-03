{ inputs, config, pkgs, ... }: {
  xdg.desktopEntries = {
    control-pannel = {
      name = "control-pannel";
      genericName = "Control Pannel";
      exec = "firefox %U";
      terminal = false;
      categories = [ "Application" ];
    };
  };
}