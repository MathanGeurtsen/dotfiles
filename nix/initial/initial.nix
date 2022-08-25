{ pkgs ? import <nixpkgs> {} }:
[
  pkgs.coreutils
  pkgs.firefox
  pkgs.python39
  pkgs.gnumake
  pkgs.cmake
  pkgs.zsh
  pkgs.direnv
  pkgs.git
  pkgs.curl
  pkgs.vim
  pkgs.tldr
  pkgs.moreutils
  pkgs.xclip
  pkgs.ranger
  pkgs.sqlite
  pkgs.vlc
  pkgs.btop
  pkgs.qbittorrent
  pkgs.gimp
  pkgs.keepassxc
  pkgs.texlive.combined.scheme-full
  # texlive-bibtex-extra
  # biber
  pkgs.xkbset
  # gnome-tweak-tool
  pkgs.nmap
]
