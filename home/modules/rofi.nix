{ inputs, config, pkgs, ... }: {
  programs.rofi.enable = true;
    home.file.".config/rofi" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/logos/dotfiles/rofi/";
    recursive = true;
  };
}