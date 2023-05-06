vim.opt.termguicolors = true
-- setup must be called before loading the colorscheme
require("gruvbox").setup({
undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = true,
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")
vim.opt.background = "dark"

require('lualine').setup {
  options = { theme  = 'gruvbox' },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    }
  }
}

vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

require'bufferline'.setup({
  highlights = {
    buffer_selected = {
      bold = true,
      italic = false
    }
  },
  options = {
      buffer_close_icon = '',
      close_icon        = '',
      view = "multiwindow",
      numbers = function(opts)
          return string.format("%s", opts.ordinal)
      end,
      modified_icon = "●",
      max_prefix_length = 5,
      tab_size = 18,
      separator_style = { "|", "" },
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = true,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
            or (e == "warning" and " " or "" )
          s = s .. n .. sym
        end
        return s
      end
    },
})
