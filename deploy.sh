#!/bin/env bash
DOTFILES_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))

rm ~/.bashrc
rm ~/.zshrc

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
mkdir -p ~/.config/gdb
ln -s "$DOTFILES_DIR/gdbinit" ~/.gdbinit
ln -s "$DOTFILES_DIR/.sqliterc" ~/.sqliterc
ln -s "$DOTFILES_DIR/.ideavimrc" ~/.ideavimrc
mkdir -p ~/.config/zellij
ln -s "$DOTFILES_DIR/zellij_config.kdl" ~/.config/zellij/config.kdl
mkdir -p ~/.config/nix
ln -s "$DOTFILES_DIR/nix.conf" ~/.config/nix/nix.conf
