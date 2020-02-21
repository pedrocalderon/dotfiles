" Quick esc in insert mode
inoremap jk <esc>

" K is the oposite o J, break te line
nnoremap K i<cr><esc>$

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

" MOVING LINES
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Shortcut to open init.vim
nnoremap <leader>ev :vsp $MYVIMRC<CR>
" Reload Vim config
nnoremap <Leader>r :so ~/.config/nvim/init.vim<CR>

" QuickFix List
nnoremap <leader>co :cw<CR>
nnoremap <leader>cc :ccl<CR>
nnoremap <UP> :cope<CR>
nnoremap <DOWN> :cclose<CR>
nnoremap <LEFT> :cprev<CR>
nnoremap <RIGHT> :cnext<CR>
nnoremap <silent> <leader>cn :cnext<CR>
nnoremap <silent> <leader>cp :cprev<CR>

