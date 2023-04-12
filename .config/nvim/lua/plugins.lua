--- Plugins
require('packer').startup(function()
  use{ 'wbthomason/packer.nvim' }
  use { 'lewis6991/impatient.nvim' }                           --  Speed up neovim startup time
  use { 'ellisonleao/gruvbox.nvim' }                           --  Theme
  --- Statusline
  use { -- lualine
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use { 'akinsho/bufferline.nvim' }                            --  Bufferline
  ---
  use { --  Show Indentation
    'lukas-reineke/indent-blankline.nvim',
    config = function ()
      require("indent_blankline").setup {
          space_char_blankline = " ",
          show_current_context = true,
          show_current_context_start = true,
        }
    end
  }
  use { 'p00f/nvim-ts-rainbow' }                               --  Rainbow parentheses for treesitter
  use { -- Dim unused variables
    "zbirenbaum/neodim",
    config = function ()
      require("neodim").setup({
        alpha = 0.75,
        blend_color = "#000000",
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = true,
          underline = true,
        }
      })
    end
  }
  --- Language support
  use { -- Treesitter
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use { -- textobjects with treesitter support
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
  }
  use { --  Show code context
    'nvim-treesitter/nvim-treesitter-context',
    config = function ()
      require('treesitter-context').setup()
    end
  }
  use { 'neovim/nvim-lspconfig' }
  use { -- Null-ls
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }
  use { 'lvimuser/lsp-inlayhints.nvim'}
  use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", })
  use { 'sheerun/vim-polyglot' }
  use { 'brymer-meneses/grammar-guard.nvim' }                  -- Check writing
  use { 'simrat39/rust-tools.nvim'}
  use { 'gpanders/editorconfig.nvim' }                         -- Respect editorconfig
  ---
  use { 'kshenoy/vim-signature' }                              --  Show markers
  --- Utility
  -- Git
  use {  -- gitsigns
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use { 'tpope/vim-fugitive' }                                 --  Git commands
  use { --  Visualize merge conflicts
    'akinsho/git-conflict.nvim',
    config = function ()
      require('git-conflict').setup()
    end
  }

   use { -- lsp-format -- Autoformatting
     'lukas-reineke/lsp-format.nvim',
     config = function ()
       require('lsp-format').setup()
     end
   }
  use { 'andymass/vim-matchup', event = 'VimEnter' }           --  Navigate and highlight matching words
  use {                                                        --  Autoclose
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
  use { 'tpope/vim-endwise' }                                  --  Auto end structures
  use { 'tpope/vim-surround' }                                 --  Easy change of surroundings
  use { 'tpope/vim-repeat' }                                   --  Repeat plugin commands with .
  use { 'tpope/vim-unimpaired' }                               --  Handy bracket mappings
  use { 'tpope/vim-commentary' }                               --  Easy commenting
  use { 'vim-scripts/ReplaceWithRegister' }                    --  Replace things with register contents
  use { 'christoomey/vim-tmux-navigator' }                     --  Tmux navigation
  use { 'godlygeek/tabular' }                                  --  Easy formatting
  use { 'junegunn/fzf.vim' }                                   --  Fuzzy file search
  use { 'simnalamburt/vim-mundo' }                             --  Undo bar
  use { 'ludovicchabant/vim-gutentags' }                       --  Tag generation
  use { -- todo-comments
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  }
  ---
  --- Autocompletion
  use { -- nvim-cmp
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },                             --  Neovim LSP
      { 'hrsh7th/cmp-buffer' },                               --  Text from buffer
      { 'hrsh7th/cmp-path' },                                 --  File paths
      { 'hrsh7th/cmp-cmdline' },                              --  Commandline
      { 'lukas-reineke/cmp-under-comparator' },               --  Sorting of completions
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },              --  Emphasize current param in preview
      { 'hrsh7th/cmp-omni' },                                 --  Omnifunc support (needed for e.g. vimtex)
      { 'onsails/lspkind.nvim' }                              --  Display pictograms in completion menu
    }
  }
  ---
  --- Snippets
  use { -- ultisnips
    'SirVer/ultisnips',
    requires = {{'honza/vim-snippets', rtp = '.'}},
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  }
  use { -- ultisnip cmp support
    'quangnguyen30192/cmp-nvim-ultisnips',
    config = function()
      require("cmp_nvim_ultisnips").setup {
        filetype_source = "treesitter",
        show_snippets = "expandable",
        documentation = function(snippet)
            return snippet.description
        end
      }
    end
  }
  ---
  --- Note taking and other things
  use { -- neorg
    'nvim-neorg/neorg',
    requires = 'nvim-lua/plenary.nvim'
  }
  use { 'metakirby5/codi.vim' }                                --  Scratchpad
  ---
  --- File manager
  use { -- ranger
    'francoiscabrol/ranger.vim',
    requires = 'rbgrouleff/bclose.vim'
  }
  ---
  --- Debugging
  use { -- dap
    'mfussenegger/nvim-dap',
    requires = 'theHamsta/nvim-dap-virtual-text'
  }
  use { 'mfussenegger/nvim-dap-python' }
  use { 'rcarriga/nvim-dap-ui' }
  ---
  --- Run tests
  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-vim-test',
      'Issafalcon/neotest-dotnet',
      'rouge8/neotest-rust',
      'haydenmeade/neotest-jest'
    }
  }
  ---
  use { 'lervag/vimtex' }                                      --  Ultimate latex support
end)

--- Ranger
vim.g.ranger_map_keys = 0
---

--- Gutentags
vim.g.gutentags_modules           = { 'ctags' }
vim.g.gutentags_cache_dir         = '~/.cache/nvim/tags'
vim.g.gutentags_generate_on_write = 1
vim.g.gutentags_ctags_exclude     = {
  '*.git', '*.svg', '*.hg',
  'build',
  'dist',
  '*sites/*/files/*',
  'bin',
  'node_modules',
  'bower_components',
  'cache',
  'compiled',
  'example',
  'bundle',
  'vendor',
  '*-lock.json',
  '*.lock',
  '*bundle*.js',
  '*build*.js',
  '.*rc*',
  '*.min.*',
  '*.map',
  '*.bak',
  '*.zip',
  '*.pyc',
  '*.class',
  '*.sln',
  '*.Master',
  '*.csproj',
  '*.tmp',
  '*.csproj.user',
  '*.cache',
  '*.pdb',
  'tags*',
  'cscope.*',
  '*.less',
  '*.exe', '*.dll',
  '*.mp3', '*.ogg', '*.flac',
  '*.swp', '*.swo',
  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
}
---

require('plugin-settings.lspconfig')
require('plugin-settings.null-ls')
require('plugin-settings.treesitter')
require('plugin-settings.nvim-cmp')
require('plugin-settings.fzf')
require('plugin-settings.neorg')
require('plugin-settings.dap')
require('plugin-settings.neotest')
