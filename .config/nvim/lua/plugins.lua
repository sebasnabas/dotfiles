--- Plugins
require('packer').startup(function()
    use { 'wbthomason/packer.nvim' }                             --  Packer can manage itself
    use { 'ellisonleao/gruvbox.nvim' }                           --  Theme
    --- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    ---
    use { 'Yggdroot/indentLine' }                                --  Show Indentation
    use { 'norcalli/nvim-colorizer.lua' }                        --  Colorize color codes
    use { 'junegunn/goyo.vim' }                                  --  Zen mode
    use { 'junegunn/limelight.vim' }                             --  Dim unfocused areas
    use { 'p00f/nvim-ts-rainbow' }                               --  Rainbow parentheses for treesitter
    --- Language support
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use { 'neovim/nvim-lspconfig' }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
          require("null-ls").setup()
      end,
      requires = { "nvim-lua/plenary.nvim" },
    }
    use { 'sheerun/vim-polyglot' }
    ---
    use { 'kshenoy/vim-signature' }                              --  Show markers
    use {
      'folke/trouble.nvim',
      config = function()
        require('trouble').setup()
      end
    }
    --- Utility
    use { 'andymass/vim-matchup', event = 'VimEnter' }           --  Navigate and highlight matching words
    use { 'tmsvg/pear-tree' }                                    --  Autoclose
    use { 'tpope/vim-endwise' }                                  --  Auto end structures
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    } --  Git integration for buffers
    use { 'tpope/vim-fugitive' }                                 --  Git commands
    use { 'tpope/vim-surround' }                                 --  Easy change of surroundings
    use { 'tpope/vim-repeat' }                                   --  Repeat plugin commands with .
    use { 'tpope/vim-unimpaired' }                               --  Handy bracket mappings
    use { 'vim-scripts/ReplaceWithRegister' }                    --  Replace things with register contents
    use { 'christoomey/vim-tmux-navigator' }                     --  Tmux navigation
    use { 'tpope/vim-commentary' }                               --  Easy commenting
    use { 'godlygeek/tabular' }                                  --  Easy formatting
    use { 'junegunn/fzf.vim' }                                   --  Fuzzy file search
    use { 'simnalamburt/vim-mundo' }                             --  Undo bar
    use { 'akinsho/bufferline.nvim' }                            --  Bufferline
    use { 'ludovicchabant/vim-gutentags' }                       --  Tag generation
    ---
    --- Autocompletion
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },                             --  Neovim LSP
        { 'hrsh7th/cmp-buffer' },                               --  Text from buffer
        { 'hrsh7th/cmp-path' },                                 --  File paths
        { 'hrsh7th/cmp-cmdline' },                              --  Commandline
        { 'hrsh7th/cmp-calc' },                                 --  Calculations
        { 'quangnguyen30192/cmp-nvim-tags' },                   --  Tags
        { 'lukas-reineke/cmp-rg' },                             --  Ripgrep (text from other files)
        { 'lukas-reineke/cmp-under-comparator' },               --  Sorting of completions
        { 'f3fora/cmp-spell' }                                  --  Dictionaries
      }
    }
    ---
    --- Snippets
    use {
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
    use {
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
    use {
      'nvim-neorg/neorg',
      requires = 'nvim-lua/plenary.nvim'
    }
    use { 'brymer-meneses/grammar-guard.nvim' }
    use { 'metakirby5/codi.vim' }                                --  Scratchpad
    ---
    --- File manager
    use {
      'francoiscabrol/ranger.vim',
      requires = 'rbgrouleff/bclose.vim'
    }
    ---
    --- Debugging
    use { 'mfussenegger/nvim-dap' }
    ---
end)

--- IndentLine
vim.g.indentLine_concealcursor = 'nc'
---

--- Ranger
vim.g.ranger_map_keys = 0
---

--- Limelight
-- Color name (:help cterm-colors) or ANSI code
vim.g.limelight_conceal_ctermfg = 'gray'
vim.g.limelight_conceal_ctermfg = 240

-- Color name (:help gui-colors) or RGB color
vim.g.limelight_conceal_guifg = 'DarkGray'
vim.g.limelight_conceal_guifg = '#777777'
---
--- Goyo
vim.g.goyo_width = 100
vim.g.goyo_height = 100
vim.cmd([[
function! s:goyo_enter()
  if exists('$TMUX')
    " Remove tmux status line
    silent !tmux set status off
    " Focus tmux pane
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  " Fullscreen
  silent !i3-msg fullscreen enable
  silent !~/.scripts/tools/do-not-disturb on

  silent Gitsigns detach

  silent Limelight 0.9
endfunction

function! s:goyo_leave()
  if exists('$TMUX')
    " Reset tmux status line
    silent !tmux set status on
    " Reset tmux pane focus
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  " Reset window opacity
  "silent !picom-trans -t -c
  silent !i3-msg fullscreen disable
  silent !~/.scripts/tools/do-not-disturb off

  silent Gitsigns attach

  silent Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
]])
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
