{ inputs, config, pkgs, ... }:
{
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

  vim.api.nvim_set_keymap('n', '<C-x>', '"+d', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-x>', '"+x', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<C-x>', '<Esc>"+di', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-c>', '"+y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>"+yi', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>"+pa', { noremap = true, silent = true })
  
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
  vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
  vim.keymap.set('n', '<A-n>', function()
    vim.cmd('enew')  -- Open a new buffer
    vim.cmd('Neotree') -- Open Neo-tree in the new buffer
  end, { noremap = true, silent = true })

  -- Telescope
  vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", {})
  vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", {})
  '';
}
