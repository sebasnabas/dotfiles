-- Runs a script that cleans out tex build files whenever I close out of a tex file.
vim.cmd("autocmd VimLeave *.tex !texclear %:")

-- Automatically deletes all trailing whitespace
vim.cmd("autocmd BufWritePre * %s/\s\+$//e")

-- Enable syntax highlighting of rofi config
vim.cmd("autocmd BufNewFile,BufRead /*.rasi setf css")

-- Enable syntax highlighting of svelte files
vim.cmd("autocmd BufNewFile,BufRead /*.svelte setf html")

-- I like relative numbering when in normal mode.
vim.cmd("autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 relativenumber")

-- Prefer Neovim terminal insert mode to normal mode.
vim.cmd("autocmd BufEnter term://* startinsert")
