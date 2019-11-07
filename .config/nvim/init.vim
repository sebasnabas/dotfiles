""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" __   __   ___   __  __             ___     ___    _  _      ___    ___     ___  "
" \ \ / /  |_ _| |  \/  |    o O O  / __|   / _ \  | \| |    | __|  |_ _|   / __| "
"  \ V /    | |  | |\/| |   o      | (__   | (_) | | .` |    | _|    | |   | (_ | "
"  _\_/_   |___| |_|__|_|  TS__[O]  \___|   \___/  |_|\_|   _|_|_   |___|   \___| "
"_|""""|_|"""""|_|"""""| {======|_|"""""|_|"""""|_|"""""|_|""""|_|"""""|_|"""""|  "
"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader =","

"""""' Plugins '""""""""
call plug#begin('~/.local/share/nvim/plugged')

    "" Color scheme
    Plug 'sonph/onehalf', {'rtp': 'vim/'}

    "" Syntax highlighting
    Plug 'sheerun/vim-polyglot'

    " Utility
    "" File explorer
    Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}

    "" Zen mode
    Plug 'junegunn/goyo.vim'

    "" Easy change of surroundings
    Plug 'tpope/vim-surround'

    "" Easy replacing
    Plug 'vim-scripts/ReplaceWithRegister'

    "" Tmux
    """ Tmux navigation
    Plug 'christoomey/vim-tmux-navigator'

    """ Run commands in separate pane
    Plug 'benmills/vimux'

    " Generic Programming Support
    "" Comments
    Plug 'tpope/vim-commentary'

    "" Syntax checking
    Plug 'scrooloose/syntastic'

    "" Git Support
    Plug 'tpope/vim-fugitive'

    "" Show tags/structure in separate window
    Plug 'majutsushi/tagbar'

    "" Snippets
    " Track the engine.
    Plug 'Shougo/neosnippet.vim'

    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'
    Plug 'Shougo/neosnippet-snippets'

    "" Interface
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    "" Vim Wiki
    Plug 'vimwiki/vimwiki'

    "" Auto completion
    Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " Python
    Plug 'deoplete-plugins/deoplete-jedi'

call plug#end()
""""""""""""""""""""""""

"""' NERDTree '"""
    autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * NERDTree | wincmd p

    " display directory name in nerdtree statusline
    let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

    " the ignore patterns are regular expression strings and separated by comma
    let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

    map <C-n> :NERDTreeToggle <CR>

    " quit nerdtree if it's the last buffer left
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Show Dotfiles
    let NERDTreeShowHidden=1

"""' Goyo '"""
    let g:goyo_linenr=1

"""' Vimux '"""
    map <leader>vr :call VimuxRunCommand("run " . bufname("%")) <CR>
    map <leader>vt :call VimuxRunCommand("test .") <CR>

"""' Fugitive (Git Support) '"""
    set statusline+=%{FugitiveStatusline()}

    map <leader>gd :Gdiff<CR>
    map <leader>gD <C-w>h <C-W>c
    map <leader>gco :Gcommit<CR>

"""' Syntastic '"""
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_python_checkers = ['pylint']

    map <C-s> :SyntasticToggleMode <CR>

"""' Vim-Airline Configuration '"""
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#branch#empty_message = ''

"""' devicons '"""
    let g:webdevicons_enable = 1
    let g:webdevicons_enable_nerdtree = 1
    " adding the column to vimfiler
    let g:webdevicons_enable_vimfiler = 1
    " adding to vim-airline’s tabline
    let g:webdevicons_enable_airline_tabline = 1
    " adding to vim-airline’s statusline
    let g:webdevicons_enable_airline_statusline = 1
    " ctrlp glyphs
    let g:webdevicons_enable_ctrlp = 1
    " enable open and close folder/directory glyph flags (disabled by default with 0)
    let g:DevIconsEnableFoldersOpenClose = 1
    " enable folder/directory glyph flag (disabled by default with 0)
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1

"""' Deoplete '"""
    let g:deoplete#enable_at_startup = 1

"" NeoSnippet
    let g:neosnippet#snippets_directory=[$HOME.'/.local/share/nvim/plugged/vim-snippets/UltiSnips']

    " Plugin key-mappings.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

"" Deoplete Jedi
    let g:jedi#auto_close_doc = 1  " close preview window after completion


""""" END Plug Configuration


""""""""""""""""""""""""""""""""""""""
"" Configuration Section
""""""""""""""""""""""""""""""""""""""
    set nocompatible
    filetype plugin indent on
    syntax on
    set wrap
    set encoding=utf8
    set fileformat=unix

    " Searcch down into subfolders
    " Provides tab-completion for all file-related tasks
    set path+=**

    " Display all matching files when we tab complete
    set wildmenu

"" Enable autocompletion:
    set wildmode=longest,list,full

    " Detect if a file is changed
    set autoread

    " make backspace behave in a sane manner
    set backspace=indent,eol,start

    set formatoptions=jtcrql

" Display different types of white spaces.
    set list listchars=tab:›\·,space:·,eol:¬,extends:›,precedes:‹

" speed up scrolling
    set ttyfast

"" Show linenumbers
    set number
    set relativenumber
    set ruler

"" Set Proper Tabs
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set autoindent

" Enable folding
    set foldmethod=indent
    set foldnestmax=10
    set nofoldenable
    set foldlevel=2

"" Always display the status line
    set laststatus=2

"" Enable highlighting of the current line
    set cursorline

" Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros

    set magic " Set magic on, for regex

"" Splits open at the bottom and right
    set splitbelow splitright

"" Save netrw history in cache directory
    let g:netrw_home="$HOME/.cache/nvim/"

"""""' Autocommands '""""""
"" Runs a script that cleans out tex build files whenever I close out of a tex file.
    autocmd VimLeave *.tex !texclear %

"" Automatically deletes all trailing whitespace
    autocmd BufWritePre * %s/\s\+$//e

"" Enable syntax highlighting of rofi config
    autocmd BufNewFile,BufRead /*.rasi setf css

"" Enable syntax highlighting of svelte files
    autocmd BufNewFile,BufRead /*.svelte setf html


"""""' Mappings '"""""
"" Shortcutting split navigation
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

"" Spell-check set to <leader>o,'o' for orthography
    map <leader>o :setlocal spell! spelllang=en_us<CR>

"" Grammar-check set to <leader>g, 'g' for grammar
    map <leader>g :LanguageToolCheck <CR>

"" 'z' for zen
    map <leader>z :Goyo <CR>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
    vnoremap <C-c> "+y
    inoremap <C-v> <Esc>"+p

"" hardmode - no arrows
    cnoremap <Down> <Nop>
    cnoremap <Left> <Nop>
    cnoremap <Right> <Nop>
    cnoremap <Up> <Nop>

    inoremap <Down> <Nop>
    inoremap <Left> <Nop>
    inoremap <Right> <Nop>
    inoremap <Up> <Nop>

    nnoremap <Down> <Nop>
    nnoremap <Left> <Nop>
    nnoremap <Right> <Nop>
    nnoremap <Up> <Nop>

    vnoremap <Down> <Nop>
    vnoremap <Left> <Nop>
    vnoremap <Right> <Nop>
    vnoremap <Up> <Nop>

"" Compile document
    map <leader>c :w! \| !compiler <c-r>%<CR><CR>

"" Open corresponding pdf/.html or preview
    map <leader>v :!opout <c-r>%<CR><CR>

"" Jump to <++>
    map <leader>n <Esc>/<++><CR>c4l<Esc>:nohlsearch<CR><Esc>a

"" nohlsearch
    map <leader>s :nohlsearch <CR>

"" Help for word under cursor
    noremap <leader>h :execute "tab h " . expand("<cword>")<CR>

" Exit modes
    " map <Esc> <A-e>

" Set tab shortcuts
    nnoremap tn :tabnew <Space>
    nnoremap tk :tabnext <CR>
    nnoremap tj :tabprev <CR>
    nnoremap th :tabfirst <CR>
    nnoremap tl :tablast <CR>
    nnoremap tc :tabclose <CR>

"""""""""""""""""

"""' Python '"""
" highlighting
    let python_highlight_all=1

""' debugging '""
    func! s:SetBreakpoint()
        cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import ipdb; ipdb.set_trace()')
    endf

    func! s:RemoveBreakpoint()
        exe 'silent! g/^\s*import\sipdb\;\?\n*\s*ipdb.set_trace()/d'
    endf

    func! s:ToggleBreakpoint()
        if getline('.')=~#'^\s*import\sipdb' | cal s:RemoveBreakpoint() | el | cal s:SetBreakpoint() | en
    endf

" Toggle breakpoint
    nnoremap <F6> :call <SID>ToggleBreakpoint()<CR>

" Start debugging - Split window and call ipdb with current file
    nnoremap <F5> <C-w>s :term ipdb3 -c continue % <CR> A

" Remove all breakppoints when saving
    autocmd QuitPre *.py autocmd BufWritePre * silent g/^\s*import\sipdb\;\?\n*\s*ipdb\.set_trace()/normal dd

""""""""""""""""""""

"" Theme and Styling
    colorscheme onehalfdark
    set background=dark
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif

    highlight NonText guifg=#5c6370

