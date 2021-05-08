# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mathan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# ' 

autoload -Uz compinit && compinit

# setting completion to be case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# setting humping to be bash like
autoload -U select-word-style
select-word-style bash

# enabling bash like comments
setopt interactivecomments

DOTFILES_DIR=$(dirname $(realpath ${(%):-%N}))

source "$DOTFILES_DIR/.env"

source "$DOTFILES_DIR/scripts/ssh-setup.sh"
source "$DOTFILES_DIR/scripts/pingcheck.sh"


alias -g G="| grep"
alias -g L="| less"
alias -g V="| vipe"
alias -g T=" > >(tee -a tee_stdout.log) 2> >(tee -a tee_stderr.log >&2)"

alias gst='git status -uno'
alias open='xdg-open'
alias tempdir='cd $(mktemp -d)'
alias publicip='curl ifconfig.me'
alias whatismyip=publicip
alias copy='bash $DOTFILES_DIR/scripts/xcl.sh'
alias startt='bash $DOTFILES_DIR/scripts/standard-tmux.sh'
alias emnw='emacsclient -nw -a "emacs"'
alias init_venv='virtualenv venv; . ./venv/bin/activate;pip install -r requirements.txt'
alias testbox='ssh -i $TESTBOX_SSH_KEYFILE $TESTBOX_URL -p $TESTBOX_SSH_PORT -X -L $TESTBOX_VNC_PORT\:localhost:$TESTBOX_VNC_PORT'

plugins=(git ssh-agent)

export EDITOR=/usr/bin/vim
export VISUAL=/usr/local/bin/emacsclient

function rcd {
  # ranger cd
  # adapted from the ranger github 
  tempfile=$(mktemp -t tmp.XXXXXX)
  ranger --choosedir="$tempfile" "$(echo "$(pwd)")"
  if [ "(cat -- "$tempfile")" != "(echo -n `pwd`)" ] 
     {
       cd "$(cat "$tempfile")"
     }
}

function virustotal {
  firefox  https://www.virustotal.com/gui/file/$(md5sum $argv | awk '{print $1}')
}

function reCmake {
  echo "creating build dir"
  rm -rf ./build/ &&
  mkdir ./build &&
  pushd ./build &&
  echo "running cmake..." &&
  cmake -DCMAKE_BUILD_TYPE="Debug" .. T &&
  echo "running make..." &&
  make -j4 T ;
  popd;
  echo "done";
}

function cCommands {
  	cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
	if [  -e compile_commands.json ]; then rm -r compile_commands.json;	fi
	ln -s Debug/compile_commands.json .
}

function emc {
  if [ $# -eq 1 ]
  then 
    emacsclient -n -q -c -a "emacs" $1 &
  else
    emacsclient -n -q -c -a "emacs" &
  fi
  
  if jobs | grep -q 'emacs'; then disown emacs; fi
}

function pyve {
  if [  -e venv/ ]
  then 
    echo 'activating on . '
    . venv/bin/activate
  elif [  -e ../venv/ ]
  then 
    echo 'activating on .. '
    . ../venv/bin/activate
  elif [  -e ../../venv/ ]
  then 
    echo 'activating on ../.. '
    . ../../venv/bin/activate
  else 
    echo "no venv found, searched three levels up"
  fi
}