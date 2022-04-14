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
