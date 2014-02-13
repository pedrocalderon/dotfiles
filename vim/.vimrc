" vim dotfile from Pedro Calderon


" Basic settings --------------- {{{

    filetype on
    filetype plugin on

    syntax on

    if (has('win16') || has('win32') || has('win64') || has('win95'))
        cd C:\Users\Pedro
        set runtimepath=$VIMRUNTIME,C:\Users\Pedro\dotfiles\vim\.vim
    elseif has('unix')
        cd ~
    endif
    set autochdir

    set number

    set encoding=utf-8

    if (has('win16') || has('win32') || has('win64') || has('win95'))
        set grepprg=C:/Program\ Files\ (x86)/GnuWin32/bin/grep\ -nH\ $*
    endif

    " Status line format
    set ruler

    " Window options
    set laststatus=1
    set equalalways

    " Session options
    set sessionoptions=buffers,globals,options,winpos,resize,winsize,slash,unix

    " viminfo options
    set viminfo='1000,f1,:100,/100,h,@1000

    " Start the VIM window maximised
    au GUIEnter * simalt ~x

    " Write files when needed
    set autowrite

    " Search options
    set hlsearch
    set incsearch
    " Ignore case, unless there is a uppercase character.
    set ignorecase
    set smartcase

    " Identation
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent
    set shiftround 

    " Backspace behavior
    set backspace=indent,eol,start

    " Coments wrap
    set textwidth=80
    set formatoptions=cq

    " Backup
    set backup
    set backupext=.bak
    if (has('win16') || has('win32') || has('win64') || has('win95'))
        set backupdir=C:\Users\Pedro\backup
    elseif has('unix')
        set backupdir=~/backup
    endif

    " File completiton wildcards
    set wildignore=*.asv,*.fig,*.mat

" }}}

" Autocomands ---------------------- {{{

    " The autocmd! erases the previosly loaded augroup
    " Commands run at initialization of vim
    augroup initializations
        autocmd!
        " todo: ver pq nerdtree perde a cor ao se recarregar o vimrc
        " Re-load the .vimrc file after all startup stuff.
        autocmd VimEnter,GUIEnter * :source $MYVIMRC
        " Create file as soon as it's eddited
        autocmd BufNewFile * :write
        " Automatically change to normal
        " todo: fazer sair do modo insert
        autocmd FocusLost,CursorHoldI * :echom "Perda de foco"
    augroup END

    " C/C++ arduino file settings ---------------------- {{{
    augroup filetype_c
        autocmd!
        autocmd FileType c,cpp :set  cindent
        " Special highlights configurations
        autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp
    augroup END
    " }}}

    " Vimscript file settings ---------------------- {{{
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END
    " }}}

" }}}

" Plugins ---------------------- {{{

    call pathogen#infect()

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    augroup nerdtree_group
        "autocmd!
        " Nerd tree config
        " Open NERDTree whe vim starts up if no files were specified
        autocmd vimenter * if !argc() | NERDTree | endif
        " Close vim if the only window left is NERDTree
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
        let NERDTreeQuitOnOpen=1
    augroup END
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "VIM-LATEX plug-in configuration
    " The following additions were copied from the vim-latex website
    "
    "IMPORTANT: win32 users will need to have 'shellslash' set so that latex can be
    "called correctly
    set shellslash

    "
    "IMPORTANT: grep will sometimes skip desplaying the file name if you search in a
    "single file. This will confuse Latex-suite. Set your grep program to always
    "generate a file-name.
    set grepprg=grep\ -nH\ $*

    "OPTIONAL: Starting with vim 7, the filetype of empty .tex files defaults to
    "'plaintex' insted of 'tex', wich results in vim-latex not being loaded. The
    "following changes the default filetype back to 'tex'
    let g:tex_flavor='latex'
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" }}}

" Remaps ---------------------- {{{

    " Map some key to <nop> make it does sothing

    " Leader definition
    let mapleader="\\"
    let maplocalleader="|"

    " Intuitive moving
    nnoremap j gj
    nnoremap k gk

    " Scroll the screen without moving the cursor
    nnoremap <C-j> jzz
    nnoremap <C-k> kzz

    " Quick esc in insert mode
    inoremap jk <esc>
    inoremap <esc> <nop>

    " Alternate buffer
    noremap <C-e> :b#<CR>
    " :Add a :bnext and :bprevious map"

    " Navigate between buffers
    noremap <leader>h <C-w>h
    noremap <leader>l <C-w>l
    noremap <leader>j <C-w>j
    noremap <leader>k <C-w>k

    " Alternate buffers position
    noremap <leader>H <C-w>H
    noremap <leader>L <C-w>L
    noremap <leader>J <C-w>J
    noremap <leader>K <C-w>K

    " NERDTree map
    noremap <leader>n :NERDTreeToggle<CR>

    " insert single character with space
    nnoremap <space> i_<esc>r

    " K is the oposite o J, break te line
    nnoremap K i<cr><esc>$

    " Insert lines without entering insert mode
    nnoremap <Enter> o<esc>
    nnoremap <S-Enter> O<esc>j

    " Toggles number/relativenumber
    nnoremap <leader>r :call NumberToggle()<cr>

    " Use nohlsearch
    nnoremap <leader>s :nohlsearch<cr>

    " Esier vimrc editing
    if (has('win16') || has('win32') || has('win64') || has('win95'))
        nnoremap <leader>ev :vsplit C:\Users\Pedro\dotfiles\vim\.vimrc<cr>
    elseif has('unix')
        nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    endif
    nnoremap <leader>sv :source $MYVIMRC<cr>

    " Follow links with <leader>o insted of ctrl-]
    nnoremap <buffer> <leader>o <C-]>

    " Spell checks
    nnoremap <leader>sce :setlocal spell! spelllang=en<cr>
    nnoremap <leader>scp :setlocal spell! spelllang=pt<cr>
    nnoremap <leader>scf :setlocal spell! spelllang=fr<cr>
    nnoremap <leader>f 1z=

    " Substitutions
    noremap ;; :%s:::g<Left><Left><Left>
    noremap ;' :%s:::cg<Left><Left><Left><Left>

" }}}

" operator-pending mappings ---------------------- {{{ 

    "in next something
    "in last something
    onoremap in( :<c-u>normal! f(vi(<cr>
    onoremap il( :<c-u>normal! F)vi(<cr>
    onoremap in{ :<c-u>normal! f{vi{<cr>
    onoremap il{ :<c-u>normal! F}vi{<cr>
    onoremap in[ :<c-u>normal! f[vi[<cr>
    onoremap il[ :<c-u>normal! F]vi[<cr>
    onoremap in" :<c-u>normal! f"vi"<cr>
    onoremap il" :<c-u>normal! F"vi"<cr>
    onoremap in' :<c-u>normal! f'vi'<cr>
    onoremap il' :<c-u>normal! F'vi'<cr>
    "Accept makes either opening or closing element valid 
    onoremap in) :<c-u>normal! f(vi(<cr>
    onoremap il) :<c-u>normal! F)vi(<cr>
    onoremap in} :<c-u>normal! f{vi{<cr>
    onoremap il} :<c-u>normal! F}vi{<cr>
    onoremap in] :<c-u>normal! f[vi[<cr>
    onoremap il] :<c-u>normal! F]vi[<cr>

    "arround next something
    "arround last something
    onoremap an( :<c-u>normal! f(va(<cr>
    onoremap al( :<c-u>normal! F)va(<cr>
    onoremap an{ :<c-u>normal! f{va{<cr>
    onoremap al{ :<c-u>normal! F}va{<cr>
    onoremap an[ :<c-u>normal! f[va[<cr>
    onoremap al[ :<c-u>normal! F]va[<cr>
    onoremap an" :<c-u>normal! f"va"<cr>
    onoremap al" :<c-u>normal! F"va"<cr>
    onoremap an' :<c-u>normal! f'va'<cr>
    onoremap al' :<c-u>normal! F'va'<cr>
    "Accept makes either opening or closing element valid 
    onoremap an) :<c-u>normal! f(va(<cr>
    onoremap al) :<c-u>normal! F)va(<cr>
    onoremap an} :<c-u>normal! f{va{<cr>
    onoremap al} :<c-u>normal! F}va{<cr>
    onoremap an] :<c-u>normal! f[va[<cr>
    onoremap al] :<c-u>normal! F]va[<cr>

" }}}

" Abbreviations ---------------------- {{{

    iabbrev fun function

    iabbrev pc Pedro Calderon
    iabbrev @@ pedrolcalderon@gmail.com

    " Typos correction
    iabbrev Caldeorn Calderon

    augroup filetypes_abbreviations
        autocmd!
        autocmd FileType c,h,cpp,hpp :iabbrev <buffer> /** /********************************************************************************
        autocmd FileType c,h,cpp,hpp :iabbrev <buffer> **/ ********************************************************************************/

        autocmd FileType python :iabbrev def def :<left>
        autocmd FileType python :iabbrev class class :<left>
        autocmd FileType python :iabbrev if if :<left>
        autocmd FileType python :iabbrev for for :<left>
    augroup END

" }}}

" Functions ---------------------- {{{

    function! NumberToggle()
        if(&relativenumber == 1)
            set norelativenumber
        else
            set relativenumber
        endif
    endfunction

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands
"command Bv -nargs=+ :vertical sb "<args>"
