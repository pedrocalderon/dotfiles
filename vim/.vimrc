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

    Plugin 'airblade/vim-rooter'
    "Plugin 'godlygeek/tabular'
    "Plugin 'corntrace/bufexplorer'
    "Plugin 'Lokaltog/vim-easymotion'

    " Pluggins to manage
    Plugin 'mileszs/ack.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-repeat'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'vim-scripts/Gundo'
    Plugin 'bling/vim-airline'
    Plugin 'SirVer/ultisnips'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'pangloss/vim-javascript'
    Plugin 'w0rp/ale'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'airblade/vim-gitgutter'

    "Need outside instalation
    "ELM
    Plugin 'ElmCast/elm-vim'
    " Elixir
    Plugin 'elixir-lang/vim-elixir'

    " All pluffins must be added before the following line
    call vundle#end()

    " Included packages
    packadd! matchit

" ------------------------------ }}}

" Basic settings --------------- {{{

    filetype plugin indent on

    syntax enable

    " enavle per-directory .vimrc files
    set exrc
    " disable unsafe commands in local .vimrc files
    set secure

    set updatetime=100

    if (has('win16') || has('win32') || has('win64') || has('win95'))
        cd C:\Users\Pedro
        set runtimepath=$VIMRUNTIME,C:\Users\Pedro\dotfiles\vim\.vim
    elseif has('unix')
        cd ~
    endif
    set noautochdir

    set number
    set relativenumber

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

    " Identation
    set expandtab "spaces substitute tab characters
    set tabstop=2 "width of a tab carachter
    set softtabstop=2 "Fine tune amount of white spaces to be inserted
    set shiftwidth=2 "Definitions for the identetion commands
    set autoindent
    set shiftround

    " Backspace behavior
    set backspace=indent,eol,start

    " wrap
    set textwidth=80
    " add t flag when using text: .txt, .tex, .md, etc...
    set formatoptions=cqn
    set linebreak

    " Definition of the highlight color
    if (has("gui_running"))
        highlight ColorColumn guibg=DarkGray
    else
        highlight ColorColumn ctermbg=8
    endif

    " File completiton wildcards
    set wildignore=*/tmp/*,*.so,*.swp
    set wildignore=*.zip,*.tar.gz,*.tar.xz

    " Grep program
    set grepprg=grep

    " Optimiza for fast terminal connection
    " timreynolds.org/2013/05/26/configuring-vim-on-mac-os-x/
    set ttyfast

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

    " disable swaps and backups
    set nobackup
    set noswapfile
" }}}

" Autocomands ---------------------- {{{
if has("autocmd")

    " Elm file settings ---------------------- {{{
    augroup filetype_elm
        autocmd!
        autocmd FileType elm set tabstop=4
        autocmd FileType elm set softtabstop=4
        autocmd FileType elm set shiftwidth=4
    augroup END
    " }}}

    " Vimscript file settings ---------------------- {{{
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END
    " }}}

    " Better commits       ---------------------- {{{
    augroup better_commits
        autocmd!
        autocmd FileType gitcommit  setlocal spell spelllang=en  "git
        autocmd FileType svn        setlocal spell spelllang=en  "subversion
        autocmd FileType asciidoc   setlocal spell spelllang=en  "mercurial
    augroup END
    " }}}

    " Source .vimrc on write it ---------------- {{{
    augroup reload_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END
    " }}}

    " Source less filetype ---------------- {{{
    augroup less_ft
        autocmd!
        autocmd BufRead,BufNewFile *.less set filetype=css
    augroup END
    " }}}

endif
" }}}

" Plugins Configuration ---------------------- {{{

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "GITGUTTER
    nmap <Leader>ha <Plug>GitGutterStageHunk
    nmap <Leader>hr <Plug>GitGutterUndoHunk
    nmap <Leader>hv <Plug>GitGutterPreviewHunk
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "ALE
    let g:ale_completion_enable = 1
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
    " Tagbar
    nnoremap <silent> <F9> :TagbarToggle<CR>
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "gundo
    nnoremap <F5> :GundoToggle<CR>
    let g:gundo_preview_bottom = 1
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "ctrlP
    set wildignore+=*/.git/*,*/node_modules/*,*/.idea/*,*/build/*
    if exists(":CtrlP")
      let g:ctrlp_map = '<c-p>'
      let g:ctrlp_cmd = 'CtrlP'

      let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

      if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
      endif
    endif
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Fugitive
    noremap gs :Gstatus<CR>
    noremap gu :call PullFromCurrentBranch()<CR>
    noremap gp :call PushToCurrentBranch()<CR>
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Rooter
    let g:rooter_silent_chdir=1
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "YouCompleteMe
    let g:ycm_semantic_triggers = { 'elm' : ['.'] }
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "UltiSnips
    "Do not use tab if youcompleteme is installed
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsSnippetsDir="/Users/pedro/.vim/UltiSnips"
    nnoremap <leader>es :UltiSnipsEdit<CR>
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "elm-vim
    let g:elm_format_autosave = 1
    let g:elm_syntastic_show_warnings = 1
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

    " Navigate between windows
    noremap <leader>h <C-w>h
    noremap <leader>l <C-w>l
    noremap <leader>j <C-w>j
    noremap <leader>k <C-w>k

    " Alternate window position
    noremap <leader>H <C-w>H
    noremap <leader>L <C-w>L
    noremap <leader>J <C-w>J
    noremap <leader>K <C-w>K

    " insert single character with space
    nnoremap <space> i_<esc>r

    " K is the oposite o J, break te line
    nnoremap K i<cr><esc>$

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

    " Spell checks
    nnoremap <leader>sce :setlocal spell! spelllang=en<cr>
    nnoremap <leader>scp :setlocal spell! spelllang=pt<cr>
    nnoremap <leader>c 1z=

    " Insert current file name
    "inoremap \fn <C-R>=expand("%:t:r")<CR>
    "inoremap \file <C-R>=expand("%:t")<CR>
    "inoremap \fdir <C-R>=expand("%:p:h")<CR>
    "inoremap \rdir <C-R>=expand("%:h")<CR>

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

    " Format json
    " Make this a function executable through a ex command
    nnoremap <F12> :%!python -m json.tool<CR>
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

    " Fugitive auxiliary functions ---------------------- {{{
    function! PushToCurrentBranch()
      let branch = fugitive#statusline()
      let branch = substitute(branch, '\c\v\[?GIT\(([a-z0-9\-_\./:]+)\)\]?', $BRANCH.' \1', 'g')
      exe ":silent Git submodule foreach git push origin master"
      exe ":Git push origin" . branch
    endfunction

    function! PullFromCurrentBranch()
      let branch = fugitive#statusline()
      let branch = substitute(branch, '\c\v\[?GIT\(([a-z0-9\-_\./:]+)\)\]?', $BRANCH.' \1', 'g')
      exe ":silent Git submodule foreach git pull --no-edit origin master"
      exe ":Git pull --no-edit origin" . branch
    endfunction
    " }}}

" }}}

" Macros ---------------------- {{{
let @z = '0wcwconstjkea =�kb �kb= jkl%a => jkd$J$%dd<i{'
" }}}

"command Bv -nargs=+ :vertical sb "<args>"
