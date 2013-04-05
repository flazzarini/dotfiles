#!/bin/bash

tmux new-session -s "chat" -n centerim -d centerim
tmux new-window -t "chat:1" -n irssi irssi

