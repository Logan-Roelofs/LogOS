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
  programs.neovim.defaultEditor = true;
  programs.neovim.plugins = with pkgs.vimPlugins; [
    telescope-nvim
      plenary-nvim
      # Also nvim-web-devicons
      nui-nvim
      image-nvim
    neo-tree-nvim
    barbar-nvim
      nvim-web-devicons
      gitsigns-nvim
    copilot-vim
  ];
}
