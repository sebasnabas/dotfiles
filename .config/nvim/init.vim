" __   __   ___   __  __             ___     ___    _  _      ___    ___     ___  "
" \ \ / /  |_ _| |  \/  |    o O O  / __|   / _ \  | \| |    | __|  |_ _|   / __| "
"  \ V /    | |  | |\/| |   o      | (__   | (_) | | .` |    | _|    | |   | (_ | "
"  _\_/_   |___| |_|__|_|  TS__[O]  \___|   \___/  |_|\_|   _|_|_   |___|   \___| "
"_|""""|_|"""""|_|"""""| {======|_|"""""|_|"""""|_|"""""|_|""""|_|"""""|_|"""""|  "
"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' "

let mapleader =","

"""' Plugins '"""{{{
    """' Plugins listing '"""{{{
        call plug#begin('~/.local/share/nvim/plugged')

            "" Color scheme
            Plug 'sonph/onehalf', {'rtp': 'vim/'}

            "" Syntax highlighting
            Plug 'sheerun/vim-polyglot'

            " Utility
            "" File explorer
            Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
            Plug 'Xuyuanp/nerdtree-git-plugin'
            Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

            "" Zen mode
            Plug 'junegunn/goyo.vim'

            "" Easy change of surroundings
            Plug 'tpope/vim-surround'

            "" Repetition of plugin commands
            Plug 'tpope/vim-repeat'

            "" Moving from previous to next
            Plug 'tpope/vim-unimpaired'

            "" Auto pairs
            Plug 'tmsvg/pear-tree'

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
            Plug '~/.fzf'
            Plug 'junegunn/fzf.vim'

            "" Tmux
            """ Tmux navigation
            Plug 'christoomey/vim-tmux-navigator'

            """ Run commands in separate pane
            Plug 'benmills/vimux'

            """ Tmux statusline
            Plug 'edkolev/tmuxline.vim'

            " Generic Programming Support
            "" Comments
            Plug 'tpope/vim-commentary'

            "" Syntax checking
            Plug 'dense-analysis/ale'

            "" Git Support
            Plug 'tpope/vim-fugitive'
            Plug 'airblade/vim-gitgutter'

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
            """ Python
            Plug 'deoplete-plugins/deoplete-jedi'

            "" Codi scratchpad
            Plug 'metakirby5/codi.vim'

            "Languages
            "" Dotnet/C#
            Plug 'OmniSharp/omnisharp-vim'

            "" Dockerfiles
            Plug 'ekalinin/Dockerfile.vim'

        call plug#end()
"   }}}

    """' Plugin configuration'"""{{{
        """' NERDTree '""" {{{
            autocmd StdinReadPre * let s:std_in=1
            " autocmd VimEnter * NERDTree | wincmd p

            " display directory name in nerdtree statusline
            let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

            " the ignore patterns are regular expression strings and separated by comma
            let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

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

        """' Goyo '""" {{{
            let g:goyo_linenr=1

        "}}}

        """' vim-mundo '"""{{{
            let g:mundo_right = 1
        "}}}

        ""' Gutetags '""{{{
            let g:gutentags_cache_dir='~/.cache/nvim/tags'
            let g:gutentags_generate_on_write=1
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
              \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
              \   <bang>0 ? fzf#vim#with_preview('up:60%')
              \           : fzf#vim#with_preview('right:50%:hidden', '?'),
              \   <bang>0)

            " Likewise, Files command with preview window
            command! -bang -nargs=? -complete=dir Files
              \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

            " Customize fzf colors to match your color scheme
            let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
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
        "}}}

        """' Fugitive (Git Support) '"""{{{
            set statusline+=%{FugitiveStatusline()}
        "}}}

        """' Ale '"""{{{
            let g:airline#extensions#ale#enabled = 1
            let g:ale_python_auto_pipenv = 1

            function! AleCheckHook(errors)
                if !empty(a:errors)
                    let g:ale_loc_list_height = min([len(a:errors), 10])
                endif
            endfunction
        "}}}

        """' Vim-Airline '"""{{{
            let g:airline#extensions#tabline#enabled = 1
            let g:airline_powerline_fonts = 1
            let g:airline#extensions#branch#enabled = 1
            let g:airline#extensions#branch#empty_message = ''
        "}}}

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

        """' Deoplete '"""{{{
            let g:deoplete#enable_at_startup = 1
        "}}}

        """' NeoSnippet '"""{{{
            " Enable snipMate compatibility feature.
            let g:neosnippet#enable_snipmate_compatibility = 1

            " Tell Neosnippet about the other snippets
            let g:neosnippet#snippets_directory=$HOME.'/.local/share/nvim/plugged/vim-snippets/snippets'
        "}}}

        """' Deoplete Jedi '"""{{{
            let g:jedi#auto_close_doc = 1  " close preview window after completion
        "}}}
    "}}}
"}}}

"""' Configuration '"""{{{
    set nocompatible
    filetype plugin indent on
    syntax on
    set wrap
    set encoding=utf8
    set fileformat=unix
    set updatetime=99

    " Search down into subfolders
    " Provides tab-completion for all file-related tasks
    set path+=**

    " Tags
    set tags='~/.cache/nvim/tags'

    " Display all matching files when we tab complete
    set wildmenu

    " Enable autocompletion:
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
    set foldmethod=syntax
    set foldnestmax=10
    set nofoldenable
    set foldlevel=2
    set foldtext=gitgutter#fold#foldtext()
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType vim setlocal foldmethod=marker

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

    """' Autocommands '{{{
        "" Runs a script that cleans out tex build files whenever I close out of a tex file.
        autocmd VimLeave *.tex !texclear %

        "" Automatically deletes all trailing whitespace
        autocmd BufWritePre * %s/\s\+$//e

        "" Enable syntax highlighting of rofi config
        autocmd BufNewFile,BufRead /*.rasi setf css

        "" Enable syntax highlighting of svelte files
        autocmd BufNewFile,BufRead /*.svelte setf html

    "}}}

"}}}

"""' Mappings '"""{{{
    "" Why is this not default?
    nnoremap Y y$

    "" Shortcutting split navigation
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

    "" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
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

    "" Help for word under cursor
    noremap <leader>h :execute "tab h " . expand("<cword>")<CR>

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

    """' Plugin Mappings '"""{{{
        ""' Unimpaired: '""{{{
            nmap < [
            nmap > ]
            omap < [
            omap > ]
            xmap < [
            xmap > ]
        "}}}
        ""' Nerdtree: '"""{{{
            map <C-n> :NERDTreeToggle <CR>
        "}}}
        "' Goyo: '"""{{{
            " 'z' for zen
            map <leader>z :Goyo <CR>
        "}}}
        ""' Mundo:"{{{
            nnoremap <C-u> :MundoToggle<CR>
        "}}}
        ""' Tagbar '"""{{{
            nnoremap <C-t> :TagbarToggle<CR>
        "}}}
        ""' Fzf '"""{{{
            " current file directory
            nnoremap <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>
            " current working directory
            nnoremap <leader>fb :Buffers<cr>
            nnoremap <leader>ff :Files ~<cr>
            nnoremap <leader>fl :Lines<cr>
            nnoremap <leader>fbl :BLines<cr>
            nnoremap <leader>ft :Tags<cr>
            nnoremap <leader>fr :History<cr>
            nnoremap <leader>fh :Helptags<cr>
            nnoremap <leader>f: :History:<cr>
            nnoremap <leader>f/ :History/<cr>
            nnoremap <leader>fg :GFiles<cr>
            nnoremap <leader>fs :GFiles?<cr>
            nnoremap <leader>fc :Commits<cr>
        "}}}
        ""' Vimux '""{{{
            map <leader>vr :call VimuxRunCommand("run " . bufname("%")) <CR>
            map <leader>vt :call VimuxRunCommand("test .") <CR>
        "}}}
        ""' Fugitive '"""{{{
            nnoremap <leader>gc :Gcommit<CR>
            nnoremap <leader>gca :Gcommit --amend<CR>
            nnoremap <leader>gco :Git checkout
            nnoremap <leader>gcb :Git checkout -b
            nnoremap <leader>gd :Gdiffsplit<CR>
            nnoremap <leader>gD <C-w>h <C-W>c
            nnoremap <leader>gl :Gclog<CR>
            nnoremap <leader>gp :Gpush<CR>
            nnoremap <leader>gm :Gmerge
            nnoremap <leader>gs :Gstatus<CR>
            nnoremap <leader>gw :Gwrite<CR>

        "}}}
        ""' Neosnippet '"""{{{
            "' Note: It must be "imap" and "smap".  It uses <Plug> mappings.
            imap <C-k>     <Plug>(neosnippet_expand_or_jump)
            smap <C-k>     <Plug>(neosnippet_expand_or_jump)
            xmap <C-k>     <Plug>(neosnippet_expand_target)

            smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>
        "}}}
        """' Vimwiki '"""{{{
            nnoremap <Leader>wf :VimwikiFollowLink<CR>

            " Split and follow (create target wiki page if needed).
            " nnoremap <Leader>ws <Plug>VimwikiSplitLink<CR>

            " Vertical split and follow (create target wiki page if needed).
            nnoremap <Leader>wv :VimwikiVSplitLink<CR>

            " Follow wiki link (create target wiki page if needed), opening in a new tab.
            " nnoremap <Leader>wt :VimwikiTabnewLink<CR>

            " Go back to previously visited wiki page.
            nnoremap <Leader>wb :VimwikiGoBackLink<CR>

            " Find next link in the current page.
            nnoremap <Leader>wn :VimwikiNextLink<CR>

            " Find previous link in the current page.
            nnoremap <Leader>wp :VimwikiPrevLink<CR>

            " Delete wiki page you are in.
            nnoremap <Leader>wd :VimwikiDeleteLink<CR>

            " Rename wiki page you are in.
            nnoremap <Leader>wr :VimwikiRenameLink<CR>
        "}}}

    "}}}
"}}}

"""' Language specific settings '"""{{{
    ""' Python '""{{{
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

        augroup python_auto
            autocmd! python_auto
            " Toggle breakpoint
            autocmd FileType python nmap <F6> :call <SID>ToggleBreakpoint()<CR>
            " Start debugging - Split window and call ipdb with current file
            autocmd FileType python nmap <F5> <C-w>s :term ipdb3 -c continue % <CR> A
            " Remove all breakppoints when saving
            autocmd QuitPre *.py autocmd BufWritePre * silent g/^\s*import\sipdb\;\?\n*\s*ipdb\.set_trace()/normal dd
        augroup end
    "}}}
"}}}

"""' Theme and Styling '"""{{{
    colorscheme onehalfdark
    set background=dark
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
    highlight NonText guifg=#5c6370

    let g:airline_theme='base16'
"}}}

