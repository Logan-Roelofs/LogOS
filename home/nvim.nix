{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    # List of LSPs:
    # https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    pyright
    quick-lint-js
    javascript-typescript-langserver

    # List of formatters:
    # https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
    nodePackages.prettier # javascript, typescript, javascriptreact, typescriptreact, svelte, css, html, json, yaml, markdown, graphql
    isort # python
    stylua # lua
    black # python
    nixfmt-classic # nix
    alejandra

    # Other
    imagemagick
    wl-clipboard
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # Programs
      nvim-lspconfig # LSP (Error Checking and what not)
      conform-nvim # Formatter
      image-nvim # Image Viewer (does not work with Telescope)
      clipboard-image-nvim # Copy Image to Clipboard
      nui-nvim
      nvim-notify
      bufferline-nvim # Top Bufferline
      lualine-nvim # Bottom Line
      copilot-vim # Copilot
      colorizer # Colorize hex codes
      noice-nvim # Noice cmdline UI
      telescope-nvim # Telescope
      telescope-file-browser-nvim # File Browser
      telescope-ui-select-nvim # UI for Telescope
      nvim-treesitter.withAllGrammars # Syntax Highlighting
      dashboard-nvim # Dashboard
      otter-nvim # lsp diagnostics in nix files comments (for other languages)

      # Common Dependencies
      plenary-nvim
      popup-nvim
      nvim-web-devicons
      nui-nvim
    ];
    extraLuaConfig =
      # lua
      ''
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

        -- Bufferline (Top Bufferline)
        vim.opt.termguicolors = true
        require("bufferline").setup{
          options = {
            separator_style = "thick",
        --    numbers = function(opts)
        --      return string.format('%s',opts.raise(opts.ordinal))        -- "raise" | "lower" | "ordinal" | "id"
        --    end,
          }
        }
        vim.keymap.set('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', opts)
        vim.keymap.set('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', opts)
        vim.keymap.set('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', opts)
        vim.keymap.set('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', opts)
        vim.keymap.set('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', opts)
        vim.keymap.set('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', opts)
        vim.keymap.set('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', opts)
        vim.keymap.set('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', opts)
        vim.keymap.set('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', opts)
        vim.keymap.set('n', '<A-c>', '<Cmd>bd<CR>', opts)

        -- Telescope
        vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", {})
        vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", {})
        vim.keymap.set("n", "<C-n>", ":Telescope file_browser<CR>", {})

        -- Copilot
        vim.g.copilot_filetypes = { ['*'] = true }

        -- lua-line (Bottom Line)
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

        -- Noice setup (Cmdline UI)
        require("noice").setup({
          presets = {
            bottom_search = false,
            command_palette = false,
            long_message_to_split = false,
            inc_rename = false,
          }
        })

        -- Treesitter (Syntax Highlighting)
        require("nvim-treesitter.configs").setup({
          -- Automatically install missing parsers when entering buffer
          highlight = { enable = true },
          indent = { enable = true },
        })

        -- Dashboard
        require('dashboard').setup({
          config = {
            footer = { "Neovim" },
            week_header = {
              enable  --boolean use a week header
            },
          },
          hide = {
            statusline = true,
            tabline = true,
            winbar = true,
          },
        })

        -- LSPconfig (Error Checking)
        require'lspconfig'.quick_lint_js.setup{}
        require'lspconfig'.tsserver.setup{
          cmd = {"javascript-typescript-langserver"},
        }
        require'lspconfig'.pyright.setup{}

        -- Conform (Formatter)
        require("conform").setup({
          formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            svelte = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            graphql = { "prettier" },
            lua = { "stylua" },
            python = { "isort", "black" },
            nix = { "alejandra","nixfmt" },
          },
          format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
          },
        })
        -- otter-nvim
        require("otter").activate({ "javascript", "typescript", "python", "lua", "nix"},true, true,nil)
        -- image-nvim
        require("image").setup({
          backend = "kitty",
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { "norg" },
            },
            html = {
              enabled = false,
            },
            css = {
              enabled = false,
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = nil,
          max_height_window_percentage = 50,
          window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
          editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
          tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
          hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
        })
      '';
  };
}
