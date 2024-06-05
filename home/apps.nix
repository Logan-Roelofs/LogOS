{ inputs, config, pkgs, ... }:
{
  # Web Webbrowsers
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  
  # System util
  programs.kitty.enable = true;
 
  home.file.".config/kitty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/logan/.config/logos/dotfiles/kitty/";
    recursive = true;
  };

  # Text Editor
  programs.vscode.enable = true;  
}
