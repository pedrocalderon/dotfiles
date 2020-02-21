" Ale config {{{
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['scss'] = ['stylelint']
let g:ale_fixers['css'] = ['stylelint', 'prettier']
let g:ale_fix_on_save = 1 " Fix files automatically on save
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

nmap <F6> <Plug>(ale_fix)
" }}}

" Fzf config {{{
let g:fzf_command_prefix = 'Fzf'
nnoremap <C-p> :FzfFiles<CR>
nnoremap <Leader>b :FzfBuffers<CR>
nnoremap <Leader>t :FzfBTags<CR>
nnoremap <Leader>T :FzfTags<CR>
" Have FZF list all tracked files plus untracked files minus your ignored files
nnoremap <Leader>p :FzfGitFiles --exclude-standard --others --cached<CR>
nnoremap <Leader>gt :FzfRg<CR>
" }}}

" #GUTENTAGS {{{
let g:gutentags_file_list_command = "rg --files --follow --ignore-file '/home/ayo/.vimignore'"
" }}}

" Coc {{{
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> <Leader>K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" }}}

" bbye {{{
nnoremap <leader>q :Bwipeout<CR>
" }}}

" vim-maximizer {{{
nnoremap <leader>m :MaximizerToggle<CR>
nnoremap <silent><F3> :MaximizerToggle<CR>
vnoremap <silent><F3> :MaximizerToggle<CR>gv
inoremap <silent><F3> <C-o>:MaximizerToggle<CR>
" {{{

" #SIGNIFY {{{
" Check for only Git
let g:signify_vcs_list = [ 'git' ]
let g:signify_realtime = 1

" Jump to next and previous hunks
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" Hunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
" }}}

" #FUGITIVE {{{
nmap <leader>gw :Gwrite<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gs :Gstatus<CR>
" }}}

" #RIPGREP {{{
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" #NETRW {{{
" Set preferred view
let g:netrw_liststyle = 3
" Remove banner
let g:netrw_banner = 0
" }}}

" Rainbow.vim {{{
 let g:rainbow_active = 1
" {{{

" #ULTILSNIPS {{{
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetsDir="~/.config/nvim/snips"
let g:UltiSnipsSnippetDirectories=["UtilSnips", "snips"]
nnoremap <leader>es :UltiSnipsEdit<CR>
"}}}

" Disable elm-vim keybidings
let g:elm_setup_keybindings = 0

" #SUPERTAB {{{
" Make supertab completition follow the more intuitive order
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" }}}

" #NerdTree {{{
nnoremap <leader>n :NERDTreeToggle<CR>
" }}}

" git-messenger {{{
let g:git_messenger_no_default_mappings = v:true
let g:git_messenger_always_into_popup = v:true
nmap gm <Plug>(git-messenger)<CR>
" }}}
