###### REVMOB CONFIGURATION ########

DEV="$HOME/development"

# alias
alias dev="cd $DEV && ls"
alias rev="cd  $DEV/revmob && ls"
alias beluga="cd $DEV/beluga && ls"
alias bc="cd $DEV/beeconnect && ls"

alias console="beluga && cd console"
alias manager="beluga && cd manager"
alias rest="beluga && cd rest"
alias tuts="cd $DEV/tutoriais"

alias consoleo="console && vim package.json"
alias managero="manager && vim app.js"
alias resto="rest && vim app.js"

alias bashprofile="source ~/.bash_profile"

# npm
alias dev="npm run dev"
alias npmi="npm install --save"
alias npmd="npm install --save-dev"

alias simpleserver="python -m SimpleHTTPServer 3000"

#Beluga
alias localmanager="export LOCAL_MANAGER=true && echo 'manager is local'"
alias localreader="export LOCAL_READER=true && echo 'reader is local'"
alias autosignin="export NO_SIGNIN=true && echo 'autosignin on'"
alias save="export NO_SAVE='' && echo 'saving state'"
alias emptyapp="export EMPTY_APP=true && echo 'loading empty app'"
alias statefile="export STATE_FILE=true && echo 'save sate to file'"
alias loadstate="export LOAD_STATE=true && echo 'load state from file'"
alias nolocalmanager="export LOCAL_MANAGER='' && echo 'no local manager'"
alias nolocalreader="export LOCAL_READER='' && echo 'no local reader'"
alias noautosignin="export NO_SIGNIN='' && echo 'autosignin off'"
alias nosave="export NO_SAVE=true && echo 'not saving state'"
alias noemptyapp="export EMPTY_APP='' && echo 'emptyapp off'"
alias nostatefile="export STATE_FILE='' && echo 'no state to file'"
alias noloadstate="export LOAD_STATE='' && echo 'not loading state from file'"

alias restprodmanager="export B_MANAGER_PROD=true"


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

