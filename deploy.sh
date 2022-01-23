#!/bin/env bash
DOTFILES_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))
ln -s "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -s "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -s "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
ln -s "$DOTFILES_DIR/.emacs.d" ~/.emacs.d
ln -s "$DOTFILES_DIR/.xprofile" ~/.xprofile
ln -s "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -s "$DOTFILES_DIR/.Rprofile" ~/.Rprofile
