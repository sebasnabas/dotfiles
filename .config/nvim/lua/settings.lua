-- Vim Settings ---
vim.g.mapleader                      = ","
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
vim.wo.colorcolumn                   = '100'
vim.opt.encoding                     = "utf-8"
vim.opt.wrap                         = true
vim.opt.fileformat                   = "unix"
vim.opt.spelllang                    = {"en_us", "de"}
vim.opt.exrc                         = true                                                                   --  Enable local rc file
vim.opt.startofline                  = false                                                                  --  Keep cursor on same column
vim.opt.wildmenu                     = true                                                                   --  Display all matching files on tab completion
vim.opt.wildmode                     = { "longest", "list", "full"}                                           --  Display all matching files on tab completion
vim.opt.path                         = vim.opt.path + "**"                                                    --  Search down into subfolders
vim.opt.tags                         = "~/.cache/nvim/tags"                                                   --  Tag dir
vim.opt.undofile                     = true                                                                   --  Persistent history
vim.opt.autoread                     = true                                                                   --  Detect if file changed
vim.opt.backspace                    = {"indent", "eol", "start"}                                             --  Backspace works on every char in insert mode

--- Mapping waiting time
vim.opt.timeout                      = false
vim.opt.ttimeout                     = true
vim.opt.ttimeoutlen                  = 50
---

vim.opt.listchars               = {tab = "›\\·", space = "·", eol = "¬", extends = "›", precedes = "‹"}       --  Display whitespace
vim.opt.list                         = true
vim.opt.list                         = true
vim.opt.ttyfast                      = true
vim.opt.relativenumber               = true                                                                   --  Display relative line numbers on every line
vim.opt.number                       = true                                                                   --  Display line numbers on current line
vim.opt.ruler                        = true                                                                   --  Show cursor position

--- Indentation
vim.opt.tabstop                      = 4
vim.opt.shiftwidth                   = 4
vim.opt.smarttab                     = true
vim.opt.expandtab                    = true
vim.autoindent                       = true
---

--- Folding
vim.opt.foldnestmax                  = 10
vim.foldmethod                       = expr
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
---

vim.opt.conceallevel                 = 2                                                                      --  Enable concealing
vim.opt.laststatus                   = 2                                                                      --  Always display the status line
vim.opt.cursorline                   = true                                                                   --  Highlight current line
vim.opt.mouse                        = "a"                                                                    --  Enable mouse support

--- Searching
vim.opt.ignorecase                   = true
vim.opt.smartcase                    = true                                                                   --  case-sensitive if expression contains an uppercase letter
vim.opt.hlsearch                     = true                                                                   --  highlight search results
vim.opt.incsearch                    = true                                                                   --  Incremental search
---

vim.opt.lazyredraw                   = false                                                                  --  Don't redraw when executing macros
vim.opt.inccommand                   = "nosplit"                                                              --  show live substitution feedback in current buffer
vim.opt.magic                        = true                                                                   --  Activate magic for regex
vim.opt.splitbelow                   = true
vim.opt.splitright                   = true
vim.g.netrw_home                     = "~/.cache/nvim"                                                        --  Save netrw history in cache directory


vim.opt.completeopt                  = { "menu", "menuone", "noselect" }                                      --  completion options for nvim-cmp
