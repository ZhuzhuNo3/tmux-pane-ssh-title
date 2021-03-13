#!/bin/bash

pane_id=$1
cur_pane_id=`tmux display-message -p "#{pane_id}"`
cur_pane_pid=`tmux display-message -p "#{pane_pid}"`
# title_id=${pane_id#%*}
title_id=${pane_id}
tmux_title=

# get_tty() {
#     # sshp /usr/bin/ssh $1 bash -c 'last -1|head -n1|awk '"'"'{print $2}'"'"'' 2>/dev/null
#     sshp /usr/bin/ssh $1 bash -c ls
# }

# # tty sshdir
# get_cmd() {
#     sshp /usr/bin/ssh $2 bash -c 'w -h|awk '"'"'{if("'"'$1'"'"==$2){sta='"'"'"$(w -|awk '"'"'{if(NR==2)print NF}'"'"')"'"'"';for(i=1;i<sta;i++){$i=""};print $0}}'"'"'|sed '"'"'s/^ *//g'"'"'' 2>/dev/null
# }

if [ $cur_pane_id == $pane_id ]; then
    tmux_title=$(pgrep -P $cur_pane_pid | xargs -I{} ps -o command -p {} | grep ssh | sed -E 's/^.*ssh //')
    tmux set-environment -g pane_ssh_title_$title_id "$tmux_title"
    # if [ x$tmux_title != x ]; then
    #     tty=$(tmux show-environment -g pane_tty_$title_id 2>/dev/null | sed -E 's/[^=]*=//')
    #     if [ "$tty" = "" ]; then
    #         tty=$(get_tty $tmux_title)
    #         tmux set-environment -g pane_tty_$title_id "$tty" 
    #     fi
    #     if [ "$tty" != "" ]; then
    #         tmux set-environment -g pane_title_cmd_$title_id "$tty"#"$(get_cmd $tty $tmux_title)"
    #     fi
    # else
    #     tmux set-environment -g pane_tty_$title_id "" 
    #     tmux set-environment -g pane_title_cmd_$title_id "" 
    # fi
else
    tmux_title=$(tmux show-environment -g pane_ssh_title_$title_id 2>/dev/null | sed -E 's/[^=]*=//')
fi

if [ x$tmux_title != x ]; then
    echo " #{pane_ssh_title_$title_id}"
else
    echo " #{pane_current_command}"
fi
