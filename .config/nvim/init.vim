" __   __   ___   __  __             ___     ___    _  _      ___    ___     ___  "
" \ \ / /  |_ _| |  \/  |    o O O  / __|   / _ \  | \| |    | __|  |_ _|   / __| "
"  \ V /    | |  | |\/| |   o      | (__   | (_) | | .` |    | _|    | |   | (_ | "
"  _\_/_   |___| |_|__|_|  TS__[O]  \___|   \___/  |_|\_|   _|_|_   |___|   \___| "
"_|""""|_|"""""|_|"""""| {======|_|"""""|_|"""""|_|"""""|_|""""|_|"""""|_|"""""|  "
"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' "

let mapleader = ","

"""' Plugins '"""{{{
    """' Plugins listing '"""{{{
        call plug#begin('~/.local/share/nvim/plugged')

            "" Color scheme
            Plug 'rakr/vim-one'

            "" Syntax highlighting
            Plug 'sheerun/vim-polyglot'

            " Utility
            "" File explorer
            Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
            Plug 'Xuyuanp/nerdtree-git-plugin'
            Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

            "" Easy change of surroundings
            Plug 'tpope/vim-surround'

            "" Repetition of plugin commands
            Plug 'tpope/vim-repeat'

            "" Moving from previous to next
            Plug 'tpope/vim-unimpaired'

            "" Auto pairs
            Plug 'tmsvg/pear-tree'

            "" Titlecase
            Plug 'christoomey/vim-titlecase'

            "" Easy replacing
            Plug 'vim-scripts/ReplaceWithRegister'

            "" Buffer navigation
            Plug 'jeetsukumaran/vim-buffergator'

            "" Undo tree
            Plug 'simnalamburt/vim-mundo'

            "" Tags
            Plug 'majutsushi/tagbar'
            Plug 'ludovicchabant/vim-gutentags'

            "" Fuzzy file finder
            Plug 'junegunn/fzf.vim'

            "" Multiline-Singleline
            Plug 'andrewradev/splitjoin.vim'

            "" Tmux
            """ Tmux navigation
            Plug 'christoomey/vim-tmux-navigator'

            """ Run commands in separate pane
            Plug 'benmills/vimux'

            " Generic Programming Support
            "" Comments
            Plug 'tpope/vim-commentary'

            "" Syntax checking
            Plug 'dense-analysis/ale'

            "" Git Support
            Plug 'tpope/vim-fugitive'
            Plug 'airblade/vim-gitgutter'
            Plug 'APZelos/blamer.nvim'

            "" Highlighting yank
            Plug 'machakann/vim-highlightedyank'

            "" Show hex colors
            Plug 'chrisbra/Colorizer'

            ""Show markers
            Plug 'kshenoy/vim-signature'

            "" Toggle location and quickfix list
            Plug 'milkypostman/vim-togglelist'

            "" Snippets
            Plug 'SirVer/ultisnips'

            Plug 'honza/vim-snippets'

            "" Interface
            Plug 'ryanoasis/vim-devicons'
            Plug 'vim-airline/vim-airline'
            Plug 'vim-airline/vim-airline-themes'
            Plug 'bling/vim-bufferline'
            Plug 'Yggdroot/indentLine'

            "" Vim Wiki
            Plug 'vimwiki/vimwiki'

            "" Taskwiki
            Plug 'tools-life/taskwiki'

            "" Codi scratchpad
            Plug 'metakirby5/codi.vim'

            "" Auto completion
            Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

            "Languages
            "" Dotnet/C#
            Plug 'OmniSharp/omnisharp-vim'

            "" Docker
            Plug 'ekalinin/Dockerfile.vim'

            "" Go
            Plug 'zchee/deoplete-go', { 'do': 'make'}
            Plug 'stamblerre/gocode', {'rtp': 'nvim/'}

            "" Python
            Plug 'deoplete-plugins/deoplete-jedi'
            Plug 'jmcantrell/vim-virtualenv'

            "" C++
            Plug 'deoplete-plugins/deoplete-clang'
            Plug 'Shougo/neoinclude.vim'

            "" Rust
            " Plug 'rust-lang/rust.vim'
            Plug 'sebastianmarkow/deoplete-rust'

            "" Haskell
            Plug 'eagletmt/neco-ghc'

            "" Latex
            Plug 'lervag/vimtex'

            "" Markdown
            Plug 'plasticboy/vim-markdown'

        call plug#end()
"   }}}

    """' Plugin configuration'"""{{{
        """' NERDTree '""" {{{
            autocmd StdinReadPre * let s:std_in=1

            let g:NERDTreeWinSize=40

            " display directory name in nerdtree statusline
            let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

            " the ignore patterns are regular expression strings and separated by comma
            let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', 'bin$', 'obj$']

            " quit nerdtree if it's the last buffer left
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

            " Show Dotfiles
            let NERDTreeShowHidden=1

            " Git indicators
            let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "✹",
                \ "Staged"    : "✚",
                \ "Untracked" : "✭",
                \ "Renamed"   : "➜",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "✖",
                \ "Dirty"     : "✗",
                \ "Clean"     : "✔︎",
                \ 'Ignored'   : '☒',
                \ "Unknown"   : "?"
            \ }

            let g:NERDTreeFileExtensionHighlightFullName = 1
            let g:NERDTreeExactMatchHighlightFullName = 1
            let g:NERDTreePatternMatchHighlightFullName = 1
            let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
            let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
        "}}}

        """' pear-tree '""" {{{
            let g:pear_tree_smart_backspace = 1
            augroup latex_pairs
                autocmd!
                autocmd FileType tex let b:pear_tree_pairs = extend(g:pear_tree_pairs, { '$': {'closer': ' $'} })
            augroup END
        "}}}

        """' vim-mundo '"""{{{
            let g:mundo_right = 1
        "}}}

        ""' Gutentags '""{{{
            let g:gutentags_cache_dir='~/.cache/nvim/tags'
            let g:gutentags_generate_on_write=1

            let g:gutentags_ctags_exclude = [
                  \ '*.git', '*.svg', '*.hg',
                  \ '*/tests/*',
                  \ 'build',
                  \ 'dist',
                  \ '*sites/*/files/*',
                  \ 'bin',
                  \ 'node_modules',
                  \ 'bower_components',
                  \ 'cache',
                  \ 'compiled',
                  \ 'docs',
                  \ 'example',
                  \ 'bundle',
                  \ 'vendor',
                  \ '*.md',
                  \ '*-lock.json',
                  \ '*.lock',
                  \ '*bundle*.js',
                  \ '*build*.js',
                  \ '.*rc*',
                  \ '*.json',
                  \ '*.min.*',
                  \ '*.map',
                  \ '*.bak',
                  \ '*.zip',
                  \ '*.pyc',
                  \ '*.class',
                  \ '*.sln',
                  \ '*.Master',
                  \ '*.csproj',
                  \ '*.tmp',
                  \ '*.csproj.user',
                  \ '*.cache',
                  \ '*.pdb',
                  \ 'tags*',
                  \ 'cscope.*',
                  \ '*.css',
                  \ '*.less',
                  \ '*.scss',
                  \ '*.exe', '*.dll',
                  \ '*.mp3', '*.ogg', '*.flac',
                  \ '*.swp', '*.swo',
                  \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
                  \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
                  \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
                  \ ]
        "}}}

        """' Fzf '"""{{{
            let g:fzf_action = {
              \ 'ctrl-t': 'tab split',
              \ 'ctrl-s': 'split',
              \ 'ctrl-v': 'vsplit' }

            " [Buffers] Jump to the existing window if possible
            let g:fzf_buffers_jump = 1

            " [[B]Commits] Customize the options used by 'git log':
            let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

            " [Tags] Command to generate tags file
            let g:fzf_tags_command = 'ctags -R'

            " Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
            command! -bang -nargs=* Rg
              \ call fzf#vim#grep(
              \   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
              \   <bang>0 ? fzf#vim#with_preview('up:60%')
              \           : fzf#vim#with_preview('right:50%:hidden', '?'),
              \   <bang>0)

            " Likewise, Files command with preview window
            command! -bang -nargs=? -complete=dir Files
              \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

            " Customize fzf colors to match your color scheme
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

            if exists('$TMUX')
              let g:fzf_layout = { 'tmux': '-p90%,60%' }
            else
              let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
            endif
        "}}}

        """' Fugitive (Git Support) '"""{{{
            set statusline+=%{FugitiveStatusline()}

            " Move git patch always to the right and make it vertical
            " autocmd BufEnter term://.//*:git\ *\ add\ --patch\ --\ * wincmd L
            " autocmd BufEnter term://.//*:git\ *\ reset\ --patch\ --\ * wincmd L
            " autocmd BufEnter term://.//*:git\ *\ add\ --intent-to-add\ --\ * wincmd L
        "}}}

        """' Blamer '"""{{{
            let g:blamer_enabled = 1
            let g:blamer_delay = 500
        "}}}

        """' Ale '"""{{{
            let g:airline#extensions#ale#enabled = 1
            let g:ale_open_list = 1
            let g:ale_linters = {
                  \ 'cs': ['OmniSharp'],
                  \ 'python': ['pylint'],
                  \ 'rust': ['analyzer'],
                  \ 'tex': ['chktex', 'vale', 'languagetool']
             \}

            let g:ale_c_parse_makefile = 1
            let g:ale_writegood_options = '--no-thereIs --no-passive --no-tooWordy'

            let g:ale_virtualenv_dir_names = ['venv']
            let g:ale_python_pylint_use_global = 0

            " let g:ale_rust_carg
            let g:ale_echo_msg_format = '[%linter%][%severity%: %code%] %s'
            let g:ale_list_window_size = 5

            augroup CloseLoclistWindowGroup
              autocmd!
              autocmd QuitPre * if empty(&buftype) | lclose | endif
            augroup END
        "}}}

        """' Vim-Airline '"""{{{
            let g:airline#extensions#tabline#enabled = 1
            let g:airline_powerline_fonts = 1
            let g:airline#extensions#branch#format = 2
            let g:airline#extensions#branch#displayed_head_limit = 20
        "}}}

        """' Bufferline '"""{{{
            let g:bufferline_echo = 0
            let g:bufferline_pathshorten = 1
            let g:bufferline_active_buffer_left = '['
            let g:bufferline_active_buffer_right = ']'
            let g:bufferline_modified = '~'
            let g:bufferline_fname_mod = ':t'
        "}}}

        """' IndentLine '"""{{{
            let g:indentLine_setConceal = 2
            " default ''.
            " n for Normal mode
            " v for Visual mode
            " i for Insert mode
            " c for Command line editing, for 'incsearch'
            let g:indentLine_concealcursor = ""
        " }}}

        """' devicons '"""{{{
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
        "}}}

        """' Ultisnips '"""{{{
            let g:UltiSnipsExpandTrigger="<c-k>"
            let g:UltiSnipsJumpForwardTrigger="<c-k>"
            let g:UltiSnipsJumpBackwardTrigger="<c-b>"
            let g:UltiSnipsEditSplit="vertical"
        "}}}

        """' Vimwiki '"""{{{
            let g:vimwiki_list = [{'path': '~/Documents/Notes/VimWiki/',
                                  \ 'syntax': 'markdown', 'ext': '.md'}]
            let g:vimwiki_global_ext=0
        " }}}

        """' Taskwiki '"""{{{
            let g:taskwiki_disable_concealcursor='yes'
       "}}}

        """' Codi '"""{{{
            let g:codi#width = 20
        " }}}

        """' Deoplete '"""{{{
            let g:deoplete#enable_at_startup = 1

            " Use smartcase.
            call deoplete#custom#option('smart_case', v:true)

            " Use OmniSharp-vim omnifunc
            call deoplete#custom#source('omni', 'functions', { 'cs':  'OmniSharp#Complete' })

            " Set how Deoplete filters omnifunc output.
            call deoplete#custom#var('omni', 'input_patterns', {
                    \ 'cs': '[^. *\t]\.\w*',
                    \ 'tex': g:vimtex#re#deoplete
            \})
        "}}}

        """' Deoplete Jedi '"""{{{
            let g:jedi#auto_close_doc = 1  " close preview window after completion
            autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
        "}}}

        """' Deoplete Rust '""" {{{
            let g:deoplete#sources#rust#racer_binary = "$HOME/.cargo/bin/racer"
            let g:deoplete#sources#rust#rust_source_path = "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
        "}}}

        """' Omnisharp '"""{{{
            " Use the stdio OmniSharp-roslyn server
            let g:OmniSharp_server_use_mono = 0
            let g:OmniSharp_server_stdio = 1
            let g:OmniSharp_server_http = 0
            let g:OmniSharp_highlight_types = 3
            let g:OmniSharp_highlight_groups = {
                \ 'csUserIdentifier': [
                \  'constant name', 'enum member name', 'field name', 'identifier',
                \  'local name', 'parameter name', 'property name', 'static symbol'],
                \ 'csUserInterface': ['interface name'],
                \ 'csUserMethod': ['extension method name', 'method name'],
                \ 'csUserType': ['class name', 'enum name', 'namespace name', 'struct name']
                \}

            " Set the type lookup function to use the preview window instead of echoing it
            let g:OmniSharp_typeLookupInPreview = 1

            " Timeout in seconds to wait for a response from the server
            let g:OmniSharp_timeout = 5

            " Fetch full documentation during omnicomplete requests.
            " By default, only Type/Method signatures are fetched. Full documentation can
            " still be fetched when you need it with the :OmniSharpDocumentation command.
            let g:omnicomplete_fetch_full_documentation = 1
        "}}}

        """' Virtualenv '"""{{{
            let g:virtualenv_stl_format = '(%n)'
        "}}}

        """' Vimux '"""{{{
            let g:VimuxUseNearest=0
        "}}}

        """' Vimtex '"""{{{
            let g:tex_flavor = 'latex'
        "}}}

        """' Markdown '"""{{{
            " disable header folding
            " let g:vim_markdown_folding_disabled = 1

            let g:markdown_folding = 1

            " do not use conceal feature, the implementation is not so good
            let g:vim_markdown_conceal = 0

            " disable math tex conceal feature
            " let g:tex_conceal = ""
            let g:vim_markdown_math = 1

            " support front matter of various format
            let g:vim_markdown_frontmatter = 1  " for YAML format
            let g:vim_markdown_toml_frontmatter = 1  " for TOML format
            let g:vim_markdown_json_frontmatter = 1  " for JSON format
        "}}}
    "}}}
"}}}

"""' Configuration '"""{{{
    filetype plugin indent on
    syntax on
    set wrap
    set encoding=utf8
    set fileformat=unix
    set updatetime=99
    set spelllang=en_us,de

    " Enable local rc file
    set exrc
    set secure

    " Keep the cursor on the same column
    set nostartofline

    " Search down into subfolders
    " Provides tab-completion for all file-related tasks
    set path+=**

    " Tags
    set tags='~/.cache/nvim/tags'

    " Use persistent history.
    set undofile

    " Display all matching files when we tab complete
    set wildmenu

    " Enable autocompletion:
    set wildmode=longest,list,full

    " Detect if a file is changed
    set autoread

    " make backspace behave in a sane manner
    set backspace=indent,eol,start

    au BufEnter * set fo-=l fo-=o

    " Display different types of white spaces.
    set list listchars=tab:›\·,space:·,eol:¬,extends:›,precedes:‹

    " speed up scrolling
    set ttyfast

    "" Show linenumbers
    set relativenumber
    set ruler

    "" Set Proper Tabs
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set autoindent

    autocmd FileType json setlocal shiftwidth=2 tabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

    " Enable folding
    set foldmethod=syntax
    set foldnestmax=10
    set nofoldenable
    set foldlevel=2
    set foldtext=gitgutter#fold#foldtext()
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType xml setlocal foldmethod=indent
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType lua setlocal foldmethod=marker

    "" Always display the status line
    set laststatus=2

    "" Enable highlighting of the current line
    set cursorline

    "" Enable mouse scrolling
    set mouse=a

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros

    "" Show live substitution feedback in current buffer
    set inccommand=nosplit

    set magic " Set magic on, for regex

    "" Splits open at the bottom and right
    set splitbelow splitright

    "" Save netrw history in cache directory
    let g:netrw_home="$HOME/.cache/nvim/"

    """' Autocommands '{{{
        "" Runs a script that cleans out tex build files whenever I close out of a tex file.
        autocmd VimLeave *.tex !texclear %

        "" Activate spell checking when opening a text file
        autocmd FileType tex setlocal spell
        autocmd FileType markdown setlocal spell
        autocmd FileType text setlocal spell
        autocmd FileType html setlocal spell

        "" Automatically deletes all trailing whitespace
        autocmd BufWritePre * %s/\s\+$//e

        "" Enable syntax highlighting of rofi config
        autocmd BufNewFile,BufRead /*.rasi setf css

        "" Enable syntax highlighting of svelte files
        autocmd BufNewFile,BufRead /*.svelte setf html

        " I like relative numbering when in normal mode.
        autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 relativenumber

        " Prefer Neovim terminal insert mode to normal mode.
        autocmd BufEnter term://* startinsert

    "}}}

"}}}

"""' Mappings and Functions '"""{{{
    "" Why is this not default?
    nnoremap Y y$

    "" Default in most editors - for muscle memory
    inoremap <C-s> <Esc>:w<CR>a

    "" Shortcutting split navigation
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
    nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
    nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
    nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
    nnoremap <silent> <C-\> :TmuxNavigatePrevious<CR>

    "" Create splits
    nnoremap <leader>sv :vsplit<CR>:enew<CR>
    nnoremap <leader>sh :split<CR>:enew<CR>

    "" Terminal split
    nnoremap <leader>svt :vsplit<CR>:term<CR>:startinsert<CR>
    nnoremap <leader>sht :split<CR>:term<CR>:startinsert<CR>

    "" Terminal
    " Make escape work in the Neovim terminal.
    tnoremap <Esc> <C-\><C-n>

    " Make navigation into and out of Neovim terminal splits nicer.
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l

    "" Create and change directory
    function! Mdc(directory) "{{{
        execute '!mkdir ' . a:directory
        execute 'chdir ' . a:directory
    endfunction
    "}}}
    command! -nargs=1 Mdc call Mdc( '<args>' )

    nnoremap <leader>mdc :Mdc<Space>

    "" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
    vnoremap <C-c> "+y
    inoremap <C-v> <Esc>"+p

    "" hardmode - no arrows
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
    map <leader><Space> <Esc>/<++><CR>c4l<Esc>:nohlsearch<CR><Esc>a

    "" Help for word under cursor
    noremap <leader>h :execute "tab h " . expand("<cword>")<CR>

    "" Search and replace word under cursor
    nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

    " Set tab shortcuts
    nnoremap tn :tabnew <Space>
    nnoremap tk :tabnext <CR>
    nnoremap tj :tabprev <CR>
    nnoremap th :tabfirst <CR>
    nnoremap tl :tablast <CR>
    nnoremap tc :tabclose <CR>
    nnoremap <a-1> 1gt
    nnoremap <a-2> 2gt
    nnoremap <a-3> 3gt
    nnoremap <a-4> 4gt
    nnoremap <a-5> 5gt
    nnoremap <a-6> 6gt
    nnoremap <a-7> 7gt
    nnoremap <a-8> 8gt
    nnoremap <a-9> 9gt

    " Easily edit vimrc
    nnoremap <leader>ev :e $MYVIMRC <CR>

    " Easy reload
    nnoremap <leader>so :so
    nnoremap <leader>sov :so $MYVIMRC<CR>

    " Folds
    nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
    nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
    function! NextClosedFold(dir)
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
    endfunction

    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

    """' Plugin Mappings '"""{{{
        ""' Nerdtree: '"""{{{
            map <C-n> :NERDTreeToggle <CR>
        "}}}
        ""' Mundo:"{{{
            nnoremap <C-u> :MundoToggle<CR>
        "}}}
        ""' Tagbar '"""{{{
            nnoremap <C-t> :TagbarToggle<CR>
        "}}}
        ""' Fzf '"""{{{
            " current file directory
            nnoremap <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<CR>/<CR>
            " current working directory
            nnoremap <leader>fb :Buffers<CR>
            nnoremap <leader>ff :Files<CR>
            nnoremap <leader>fl :Lines<CR>
            nnoremap <leader>fbl :BLines<CR>
            nnoremap <leader>ft :Tags<CR>
            nnoremap <leader>fr :History<CR>
            nnoremap <leader>fh :Helptags<CR>
            nnoremap <leader>f: :History:<CR>
            nnoremap <leader>f/ :History/<CR>
            nnoremap <leader>fg :GFiles<CR>
            nnoremap <leader>fs :GFiles?<CR>
            nnoremap <leader>fc :Commits<CR>
            nnoremap <leader>fm :Marks<CR>
            nnoremap <leader>fp :Maps<CR>

            command! -bang -nargs=* Rg
              \ call fzf#vim#grep(
              \   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
              \   fzf#vim#with_preview(), <bang>0)
            "}}}
            ""' Vimux '""{{{
            map <leader>vr :call VimuxRunCommand("clear; run " . expand("%:p")) <CR>
            map <leader>vt :call VimuxRunCommand("clear; unittest " . &filetype) <CR>
            map <Leader>vp :VimuxPromptCommand<CR>
            map <Leader>vl :VimuxRunLastCommand<CR>
            map <Leader>vi :VimuxInspectRunner<CR>
            map <Leader>vq :VimuxCloseRunner<CR>
            map <Leader>vx :VimuxInterruptRunner<CR>
            map <Leader>vz :call VimuxZoomRunner()<CR>
        "}}}
        ""' Fugitive '"""{{{
            nnoremap <leader>gc :Git commit<CR>
            nnoremap <leader>gca :Git commit --amend<CR>
            nnoremap <leader>gco :Git checkout<Space>
            nnoremap <leader>gcb :Git checkout -b<Space>
            nnoremap <leader>gd :Gdiffsplit<CR>
            nnoremap <leader>glg :Gclog<CR>
            nnoremap <leader>gp :Git push<CR>
            nnoremap <leader>gfe :Gfetch<CR>
            nnoremap <leader>gl :Git pull<CR>
            nnoremap <leader>gm :Git merge<Space>
            nnoremap <leader>gr :Git revert<Space>
            nnoremap <leader>gs :Git<CR>
            nnoremap <leader>gw :Gwrite<CR>

        "}}}
        """' Vimwiki '"""{{{
            nnoremap <Leader>wf :VimwikiFollowLink<CR>

            " Find next link in the current page.
            nnoremap <Leader>wn :VimwikiNextLink<CR>

            " Find previous link in the current page.
            nnoremap <Leader>wp :VimwikiPrevLink<CR>

            " Rename wiki page you are in.
            nnoremap <Leader>wr :VimwikiRenameLink<CR>
        "}}}
        ""' Togglelist '""{{{
            nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
            nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
        "}}}

    "}}}
"}}}

"""' Theme and Styling '"""{{{
    let python_highlight_all=1

    set termguicolors

    set background=dark
    let g:one_allow_italics = 1 " I love italic for comments
    colorscheme one

    let g:airline_theme='base16'
"}}}

