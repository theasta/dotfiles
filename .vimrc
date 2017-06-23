" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is the personal .vimrc file of Alexandrine Boissière.
"
" }

" Environment {

    " Basics {
        set nocompatible        " Must be first line
    " }

    " Setup Bundle Support {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype on
        filetype off
        filetype plugin indent on     " Required!

        if has('vim_starting')
            set runtimepath+=~/.vim/bundle/neobundle.vim/
        endif
        call neobundle#begin(expand('~/.vim/bundle/'))
        
        if filereadable(expand("~/.vimrc.bundles"))
            source ~/.vimrc.bundles
        endif
        
        call neobundle#end()

        " Brief help
        " :NeoBundleList          - list configured bundles
        " :NeoBundleInstall(!)    - install(update) bundles
        " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

        " Installation check.
        NeoBundleCheck
    " }

" }

" General {

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8        " Character encoding used in this file

    set encoding=utf8           " character encoding used inside Vim
    try
        lang en_US
    catch
    endtry

    set ffs=unix,dos,mac        "Default fileformats : set EOL

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    set autoread                        " Set to auto read when a file is changed from the outside
    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=700                    " Store a ton of history (default is 20)
    set nospell                         " Spell checking off
    set hidden                          " Allow buffer switching without saving

    set nobackup                      " Don't make a backup before overwriting a file.
    set nowritebackup                 " And again.
    set noswapfile                    " Use an SCM instead of swap files

" }


" Vim UI {

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    highlight clear SignColumn      " SignColumn should match background for
                                    " things like vim-gitgutter

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if exists('*fugitive#statusline')
            set statusline+={fugitive#statusline()}  " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=1                 " No extra spaces between rows
    set nonumber                    " Line numbers off
    set showmatch                   " Show matching brackets/parenthesis
    set mat=2                       "How many tenths of a second to blink
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    "set magic                       "Set magic on, for regular expressions
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignore+=*.o,*.obj,*/.git/*,*/.hg/*,*/.svn/*,*.pyc,*/node_modules/*,*/tmp/*
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set nofoldenable                " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    "set listchars=tab:›\ ,trail:•,extends:#,nbsp:.,eol:¬ " Highlight problematic whitespace

    set visualbell
    set title
    set splitbelow

" }

" Formatting {

    set wrap                        " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set smartindent
    set tabstop=4                   " An indentation every four columns
    set shiftwidth=4                " Use indents of 4 spaces
    set softtabstop=4               " Let backspace delete indent
    set expandtab                   " Use spaces instead of tabs
    set shiftround                  " Round indent to multiple of shiftwidth
    "set smarttab                     "Uses shiftwidth instead of tabstop at the start of lines
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    " Remove trailing whitespaces and ^M chars
    "autocmd FileType php,javascript,python,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    "autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig

" }

" Key (re)Mappings {
    "<M-j> = ALT + j
    "<C-j> = CTRL + j
    "<D-j> = CMD + j

    let mapleader = ","
    let g:mapleader = ","

    " Use the arrows to something useful
    map <right> :bn<cr>
    map <left> :bp<cr>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Reset search highlighting
    map <silent> <leader><cr> :noh<cr>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
    map <leader>cd :cd %:p:h<cr>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Bubble single lines
    nmap <C-S-Up> <Plug>unimpairedMoveUp
    nmap <C-S-Down> <Plug>unimpairedMoveDown
    " Bubble multiple lines
    vmap <C-S-Up> [egv
    vmap <C-S-Down> ]egv

    " Use perl regex style
    " nnoremap / /\v
    " vnoremap / /\v

    nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>:set softtabstop=2<cr>
    nmap <leader>3 :set tabstop=3<cr>:set shiftwidth=3<cr>:set softtabstop=3<cr>
    nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>:set softtabstop=4<cr>

    nmap <leader>l :set list!<CR>

    " ,; appends semicolon to current line
    nnoremap <leader>; <esc>A;<esc>

    " Substitute all occurrences of the word under the cursor
    nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

    nnoremap <leader>bd :Kwbd<cr>
" }

" Plugins {

    " PIV {
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }

    " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags
    " }

    " SnipMate {
        let g:snips_author = 'Alexandrine Boissiere'
    " }

    " Tabularize {
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    " }

    " ctrlp {
        noremap <leader>m :CtrlP<cr>
        noremap <leader>mm :CtrlPBuffer<cr>
        noremap <leader>mmm :CtrlPMRU<cr>
        nmap <leader>gf :CtrlP<CR><C-\>w
        let g:ctrlp_working_path_mode = ''
    "}

    " TagBar {
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
    "}

    " PyMode {
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
    " }

    " PythonMode {
    " Disable if python support not present
        if !has('python')
            let g:pymode = 1
        endif
    " }

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
    "}

    " superTab {
        let g:SuperTabMappingForward = '<c-space>'
        let g:SuperTabMappingBackward = '<s-c-space>'
        let g:SuperTabMappingTabLiteral = '<tab>'
    "}

" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set antialias                     " MacVim: smooth fonts.
        set guioptions-=T                 " Hide toolbar.
        set guioptions-=r                 " Don't show right scrollbar
        set background=dark              " Background.
        set lines=90 columns=140          " Window dimensions.
        set cursorline                    " Highlight current line
        set number                        " Show line numbers.

        set guifont=Inconsolata:h14,Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18

        if has('gui_macvim')
            "macmenu &File.New\ Tab key=<nop>
        endif

    else
        if &term == 'xterm' || &term == 'screen' || &term == 'xterm-color'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
    endif

    """"""""""""""""""""""""""""""
    " => Colorscheme
    """"""""""""""""""""""""""""""
    colorscheme molokai
    colors molokai

" }

" Functions {

    function! <SID>StripTrailingWhitespaces()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        %s/\s\+$//e
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
