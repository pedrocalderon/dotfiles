###### REVMOB CONFIGURATION ########

if [ -d $HOME/development/beeconnect ]; then
  REV="$HOME/development/beeconnect"
else
  REV="$HOME/development/revmob"
fi

# alias
alias custom="vim ~/.bash_custom"
alias rev="cd  $REV && ls"
alias dev="cd $REV && cd .."
alias tuts="cd $REV && cd .. && cd tutoriais"
alias console="cd $REV/beeconnect-console"
alias api="cd $REV/ishopApi"
alias router="cd $REV/beaconRouter"
alias site="cd $REV/beeConnectSite"
alias bjobs="cd $REV/beaconJobs"

alias consoleo="cd $REV/beeconnect-console && vim app.js"
alias apio="cd $REV/ishopApi && vim app.js"
alias routero="cd $REV/beaconRouter && vim app.js"
alias siteo="cd $REV/beeConnectSite && vim app.js"
alias bjobso="cd $REV/beaconJobs && vim app.js"

alias apir="api && port && sup dev"

alias zipbuild="zip -r build.zip app.js appSite/ build/ newrelic.js \
  corpSite/ node_modules/ package.json rev_modules/ server/ src/"

# npm
alias devs="npm run devs"
alias devf="npm run devf"
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

