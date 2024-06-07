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
    nvim-tree-lua
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
    vim.cmd('enew')
    vim.cmd('NvimTreeToggle')
  end, { noremap = true, silent = true })
  
  -- Telescope
  vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", {})
  vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", {})

-- nvim-tree setup
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then return end

vim.cmd([[
  nnoremap - :NvimTreeToggle<CR>
]])

-- Uncomment the following lines if you want to use these key mappings and settings
-- local keymap = vim.keymap -- for conciseness
-- keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
  vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldenable = false -- Disable folding at startup.

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  view = {
    relativenumber = true,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  -- filters = {
  --   custom = { "^.git$" },
  -- },
  -- renderer = {
  --   indent_width = 1,
  -- },
})


  '';
}
