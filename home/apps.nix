{ inputs, config, pkgs, ... }:
{
  # Web Webbrowsers
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  
  # System util
  programs.kitty.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      # Theme is the prompt layout
      theme = "strug";
      plugins = [
        "git"
	"kubectl"
	"helm"
	"docker"
      ];
    };
  };
 
  # Text Editor
  programs.vscode.enable = true;  
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # Common Dependencies
    plenary-nvim
    nvim-web-devicons
    
    # Programs
    telescope-nvim
    neo-tree-nvim
      nui-nvim
      image-nvim
    barbar-nvim
      gitsigns-nvim
    copilot-vim
    colorizer
  ];
  programs.neovim.extraLuaConfig = ''
 
  -- Neovim Settings
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = "number"

  -- File Tree
  vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
  vim.keymap.set("n", "<C-m>", ":Neotree filesystem close left<CR>", {})
  
  -- BarBar
  vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
  vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
  vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
  vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
  vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
  vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
  vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
  vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
  vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
  vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

  -- Telescope
  vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", {})
  vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", {})
  '';
}
