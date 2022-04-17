function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "Y", "y$")

vim.cmd("let g:tmux_navigator_no_mappings = 1")

map("n", "<C-h>", ":TmuxNavigateLeft<CR>", {silent = true})
map("n", "<C-j>", ":TmuxNavigateDown<CR>", {silent = true})
map("n", "<C-k>", ":TmuxNavigateUp<CR>", {silent = true})
map("n", "<C-l>", ":TmuxNavigateRight<CR>", {silent = true})
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", {silent = true})

-- Copy & paste
map("v", "<C-c>", "\"+y")
map("i", "<C-v>", "<Esc>\"+pi")

-- Compile document
map("n", "<leader>c", ":w! \\| !compiler <c-r>%<CR><CR>")
-- Open corresponding pdf/.html or preview
map("n", "<leader>v", ":!opout <c-r>%<CR><CR>")

-- Jump to <++>
map("n", "<leader><Space>", "<Esc>/<++><CR>c4l<Esc>:nohlsearch<CR><Esc>a")

-- Search and replace word under cursor
map("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")

-- Close all buffers except current
map("n", "<leader>o", ":%bd\\|e#\\|bd#<cr>")

-- Set tab shortcuts
map("n", "tn", ":tabnew <Space>")
map("n", "tk", ":tabnext <CR>")
map("n", "tj", ":tabprev <CR>")
map("n", "th", ":tabfirst <CR>")
map("n", "tl", ":tablast <CR>")
map("n", "tc", ":tabclose <CR>")
map("n", "<a-1>", "1gt")
map("n", "<a-2>", "2gt")
map("n", "<a-3>", "3gt")
map("n", "<a-4>", "4gt")
map("n", "<a-5>", "5gt")
map("n", "<a-6>", "6gt")
map("n", "<a-7>", "7gt")
map("n", "<a-8>", "8gt")
map("n", "<a-9>", "9gt")

-- Easily edit vimrc
map("n", "<leader>ev", ":e $MYVIMRC <CR>")

-- Easy reload
map("n", "<leader>so", ":so")
map("n", "<leader>sov", ":so $MYVIMRC<CR>")

-- Folds
map("n", "<silent>", "<leader>zj :call NextClosedFold('j')<cr>")
map("n", "<silent>", "<leader>zk :call NextClosedFold('k')<cr>")
vim.cmd([[function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction]])

-- Fugitive
map("n", "<leader>gcc", ":Git commit<CR>")
map("n", "<leader>gca", ":Git commit --amend<CR>")
map("n", "<leader>gco", ":Git checkout<Space>")
map("n", "<leader>gcb", ":Git checkout -b<Space>")
map("n", "<leader>gd", ":Gdiffsplit<CR>")
map("n", "<leader>glg", ":Gclog<CR>")
map("n", "<leader>gp", ":Git push<CR>")
map("n", "<leader>gfe", ":Git fetch<CR>")
map("n", "<leader>gl", ":Git pull<CR>")
map("n", "<leader>gm", ":Git merge<Space>")
map("n", "<leader>gr", ":Git revert<Space>")
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gw", ":Gwrite<CR>")

-- Mundo
map("n", "<C-u>", ":MundoToggle<CR>")

-- FZF
-- current file directory
map("n", "<leader>-", ":FZF <c-r>=fnameescape(expand('%:p:h'))<CR>/<CR>")
-- current working directory
map("n", "<leader>fb", ":Buffers<CR>")
map("n", "<leader>ff", ":Files<CR>")
map("n", "<leader>fl", ":Lines<CR>")
map("n", "<leader>fbl", ":BLines<CR>")
map("n", "<leader>ft", ":Tags<CR>")
map("n", "<leader>fr", ":History<CR>")
map("n", "<leader>fh", ":Helptags<CR>")
map("n", "<leader>f:", ":History:<CR>")
map("n", "<leader>f/", ":History/<CR>")
map("n", "<leader>fg", ":GFiles<CR>")
map("n", "<leader>fs", ":GFiles?<CR>")
map("n", "<leader>fc", ":Commits<CR>")
map("n", "<leader>fm", ":Marks<CR>")
map("n", "<leader>fp", ":Maps<CR>")

vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
]])

--- Gitsigns
-- Navigation
map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

-- Actions
map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

-- Text object
map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
---
