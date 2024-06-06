{ inputs, config, pkgs, ... }:
{
  # Web Webbrowsers
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  
  # System util
  programs.kitty.enable = true;
 
  # Text Editor
  programs.vscode.enable = true;  
  programs.neovim.enable = true;

}
