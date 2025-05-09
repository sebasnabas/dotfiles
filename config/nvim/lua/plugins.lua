--- Plugins
require('lazy').setup({
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require("gruvbox").setup({
          overrides = {
            DiffText = { link = "GruvboxPurple" } -- faded yellow
          }
      })
    end
  },                           --  Theme
  --- Statusline
  { -- lualine
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
  },
  { 'akinsho/bufferline.nvim' },                            --  Bufferline
  ---
  { --  Show Indentation
    'lukas-reineke/indent-blankline.nvim',
    config = function ()
      require("ibl").setup()
    end
  },
  { 'p00f/nvim-ts-rainbow' },                               --  Rainbow parentheses for treesitter
  --- Language support
  { -- Treesitter
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate'
  },
  { -- textobjects with treesitter support
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function ()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          }
        }
      }
    end
  },
  { --  Show code context
    'nvim-treesitter/nvim-treesitter-context',
    config = function ()
      require('treesitter-context').setup()
    end
  },
  { 'neovim/nvim-lspconfig' },
  { -- Null-ls
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')

      -- register any number of sources simultaneously
      null_ls.setup({
          sources = {
            -- Formatting
            null_ls.builtins.formatting.black,          -- python
            null_ls.builtins.formatting.rome.with({
              extra_args = {
                indentStyle = "space"
              }
            }),           -- js, html & css, json
            null_ls.builtins.formatting.rustfmt,        -- rust
            null_ls.builtins.formatting.terraform_fmt,  -- terraform

            -- Diagnostics
            null_ls.builtins.diagnostics.ansiblelint,
            null_ls.builtins.diagnostics.chktex,
            null_ls.builtins.diagnostics.typos,
            null_ls.builtins.diagnostics.cppcheck,
            null_ls.builtins.diagnostics.gitlint,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.terraform_validate,  -- terraform
            null_ls.builtins.diagnostics.yamllint,
            null_ls.builtins.diagnostics.vale,

            -- Code Actions
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.code_actions.shellcheck,

            -- Hover
            null_ls.builtins.hover.dictionary,
          },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "Hoffs/omnisharp-extended-lsp.nvim"
    },
  },
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
  { 'b0o/SchemaStore.nvim' },                               -- Support for json & yaml schemas
  { 'sheerun/vim-polyglot' },
  { 'brymer-meneses/grammar-guard.nvim' },                  -- Check writing
  { 'simrat39/rust-tools.nvim'},
  { 'gpanders/editorconfig.nvim' },                         -- Respect editorconfig
  { 'tadmccorkle/markdown.nvim', ft = 'markdown' },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    }
  },
  ---
  { 'kshenoy/vim-signature' },                              --  Show markers
  --- Utility
  -- Git
  {  -- gitsigns
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  { 'tpope/vim-fugitive' },                                 --  Git commands
  { --  Visualize merge conflicts
    'akinsho/git-conflict.nvim',
    config = function ()
      require('git-conflict').setup()
    end
  },

  { -- lsp-format -- Autoformatting
    'lukas-reineke/lsp-format.nvim',
    config = function ()
      require('lsp-format').setup()
    end
  },
  { 'andymass/vim-matchup', event = 'VimEnter' },           --  Navigate and highlight matching words
  {                                                        --  Autoclose
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup {}
    end
  },
  { 'tpope/vim-endwise' },                                  --  Auto end structures
  { 'tpope/vim-surround' },                                 --  Easy change of surroundings
  { 'tpope/vim-repeat' },                                   --  Repeat plugin commands with .
  { 'tpope/vim-unimpaired' },                               --  Handy bracket mappings
  { 'vim-scripts/ReplaceWithRegister' },                    --  Replace things with register contents
  { 'christoomey/vim-tmux-navigator' },                     --  Tmux navigation
  { 'godlygeek/tabular' },                                  --  Easy formatting

  {
  'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      -- Enable multi select in the picker to be more like fzf.vim
      -- Taken from https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
      local select_one_or_multi = function(prompt_bufnr)
        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          require('telescope.actions').close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then
              vim.cmd(string.format('%s %s', 'edit', j.path))
            end
          end
        else
          require('telescope.actions').select_default(prompt_bufnr)
        end
      end

      -- Make file name more visible in path
      -- Taken from https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1873229658
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })
      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then return tail end
        return string.format("%s\t\t%s", tail, parent)
      end

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ['<CR>'] = select_one_or_multi,
            }
          },
          path_display = filenameFirst
        },
        extensions = {
         fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
          },
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            -- layout_config = {
              -- preview_height = 0.8,
            -- },
          },
        },
      })
      require("telescope").load_extension("undo")
      require('telescope').load_extension('fzf')
    end
  },
  { 'simnalamburt/vim-mundo' },                             --  Undo bar
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        min_count_to_highlight = 2,
      })
    end
  },                              --  Highlight other uses of word
  { -- todo-comments
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  },
  ---
  --- Autocompletion
  { -- nvim-cmp
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },                             --  Neovim LSP
      { 'hrsh7th/cmp-buffer' },                               --  Text from buffer
      { 'hrsh7th/cmp-path' },                                 --  File paths
      { 'hrsh7th/cmp-cmdline' },                              --  Commandline
      { 'lukas-reineke/cmp-under-comparator' },               --  Sorting of completions
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },              --  Emphasize current param in preview
      { 'hrsh7th/cmp-omni' },                                 --  Omnifunc support (needed for e.g. vimtex)
      { 'onsails/lspkind.nvim' },                             --  Display pictograms in completion menu
      { 'hrsh7th/cmp-calc' }                                  --  Math completion
    }
  },
  -- Render Images
  {
    '3rd/image.nvim',
    build = false,
    opts = {},
    config = function()
      require("image").setup({
        backend = "kitty",
        processor = "magick_cli",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            filetypes = { "norg" },
          },
          typst = {
            enabled = true,
            filetypes = { "typst" },
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
    end
  },
  --- Snippets
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  --- Note taking and other things
  { 'metakirby5/codi.vim' },                                --  Scratchpad
  ---
  --- File manager
  { -- ranger
    'francoiscabrol/ranger.vim',
    dependencies = 'rbgrouleff/bclose.vim'
  },
  ---
  --- Debugging
  { -- dap
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
    }
  },
  ---
  --- Run tests
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-vim-test',
      'Issafalcon/neotest-dotnet',
      'rouge8/neotest-rust',
      'haydenmeade/neotest-jest'
    }
  },
  ---
  {
    'danymat/neogen',
    config = function()
      require('neogen').setup({
        enabled = true,
        languages = {
          cs = {
            template = {
              annotation_convention = "xmldoc",
            }
          },
          python = {
            template = {
              annotation_convention = "google_docstrings",
            }
          }
        },
        snippet_engine = "luasnip",
      })
    end
  },                                    --  Generate docstrings
 { 'norcalli/nvim-colorizer.lua' }
})

require('plugin-settings.lspconfig')
require('plugin-settings.treesitter')
require('plugin-settings.nvim-cmp')
require('plugin-settings.dap')
require('plugin-settings.neotest')

--- Ranger
vim.g.ranger_map_keys = 0
---
