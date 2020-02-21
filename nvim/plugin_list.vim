if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"We will install ripgrep in a Mac if it is not installed
"If we are not in a Mac we will let the user know that
"ripgrep should be installed.
if !executable('rg')
  if executable('brew')
    !brew install ripgrep
  else
    echo 'Install rigprep for better performance: https://github.com/BurntSushi/ripgrep'
  endif
endif

"After installing ripgrep we will make sure that
"we have it configure correctly in our shell config
if empty($FZF_DEFAULT_COMMAND)
  "Handle zsh config
  if !empty(glob('~/.zshrc'))
    silent !echo "export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'" >> ~/.zshrc
    silent !source ~/.zshrc
  endif

  "Handle bash config
  if !empty(glob('~/.bashrc'))
    silent !echo "export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'" >> ~/.bashrc
    silent !source ~/.bashrc
  endif

  "Handle bash_profile
  if !empty(glob('~/.bash_profile'))
    silent !echo "export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'" >> ~/.bash_profile
    silent !source ~/.bash_profile
  endif
endif

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

"Syntax Highlight and identation
Plug 'sheerun/vim-polyglot'
Plug 'Quramy/vim-js-pretty-template'

" Linting and Code Formating
Plug 'w0rp/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rhysd/git-messenger.vim'

" Install fzf and then the vim plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" Autocompletion and Intellisense
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}

" Utilities
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-rooter'
Plug 'moll/vim-bbye'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'
Plug 'luochen1990/rainbow'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ervandew/supertab'

" Initialize plugin system
call plug#end()

