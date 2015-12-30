# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# RevMob setup config
#==============================================================================#
if [ -f $HOME/beaconBash.sh ]; then
  source $HOME/beaconBash.sh
fi

# functions
function build () {
  if [ -f ./build.zip ]; then
    rm ./build.zip
  fi
  zipbuild
}

function dumpMediation ()
{
    cd /data/db
    for i in ad_networks mediation_medias mediation_medias_summaries
    do
        mongodump -u heroku_app -p 9agzczbnSwEm8M0eUYycYpqx --host rs2-db06.revmob.com:27018 -d mobile-ads -c $i
        mongorestore -d ad-server -c $i dump/mobile-ads/$i.bson --drop
    done
}
#==============================================================================#

#My config
#==============================================================================#

#functions
function o() {
  if [[ -f app.js ]]; then
    vim app.js
  else
    gnome-open $1
  fi
}

function cdl ()
{
  cd $1 && ls
}

function cdnew ()
{
    if [ -d $1 ]; then
        echo "directory $1 already exists, entering it"
        cd $1
    else
        mkdir $1 && cd $1
        echo "dir $1 created"
    fi
}

function changeExtention()
{
  for f in *.$1; do
    mv -- "$f" "${f%.$1}".$2
  done
}

function watch()
{
  command -v nodemon >/dev/null 2>&1 || { echo >&2 "Nodemon is required. Aborting!"; return 1; }

  FILE="app.js"

  if [[ -f "$FILE" ]]; then
    nodemon $FILE
  else
    echo "No app.js found in " `pwd`
  fi
}

function webpack_watch()
{
  #validate if webpack is installed
  command -v webpack >/dev/null 2>&1 || { echo >&2 "Webpack is required. Aborting!"; return 1; }

  RUN_WEBPACK_SERVER=false
  BUILD_PRODUCTION=false
  CUSTOM_DIR=`pwd`
  CONFIG_FILE="webpack.config.js"

  #read options
  TEMP=`getopt -o spd: --long server,production,directory: -n 'syncsetup' -- "$@"`
  eval set -- "$TEMP"
  
  #extract options and arguments into variables
  while true; do
      case "$1" in
          -s|--server) RUN_WEBPACK_SERVER=true ; shift ;;
          -p|--production) BUILD_PRODUCTION=true ; shift ;;
          -d|--directory)
            case "$2" in
              "") shift 2 ;;
              *) CUSTOM_DIR=$2 ; shift 2 ;;
            esac ;;
          --) shift ; break ;;
          *) echo "Internal error!" ; return 1 ;;
      esac
  done

  #validate if webpack.config.js is present
  if [[ ! -f "$CUSTOM_DIR/webpack.config.js" ]]; then
    echo "No webpack.config.js found in " `pwd`
    return 1
  else
    echo "Running webpack in: $CUSTOM_DIR"
  fi

  #TODO: make webpack run from different directory
  if [ "$RUN_WEBPACK_SERVER" = true ]; then
    (cd $CUSTOM_DIR && webpack-dev-server --devtool eval --progress --colors --content-base build)
  elif [ "$BUILD_PRODUCTION" = true ]; then
    echo "WebPack: building for production"
    export NODE_ENV=production
    (cd $CUSTOM_DIR && webpack -p)
  else
    (cd $CUSTOM_DIR && webpack --progress --colors --watch --config "$CONFIG_FILE")
  fi
}
