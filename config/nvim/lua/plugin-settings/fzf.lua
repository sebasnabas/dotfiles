vim.cmd([[
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
]])

-- [Buffers] Jump to the existing window if possible
vim.cmd("let g:fzf_buffers_jump = 1")

-- [[B]Commits] Customize the options used by 'git log':
vim.cmd("let g:fzf_commits_log_options = '--graph --color=always --format=\"%C(auto)%h%d %s %C(black)%C(bold)%cr\"'")

-- [Tags] Command to generate tags file
vim.cmd("let g:fzf_tags_command = 'ctags -R'")

-- Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
]])

-- Likewise, Files command with preview window
vim.cmd([[
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
]])

-- Customize fzf colors to match your color scheme
vim.cmd([[
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
]])

vim.cmd([[
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif
]])
