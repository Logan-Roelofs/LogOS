{ inputs, config, pkgs, ... }:
{
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # Common Dependencies
    plenary-nvim
    nvim-web-devicons
    
    # Programs
    mason-nvim
    CopilotChat-nvim
    mason-lspconfig-nvim
    nvim-lspconfig
    telescope-nvim
    telescope-file-browser-nvim 
	# <A-c>/c 	create 	Create file/folder at current path (trailing path separator creates folder)
	#<S-CR> 	create_from_prompt 	Create and open file/folder from prompt (trailing path separator creates folder)
	#<A-r>/r 	rename 	Rename multi-selected files/folders
	#<A-m>/m 	move 	Move multi-selected files/folders to current path
	#<A-y>/y 	copy 	Copy (multi-)selected files/folders to current path
	#<A-d>/d 	remove 	Delete (multi-)selected files/folders
	#<C-o>/o 	open 	Open file/folder with default system application
	#<C-g>/g 	goto_parent_dir 	Go to parent directory
	#<C-e>/e 	goto_home_dir 	Go to home directory
	#<C-w>/w 	goto_cwd 	Go to current working directory (cwd)
	#<C-t>/t 	change_cwd 	Change nvim's cwd to selected folder/file(parent)
	#<C-f>/f 	toggle_browser 	Toggle between file and folder browser
	#<C-h>/h 	toggle_hidden 	Toggle hidden files/folders
	#<C-s>/s 	toggle_all 	Toggle all entries ignoring ./ and ../
	#<Tab> 	see telescope.nvim 	Toggle selection and move to next selection
	#<S-Tab> 	see telescope.nvim 	Toggle selection and move to prev selection
	#<bs>/ 	backspace 	With an empty prompt, goes to parent dir. Otherwise acts normally
    telescope-ui-select-nvim 
    nvim-treesitter.withAllGrammars   	# Syntax Highlighting
    noice-nvim 		# Noice cmdline UI
      nui-nvim
      nvim-notify
    nvim-tree-lua 	# File Explorer
      nui-nvim
      image-nvim
    barbar-nvim 	# Buffer Bar (Tabs)
      gitsigns-nvim
    copilot-vim 	# Copilot
    colorizer 		# Colorize hex codes
    lualine-nvim 	# Status Line
  ];
  programs.neovim.extraLuaConfig = ''
 
  -- Neovim Settings
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = "number"
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true

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
  
  -- Telescope
  vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", {})
  vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", {})
  vim.keymap.set("n", "<C-n>", ":Telescope file_browser<CR>", {})
  
  -- Copilot
  vim.g.copilot_filetypes = { ['*'] = true }

  -- lua-line
  require("lualine").setup({
      options = {
        theme = "auto",
        sections = {
          lualine_a = {
            file = 1,
          },
        },
      },
    })

  -- Noice setup
  require("noice").setup({
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = false,
      inc_rename = false,
    }
  })

  -- Treesitter
  require("nvim-treesitter.configs").setup({
    -- Automatically install missing parsers when entering buffer
    highlight = { enable = true },
    indent = { enable = true },
  })
  
  -- Mason
  require("mason").setup()

  -- Mason LSP config
  require("mason.lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "rnix", -- Nix LSP
    },
  })

  -- nvim-lspconfig
  require("nvim-lspconfig").setup({
    automatic_installation = true,
  })

  -- Copilot Chat
  require("CopilotChat").setup ({
    debug = true,
  })
  '';
}
