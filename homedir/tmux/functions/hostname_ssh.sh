#!/usr/bin/env bash

tty=$(tmux display -p '#{pane_tty}')
ps -t "$tty" -o command= | grep -w ssh | grep -v grep | rev | cut -d' ' -f1 | rev
