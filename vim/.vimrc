" vim dotfile from Pedro Calderon


" Vunddle ---------------------- {{{
" Settings required by vundle
    set nocompatible
    filetype off

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " Pluggins to manage
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/syntastic'
    Plugin 'Townk/vim-autoclose'
    Plugin 'corntrace/bufexplorer'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'kien/ctrlp.vim'
    Plugin 'majutsushi/tagbar'
    "Plugin 'mbbill/undotree'
    "SnipMate + dependencies
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'tomtom/tlib_vim'
        Plugin 'garbas/vim-snipmate'
        Plugin 'honza/vim-snippets'
    Plugin 'vim-scripts/Gundo'
    Plugin 'bling/vim-airline'
        

    " All pluffins must be added before the following line
    call vundle#end()
    filetype plugin indent on
    
" ------------------------------ }}}

" Basic settings --------------- {{{

    "Unactive once it is required by vundle:
    "filetype on
    "filetype plugin on

    syntax enable

    set encoding=utf8 nobomb

    " enavle per-directory .vimrc files
    set exrc
    " disable unsafe commands in local .vimrc files
    set secure

    if (has('win16') || has('win32') || has('win64') || has('win95'))
        cd C:\Users\Pedro
        set runtimepath=$VIMRUNTIME,C:\Users\Pedro\dotfiles\vim\.vim
    elseif has('unix')
        cd ~
    endif
    set autochdir

    set number

    set encoding=utf-8

    " Use the OS clipboard by default
    set clipboard=unnamed

    " Status line format
    " Some status line configuration is under the syntastic plugin config.
    set ruler

    " Window options
    set laststatus=1
    set equalalways

    " Session options
    set sessionoptions=buffers,globals,options,winpos,resize,winsize,slash,unix

    " viminfo options
    set viminfo='1000,f1,:100,/100,h,@1000

    " Start the VIM window maximised if the GUI is running
    if (has("gui_running"))
        if (has('win16') || has('win32') || has('win64') || has('win95'))
            au GUIEnter * simalt ~x
        elseif has('unix')
            set lines=63 columns=235
        endif
    endif

    " Write files when needed
    set autowrite

    " Search options
    set hlsearch
    set incsearch
    " Ignore case, unless there is a uppercase character.
    set ignorecase
    set smartcase
    " uses g option by default
    set gdefault

    " Identation
    set expandtab "spaces substitute tab characters
    set tabstop=4 "width of a tab carachter
    set softtabstop=4 "Fine tune amount of white spaces to be inserted
    set shiftwidth=4 "Definitions for the identetion commands
    set autoindent
    set shiftround 

    " Backspace behavior
    set backspace=indent,eol,start

    " Coments wrap
    set textwidth=80
    set formatoptions=tcqn

    " Definition of the highlight color
    if (has("gui_running"))
        highlight ColorColumn guibg=DarkGray
    else
        highlight ColorColumn ctermbg=8
    endif
    " Highlight the column after the textwidth
    "set colorcolumn=+1

    " Backup
    set backup
    set backupext=.bak
    if (has('win16') || has('win32') || has('win64') || has('win95'))
        set backupdir=C:\Users\Pedro\backup
    elseif has('unix') || has('mac') || has('macunix')
        set backupdir=~/.vimBackup
    endif

    " File completiton wildcards
    set wildignore=*.asv,*.fig,*.mat

    " Highlight groups
    highlight MyGreenGroup ctermbg=green guibg=green

    " Grep program
    set grepprg=grep

    " Optimiza for fast terminal connection
    " timreynolds.org/2013/05/26/configuring-vim-on-mac-os-x/
    set ttyfast

    " Always show status line
    "set laststatus=2

    " No error bells
    set noerrorbells

    " Show pressed keys in the status bar
    set showcmd

    " Allow Vim to create hidden buffers without the !
    set hidden

    " mouse config
    set mouse=a

    " diff options
    set diffopt=iwhite " ignore differences in whitespaces

    " term color
    set t_Co=256

" }}}

" Autocomands ---------------------- {{{
if has("autocmd")

    " The autocmd! erases the previosly loaded augroup
    " Commands run at initialization of vim
    augroup initializations
        autocmd!
        " todo: ver pq nerdtree perde a cor ao se recarregar o vimrc
        " Re-load the .vimrc file after all startup stuff.
        "autocmd VimEnter,GUIEnter * :source $MYVIMRC
        " Create file as soon as it's eddited
        "/*autocmd BufNewFile * :write*/
        " Automatically change to normal
        " todo: fazer sair do modo insert
        autocmd FocusLost,CursorHoldI * :echom "Perda de foco"
    augroup END

    " C/C++ arduino file settings ---------------------- {{{
    augroup filetype_c
        autocmd!
        autocmd FileType setlocal c,cpp :set  cindent
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
   
    " Latex file settings  ---------------------- {{{
    augroup filetype_latex
        autocmd!
        autocmd FileType latex setlocal grepprg=grep\ -nH\ $*
        autocmd FileType tex setlocal foldmethod=marker
    augroup END
    " }}}

    " Better commits
    augroup better_commits
        autocmd!
        autocmd FileType gitcommit  setlocal spell spelllang=en  "git
        autocmd FileType svn        setlocal spell spelllang=en  "subversion
        autocmd FileType asciidoc   setlocal spell spelllang=en  "mercurial
    augroup END

    augroup reload_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END

endif
" }}}

" Plugins ---------------------- {{{

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " nerdtree
    noremap <leader>n :NERDTreeToggle<CR>

    if has("autocmd")
        augroup nerdtree_group
            "autocmd!
            " Nerd tree config
            " Open NERDTree whe vim starts up if no files were specified
            autocmd vimenter * if !argc() | NERDTree | endif
            " Close vim if the only window left is NERDTree
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
            let NERDTreeQuitOnOpen=1
        augroup END
    endif
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    nnoremap s <Plug>(easymotion-s)

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Syntastic configs

    " jump to the first error
    let g:syntastic_auto_jump=2
    " populate vim errors list with the compilation errors. Use :lne[xt]
    " :lp[revious] to navigate the errors.
    let g:syntastic_always_populate_loc_list=1
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " easymotion 
    
    " Bi-directional find motion
    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{label}`
    nmap s <Plug>(easymotion-s)
    " or
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap <leader><leader>s <Plug>(easymotion-s2)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Tagbar
    nnoremap <silent> <F9> :TagbarToggle<CR>
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

    " insert single character with space
    nnoremap <space> i_<esc>r

    " K is the oposite o J, break te line
    nnoremap K i<cr><esc>$

    " Insert lines without entering insert mode
    nnoremap <Enter> o<esc>

    " very-magic search
    nnoremap // /\v

    " Esier vimrc editing
    " todo: fazer com que o vimrc use vsplit se em tela cheia, usar split
    " simples em caso contrario
    " Fazer funcao para realizar o toggle de editar vim. \ev abre a janela, \ev
    " fecha a janela e deleta o buffer do vimrc.
    if (has('win16') || has('win32') || has('win64') || has('win95'))
        nnoremap <leader>ev :vsplit C:\Users\Pedro\dotfiles\vim\.vimrc<cr>
    elseif has('unix')
        nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    endif

    " Follow links with <leader>o insted of ctrl-]
    nnoremap <buffer> <leader>o <C-]>

    " Spell checks
    nnoremap <leader>sce :setlocal spell! spelllang=en<cr>
    nnoremap <leader>scp :setlocal spell! spelllang=pt<cr>
    nnoremap <leader>scf :setlocal spell! spelllang=fr<cr>
    nnoremap <leader>c 1z=

    " Substitutions
    "noremap ;; :%s:::g<Left><Left><Left>
    "noremap ;' :%s:::cg<Left><Left><Left><Left>

    " Highlights trailing spaces
    " The group highlight group Error can be used.
    nnoremap <leader>w :match MyGreenGroup /\v +$/<cr>
    nnoremap <leader>W :match<cr>

    " Jump 80 characters
    nnoremap LL 080l

    " Insert current file name 
    inoremap \fn <C-R>=expand("%:t:r")<CR>
    inoremap \file <C-R>=expand("%:t")<CR>
    inoremap \fdir <C-R>=expand("%:p:h")<CR>
    inoremap \rdir <C-R>=expand("%:h")<CR>

    " Tabs
    " Remapas from: http://vim.wikia.com/wiki/Using_tab_pages
    " move between tabs with ctrl + arrow keys
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>
    " displace tabs with alt + arrow keys
    nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
    " <F8> toggles between showing all buffers in tabs or not.
    let notabs = 0
    nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

    " Copy to clip board on Mac
    nmap <F2> :.w !pbcopy<CR><CR>
    vmap <F2> :w !pbcopy<CR><CR>
    nmap <F3> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
    imap <F3> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>


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

    " todo: fazer <l mapear o literal <leader>
    " iabbrev <l <leader> 

    " Typos correction
    iabbrev Caldeorn Calderon

" }}}

" Custom functions ---------------------- {{{

    " Grep funcionality ---------------------- {{{
    " Creates an operator that greps the mouvement or text object in the
    " directory of the current file.
    " By default the grep operator is set to <leader>g
    "
    " This exemple was made in by Steve Losh in 'Learn Vimscript the Hard Way'
    nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
    vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

    function! s:GrepOperator(type)
        let saved_unamed_register = @@ 

        if a:type ==# 'v'
            execute "normal! `<v`>y"
        elseif a:type ==# 'char'
            execute "normal! `[v`]y"
        else
            return
        endif

        silent execute "grep! -nHr " . shellescape(@@) . " ."
        copen

        let @@ = saved_unamed_register
    endfunction
    " }}}

    " Toggling foldcolumn ---------------------- {{{
    nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>

    function! s:FoldColumnToggle()
        if &foldcolumn
            setlocal foldcolumn=0
        else
            setlocal foldcolumn=4
        endif
    endfunction
    " }}}

    " Toggling quickfix window ---------------------- {{{
    nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

    let g:quickfix_is_open = 0

    function! s:QuickfixToggle()
        if g:quickfix_is_open
            cclose
            let g:quickfix_is_open = 0
            execute g:quickfix_return_to_window . "wincmd w"
        else
            let g:quickfix_return_to_window = winnr()
            copen
            let g:quickfix_is_open = 1
        endif
    endfunction
    " }}}
    
    " Search for selected text. ---------------------- {{{
    " http://vim.wikia.com/wiki/VimTip171
    let s:save_cpo = &cpo | set cpo&vim
    if !exists('g:VeryLiteral')
    let g:VeryLiteral = 0
    endif
    function! s:VSetSearch(cmd)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal! gvy
    if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
        let @/ = @@
    else
        let pat = escape(@@, a:cmd.'\')
        if g:VeryLiteral
        let pat = substitute(pat, '\n', '\\n', 'g')
        else
        let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
        let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
        let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
        endif
        let @/ = '\V'.pat
    endif
    normal! gV
    call setreg('"', old_reg, old_regtype)
    endfunction
    vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>
    vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>
    vmap <kMultiply> *
    nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
    \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
    if !hasmapto("<Plug>VLToggle")
    nmap <unique> <Leader>vl <Plug>VLToggle
    endif
    let &cpo = s:save_cpo | unlet s:save_cpo
    " }}}

" }}}


" Commands
"command Bv -nargs=+ :vertical sb "<args>"
