#!/bin/bash

pane_id=$1
cur_pane_id=`tmux display-message -p "#{pane_id}"`
cur_pane_pid=`tmux display-message -p "#{pane_pid}"`
title_id=${pane_id#%*}
tmux_title=

if [ $cur_pane_id == $pane_id ]; then
    tmux_title=$(pgrep -P $cur_pane_pid | xargs -I{} ps -o command -p {} | grep ssh | sed -E 's/^.*ssh //')
    tmux set-environment -g pane_ssh_title_$title_id "$tmux_title"
else
    tmux_title=$(tmux show-environment -g pane_ssh_title_$title_id 2>/dev/null | sed -E 's/[^=]*=//')
fi

if [ x$tmux_title != x ]; then
    echo " $tmux_title "
else
    echo " "
fi
