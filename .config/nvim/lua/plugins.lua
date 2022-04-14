require('packer').startup(function()
    use { 'wbthomason/packer.nvim' }                             --  Packer can manage itself
    use { 'ellisonleao/gruvbox.nvim' }                           --  Theme
    --- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    ---
    use { 'Yggdroot/indentLine' }                                --  show Indentation
    --- Syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use { 'neovim/nvim-lspconfig' }
    use { 'sheerun/vim-polyglot' }
    --
    use { 'kshenoy/vim-signature' }                              --  show markers
    --- Utility
    use { 'andymass/vim-matchup', event = 'VimEnter' }           --  Navigate and highlight matching words
    use { 'tmsvg/pear-tree' }                                    --  Autoclose
    use { 'tpope/vim-endwise' }                                  --  Auto end structures
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }

    --  Git integration for buffers
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
    -- use { 'lervag/vimtex' }                                      --  Better Latex support
    ---
    --- Autocompletion
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }
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
          show_snippets = "all",
          documentation = function(snippet)
              return snippet.description
          end
        }
      end
    }
    ---
    ---
    use { 'vimwiki/vimwiki' }
    use { 'metakirby5/codi.vim' }                                --  Scratchpad

    --- File manager
    use {
      'francoiscabrol/ranger.vim',
      requires = { 'rbgrouleff/bclose.vim' }
    }
    ---
end)

--- VimWiki
vim.cmd("let g:vimwiki_list = [{'path': '~/Documents/Notes/VimWiki/', 'syntax': 'markdown', 'ext': '.md'}]")
vim.cmd("let g:vimwiki_global_ext=0")
---
vim.cmd([[
function! s:goyo_enter()
  if exists('$TMUX')
    silent !tmux set status off
  endif
endfunction

function! s:goyo_leave()
  if exists('$TMUX')
    silent !tmux set status on
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
]])

require'bufferline'.setup({
    options = {
        buffer_close_icon = '',
        close_icon        = ''
    }
})

require('plugin-settings.lspconfig')
require('plugin-settings.treesitter')
require('plugin-settings.nvim-cmp')
require('plugin-settings.fzf')

