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
source "$DOTFILES_DIR/scripts/zsh_functions.sh"


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
