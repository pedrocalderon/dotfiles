" vim dotfile from Pedro Calderon

cd C:\Users\Pedro

call pathogen#infect()

set number
syntax on

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
set backupdir=C:\Users\Pedro\backup


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd tree config
" Open NERDTree whe vim starts up if no files were specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" TODO: make that "o" opens archive and quit NERDTree,
" and that "O" opens archive without closing NERDTree.
let NERDTreeQuitOnOpen=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps

" Map some key to <nop> make it does sothing

" Leader definition
let mapleader="\\"
let maplocalleader="|"

" Quick esc in insert mode
inoremap jk <esc>

" NERDTree map
noremap <C-n> :NERDTreeToggle<CR>

" insert single character with space
nnoremap <space> i_<esc>r

" K is the oposite o J, break te line
nnoremap K i<cr><esc>k$

" Insert lines eithout entering insert mode
nnoremap <Enter> o<esc>k
nnoremap <S-Enter> O<esc>j

" Toggles number/relativenumber
nnoremap <leader>n :call NumberToggle()<cr>

" Use nohlsearch
nnoremap <leader>h :nohls<cr>

" Esier vimrc editing
nnoremap <leader>ev :vsplit C:\Users\Pedro\dotfiles\vim\.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Follow links with enter insted of ctrl-]
" the second option doesn't work on windows.
nnoremap <buffer> <C-o> <C-]>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
iabbrev fun function
iabbrev pc Pedro Calderon
iabbrev @@ pedrolcalderon@gmail.com

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
