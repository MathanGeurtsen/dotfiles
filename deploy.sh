#!/bin/env bash
DOTFILES_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))
ln -s "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -s "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -s "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
ln -s "$DOTFILES_DIR/.emacs.d" ~/.emacs.d
ln -s "$DOTFILES_DIR/.xprofile" ~/.xprofile
ln -s "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -s "$DOTFILES_DIR/.Rprofile" ~/.Rprofile
ln -s "$DOTFILES_DIR/.pdbrc" ~/.pdbrc
ln -s "$DOTFILES_DIR/.flake8" ~/.flake8
mkdir -p ~/.config/ranger
ln -s "$DOTFILES_DIR/rc.conf" ~/.config/ranger/rc.conf
