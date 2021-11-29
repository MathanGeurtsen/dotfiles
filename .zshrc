# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY autocd nocaseglob
export HISTTIMEFORMAT="[%F %T] "
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

# disable flow control characters (Free up C-s and C_q)
stty -ixon -ixoff

DOTFILES_DIR=$(dirname $(realpath ${(%):-%N}))

source "$DOTFILES_DIR/.env"

source "$DOTFILES_DIR/scripts/ssh-setup.sh"
source "$DOTFILES_DIR/scripts/pingcheck.sh"

alias ll='ls -alF'

alias -g G="| grep"
alias -g L="| less"
alias -g V="| vipe"
alias -g T=" > >(tee -a tee_stdout.log) 2> >(tee -a tee_stderr.log >&2)"

alias gst='git status -uno'
alias open='xdg-open'
alias tempdir='pushd $(mktemp -d)'
alias publicip='curl ifconfig.me'
alias whatismyip=publicip
alias copy='bash $DOTFILES_DIR/scripts/xcl.sh'
alias startt='bash $DOTFILES_DIR/scripts/standard-tmux.sh'
alias emnw='emacsclient -nw -a "emacs"'
alias init_venv='virtualenv venv; . ./venv/bin/activate;pip install -r requirements.txt'
alias testbox="ssh -i $TESTBOX_SSH_KEYFILE mathan@$TESTBOX_URL -p $TESTBOX_SSH_PORT -X -L $TESTBOX_VNC_PORT\:localhost:$TESTBOX_VNC_PORT"
alias ISO8601="date +%Y%m%dT%H%M%S"
alias winhome="/mnt/c/users/mathan"
alias mp="make -f personal.mk"
plugins=(git ssh-agent)


export EDITOR=/usr/bin/vim
export VISUAL=/usr/local/bin/emacsclient

function figr {
  fileRegex="$1"
  exclusionRegex="$2"
  stringRegex="$3"
  find . -regex "$fileRegex" -not -regex "$exclusionRegex" -print0 | xargs -0 grep -i "$stringRegex"
}

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

function

pyve() {
  depth=$(pwd | awk '{gsub("[^/]", "", $1); print length}')
  dir="./"
  for i in {1..$depth}; do 
    if [ $i -gt 1 ]; then
      dir="$dir../"
    fi

    activate="${dir}venv/bin/activate"
    if [  -e "$activate" ]
    then 
      echo "activating on $activate"
      . "$activate"
      return 0
    fi
  done
  echo "no venv for bash found, reached root"
  return 1
}

function psh {
  # WSL specific convenience function, starts powershell in current dir 
  windows_dir=$(wslpath -w $(pwd))
  
  powershell.exe -NoExit -Command cd $windows_dir
}

function wem {
  # WSL specific convenience function, calls windows emacsclient with argument's converted path
  windows_path=$(wslpath -w $1)
  emacsclientw.exe $windows_path
}

function proc_running {
  # check if process is still running 
  procID=$1
  if [ -z "$2" ] 
  then
    timeout=3
  else
    timeout=$2
  fi
  
  while true;
  do
    ps | grep $procID > /dev/null 2>&1
    if [ 0 -eq $? ]; then 
      echo "$(date +%H:%M:%S): process $procID is still running" 
      sleep $timeout;
    else
      echo "$(date +%H:%M:%S): process $procID has terminated"
      break;
    fi
  done
}
 
