#!/usr/bin/env bash

source ~/scripts/ssh-setup.sh
ssh-setup

tmux new-session -d 

# start panes
tmux split-window -d -t 0 -h

# resize panes
tmux resize-pane -t 1 -R 10 

# possibly go to right dir
# tmux send-keys -t 0 'cd <dir> clear; fish_greeting' enter

tmux send-keys -t 1 'gotop -b' enter

tmux selectp -t 0

tmux attach


