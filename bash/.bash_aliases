# alias
alias ls="ls -G"
alias la="ls -GFlash"
alias bashprofile="source ~/.bash_profile"
alias editprofile="source ~/.bash_profile"

# npm
alias dev="npm run dev"
alias npmi="npm install --save"
alias npmd="npm install --save-dev"

alias simpleserver="python -m SimpleHTTPServer 3000"

############# PERSONAL CONFIGURATION ###############

#.bashrc manipulation
alias brc="vim ~/.bashrc"
alias sbrc="source ~/.bashrc"

#Navigation
alias ..="cd .."
alias ...="cd ../.."
alias desk="cd ~/Desktop && ls"
alias docs="cd ~/Documents && ls"
alias estudos="cd $HOME/Documents/estudos/ && ls"
alias livros="cd $HOME/Documents/livros/ && ls"
alias dotfiles="cd $HOME/dotfiles"

#git
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gac="git add -A; git commit"
alias grm="git rm"
alias gr="git reset"
alias gco="git checkout"
alias gcom="git checkout master"
alias gcod="git checkout development"
alias gs="git stash"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gsd="git stash drop"
alias ss="git status -sb"
alias gm="git merge --no-ff"
alias gb="git branch"
alias gitconfig="vim $HOME/.gitconfig"

#Abreviations
alias open="gnome-open"
alias ack="ack-grep"
alias w="watch"
alias wp="webpack_watch"

#Misc
alias install="sudo apt-get install -y"
alias update="sudo apt-get update"
alias rmVimSwap="find ./ -type f -name \"\\.*sw[klmnop]\" -exec rm -rvf {} \;"
alias as="XMODIFIERS= ~/.programs/android-studio/bin/studio.sh"
alias phoenixlog="tail -f /var/log/system.log | grep Phoenix"

