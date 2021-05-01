#!/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
echo $SCRIPT_DIR
ln -s "$SCRIPT_DIR/.bashrc" ~/.bashrc
ln -s "$SCRIPT_DIR/.zshrc" ~/.zshrc
ln -s "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf
ln -s "$SCRIPT_DIR/.emacs.d" ~/.emacs.d

