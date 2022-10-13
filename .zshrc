
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY autocd nocaseglob
export HISTTIMEFORMAT="[%F %T] "
unsetopt beep extendedglob notify
bindkey -e

# enable glob expansion in history search
bindkey '^R' history-incremental-pattern-search-backward

# The following lines were added by compinstall
zstyle :compinstall filename '/home/mathan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle :omz:plugins:ssh-agent lazy yes
plugins=(git ssh-agent)


# get man pages colored by bat, have less use case insensitive search
if [ ! -z "$batpager" ]; then
if $(batcat --version > /dev/null 2>&1); then
  bat_alias="batcat"
else
  bat_alias="bat"
fi
export MANPAGER="sh -c 'col -bx | $bat_alias -l man -p --pager=\"less -ri\"'"
fi
if $(test -n "$nixshell"); then
  nixPS=" (n)"
else
  nixPS=""
fi
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
 hostPS="@$(hostname | head -c5) "
else
 hostPS=""
fi

PROMPT='%(?.%F{green}√.%F{red}?%?)%f'"$nixPS $hostPS"' %B%F{240}%1~%f%b %# ' 

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
source "$DOTFILES_DIR/scripts/pi-scripts.sh"
export PATH=$PATH:/home/mathan/.local/bin/

alias ll='ls -hAltr --color=auto'

alias -g G="| grep"
alias -g L="2>&1 | less -iRF"
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
alias mp="make -f personal.mk"
alias R="nice -n 10 R --no-save --no-restore-data"
alias wshutdown="cmd.exe  /c shutdown /s"
alias wreboot="cmd.exe  /c shutdown /r /t 0"
alias wnosleep="Powercfg.exe /Change standby-timeout-ac 0"
alias wtop='powershell.exe -c "C:\Python38\python.exe -m glances"'
alias wsleep="cmd.exe /c shutdown /h"
alias git-root="git rev-parse --show-toplevel"
alias zella='zellij attach $(zellij list-sessions | head -n1) || zellij'
alias pitube='noglob pitube'


export NOTIFY_FILE="$(realpath ~/notify)"
export EDITOR=vim

if [ -f /var/run/reboot-required ]; then cat /var/run/reboot-required; fi

eval "$(direnv hook zsh)"

renice -n 1 $$ 2>&1 > /dev/null # trying out to prevent freezes with running out of memory during compilation etc.

function pd {
  # wrapper around pushd/popd. pushd to argument if given, popd otherwise
  if [ $# -ge 1 ]; then
    if [ -d "$@" ]; then
     pushd "$@"
     else
       pushd $(dirname "$@")
    fi
  else
    popd
  fi
}

function tmuxa {
  tmux attach
  if [ 0 -ne $? ]; then
    tmux
  fi
}

function figr {
  fileRegex="$1"
  exclusionRegex="$2"
  stringRegex="$3"
  find . -type f -regex "$fileRegex" -not -regex "$exclusionRegex" -print0 | xargs -0 -I{} grep -IinH --color=ALWAYS "$stringRegex" "{}" 2>&1 | less -iRF
}

function rcd {
  # ranger cd
  # adapted from the ranger github 
  tempfile=$(mktemp -t tmp.XXXXXX)
  ranger --choosedir="$tempfile" "$(echo "$(pwd)")"
  if [ "(cat -- \"$tempfile\")" != "(echo -n `pwd`)" ] 
     {
       pushd "$(cat "$tempfile")"
     }
}

function virustotal {
  firefox  "https://www.virustotal.com/gui/file/$(md5sum $argv | awk '{print $1}')"
}

function reCmake {
  echo "creating build dir"
  rm -rf ./build/ &&
  mkdir ./build &&
  pushd ./build &&
  echo "running cmake..." &&
  cmake -DCMAKE_BUILD_TYPE="Debug" .. T &&
  echo "running make..." &&
  make -j T $@;
  res=$?
  popd;
  echo "done";
  return $res
}

function cCommands {
  	cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
	if [  -e compile_commands.json ]; then rm -r compile_commands.json;	fi
	ln -s Debug/compile_commands.json .
}

function emc {
  if [ $# -ne 0 ]
  then 
    emacsclient -na "emacs" $@ &
  else
    emacsclient -na "emacs" &
  fi
  
  if jobs | grep -q 'emacs'; then disown emacs; fi
}

function rootsearch() {
  # search from cwd down to root for a file matching `filename`, eval `function` with that directory as argument
  filename=$1
  function=$2
  depth=$(pwd | awk '{gsub("[^/]", "", $1); print length}')
  dir="./"
  for i in {1..$depth}; do 
    if [ $i -gt 1 ]; then
      dir="$dir../"
    fi

    if [  -e "${dir}${filename}" ]
    then 
      echo "running $function on $(realpath "$dir")"
      eval "$function ${dir}${filename}"
      return $?
    fi
  done
  echo "couldn't find $filename, reached root"
  return 1
}

function pyve() {
  # search for nearest python venv, then activate
  rootsearch venv/bin/activate 'source'
}

function nixe() {
  # search for nearest nix shell definition, then attempt to run zsh in it
  rootsearch "shell.nix" "nix-shell --command 'zsh' $@"
}


function wcopy {
  echo "$@" | clip.exe
}


function psh {
  # WSL specific convenience function, starts powershell in current dir 
  windows_dir=$(wslpath -w $(pwd))
  
  powershell.exe -NoExit -Command "cd \"$windows_dir\"; $@"
}

function wstart {
 # WSL specific convenience function providing powershell start
  windows_dir=$(wslpath -w $(pwd))
  
  powershell.exe -Command "cd $windows_dir; start $1"
}

function wem {
  # WSL specific convenience function, calls windows emacsclient with argument's converted path
  windows_path=$(wslpath -w $1)
  emacsclientw.exe $windows_path
}

alert-notify() {
  message="done, returncode: $?"
  NOTIFY_FILE="${NOTIFY_FILE:-$(realpath ~/notify)}"
  if [ $# -gt 0 ]; then message="$@"; fi
  echo "$message" | tee "$NOTIFY_FILE"
}

function notice-notify () {
  NOTIFY_FILE="${NOTIFY_FILE:-$(realpath ~/notify)}"
  if [ $# -gt 0 ]; then
    NOTIFY_FILE="$1"
  fi

  if [ -e ~/.notice-notify.pid ]; then
    kill $(cat ~/.notice-notify.pid)
  fi
  nohup $(while sleep 5; do 
            if [ -f "$NOTIFY_FILE" ]; then 
              notify-send "$(cat "$NOTIFY_FILE")"
              rm "$NOTIFY_FILE"
            fi
          done) &
  disown
  echo "$!" >> ~/.notice-notify.pid

}


wnotice-notify() {
  NOTIFY_FILE="${NOTIFY_FILE:-$(realpath ~/notify)}"
  nohup $(while sleep 5; do if [ -f "$NOTIFY_FILE" ]; then wnotify "$(cat "$NOTIFY_FILE")"; rm "$NOTIFY_FILE"; fi; done) &
}

function wnotify {

balloon='function balloon {
Param(
        $title,
        $text
    )
    Add-Type -AssemblyName System.Windows.Forms 
    $global:balloon = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -id $pid).Path
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
    $balloon.BalloonTipText = $text
    $balloon.BalloonTipTitle = $title
    $balloon.Visible = $true 
    $balloon.ShowBalloonTip(5)
}' 
balloon+="; balloon 'bash notification' '$@'"
psh "$balloon; exit"
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
 
function process-paste {
pid="$(ps aux | awk -v pattern="$1" '$11 ~ pattern{print $2}' | tail -n1)"
id="$(xdotool search --onlyvisible --pid $pid)"
xdotool windowactivate "$id" &&\
sleep 0.3 &&\
xdotool type "$(xclip -o)"
}

function col {
  # select column from output. 0 for every column
  if [ $1 -ne 0 ]; then
  head -n$(($1)) | tail -n1
  else
    cat
  fi
}

function row {
  # select row from output. 0 for every row
  if [ $1 -ne 0 ]; then
  awk -v var=$1 '{print $var}'
  else
    cat
  fi
}

function loc {
  # select column and row from output. 0 for all rows/cols
  col $1 | row $2
}

redraw_output() {
  # clear screen and draw `function` output over itself in a loop
  # preserves scrollback buffer by only clearing previous output
  # assumes `function` output draws in the same place
  function="$1"
  if [ "$2" ]; then
    time="$2"
  else
    time=1
  fi
    clear -x
  while sleep $time; do
    output="$(eval $function)"
    N=$(echo $output | wc -l)
    for i in $(seq $N); do
      echo -e "\r\033["$i"A\033[0K";
    done
    echo -e "\r\033["$N"A\033[0K$output";
  done
}

function active_window {
  if [ "$1" ]; then
    time="$1"
  else
    time=1
  fi
  ps aux | loc 1 0
  sleep $time; ps aux | grep "$(xdotool getactivewindow getwindowpid)"
}

function spinner {
 while true; do
   strings="- \\ | /"; 
   for f in ${=strings}; do 
     sleep 1; 
     tput sc;tput cup 0 0;echo - "$f";tput rc;
   done; 
 done &

}

function whereami {
  echo -e "hostname: $(hostname)\nusername: $(whoami)\npwd: $(pwd)"
}

function pitube {
  ssh pibox ~/yt-dlp/yt-dlp -S "height:720" -o '"~/sambashare/media/youtube/%(title)s.%(ext)s"' "$1"&
}
