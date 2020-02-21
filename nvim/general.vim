" Disallow detection of filetypes
filetype off

filetype plugin indent on "required

syntax enable

" disable unsafe commands in local .vimrc files
set secure

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

set noautochdir

" mouse config
set mouse=a

" Smaller updatetime for CursorHold & CursorHoldI
"set updatetime=300

" Allow Vim to create hidden buffers without the !
set hidden

" disable swaps and backups
set nobackup
set nowritebackup
set noswapfile

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Identation
set expandtab "spaces substitute tab characters
set tabstop=2 "width of a tab carachter
set softtabstop=2 "Fine tune amount of white spaces to be inserted
set shiftwidth=2 "Definitions for the identetion commands
set autoindent
set shiftround

" always show signcolumns
set signcolumn=yes

" Line number config
set number
set relativenumber

" #TEMPLATES {{{
" Prefill new files created by vim with contents from the following templates
augroup templates
  autocmd BufNewFile *.html 0r ~/.config/nvim/templates/skeleton.html
  autocmd BufNewFile *.css 0r ~/.config/nvim/templates/skeleton.scss
  autocmd BufNewFile .gitignore 0r ~/.config/nvim/templates/skeleton.gitignore
  autocmd BufNewFile .stylelintrc.json 0r ~/.config/nvim/templates/skeleton.stylelintrc
augroup END
"}}}

" Enable JSX syntax highlighting in .js files
let g:jsx_ext_required = 0

" Stop concealing quotes in JSON
let g:vim_json_syntax_conceal = 0

" More natural split opening.
set splitbelow
set splitright

" Show leader key
set showcmd

set textwidth=80
set formatoptions+=t
set colorcolumn=+1
set showmatch
set lazyredraw

" Search all subfolders
set path+=**

" Display matching files on tab complete
set wildmenu

" Ignore node_modules and images from search results
set wildignore+=**/node_modules/**,**/dist/**,**_site/**,*.swp,*.png,*.jpg,*.gif,*.webp,*.jpeg,*.map,tags.temp

" Use the system register for all cut yank and paste operations
set clipboard=unnamed

" Show Invisibles
set list
set listchars=tab:→→,eol:¬,space:.

" Automatically hide buffer with unsaved changes without showing warning
set hidden

" Treat all numbers as decimal regardless of whether they are padded with zeros
set nrformats=

" Highlight matches when using :substitute
set hlsearch

" Predicts case sensitivity intentions
set smartcase

hi NonText guifg=#4a4a59
hi SpecialKey guifg=white guibg=#cc0000

" Strip trailing whitespace from all files
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\s\+$//e

" Automatically remove the preview window after autocompletion
autocmd CompleteDone * pclose

au BufRead,BufNewFile,BufReadPost *.json set syntax=json

" Wipe netrw buffers
autocmd FileType netrw setl bufhidden=wipe

" very-magic search
nnoremap // /\v
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
