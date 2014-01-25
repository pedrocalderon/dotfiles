" vim dotfile from Pedro Calderon
"

if (has('win16') || has('win32') || has('win64') || has('win95'))
    cd C:\Users\Pedro
    set runtimepath=$VIMRUNTIME,C:\Users\Pedro\dotfiles\vim\.vim
elseif has('unix')
    cd ~
endif
set autochdir

call pathogen#infect()

set number
syntax on

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

filetype on
filetype plugin on
autocmd FileType c,cpp :set  cindent

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

" Create file as soon as it's eddited
:autocmd BufNewFile * :write

" Special highlights configurations
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd tree config
" Open NERDTree whe vim starts up if no files were specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeQuitOnOpen=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps

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

" NERDTree map
noremap <leader>n :NERDTreeToggle<CR>

" insert single character with space
nnoremap <space> i_<esc>r

" Alternate buffer
noremap <C-e> :b#<CR>
" :Add a :bnext and :bprevious map"

" Navigate between buffers
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l

" Alternate buffers position
noremap <leader>H <C-w>H
noremap <leader>L <C-w>L

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




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
iabbrev fun function

iabbrev pc Pedro Calderon
iabbrev @@ pedrolcalderon@gmail.com

iabbrev /** /********************************************************************************
iabbrev **/ ********************************************************************************/

" Typos correction
iabbrev Caldeorn Calderon



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands
"command Bv -nargs=+ :vertical sb "<args>"