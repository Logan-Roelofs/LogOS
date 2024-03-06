{ pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    plugins = [
    pkgs.vimPlugins.nvim-lspconfig
    pkgs.vimPlugins.gruvbox-nvim
    pkgs.vimPlugins.telescope-nvim
    ];
  };
}
