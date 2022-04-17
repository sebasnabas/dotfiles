vim.opt.termguicolors = true
vim.cmd("colorscheme gruvbox")
vim.opt.background = "dark"

require('lualine').setup {
  options = { theme  = 'gruvbox-material' },
}

vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

require'bufferline'.setup({
    options = {
        buffer_close_icon = '',
        close_icon        = ''
    },
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
})

