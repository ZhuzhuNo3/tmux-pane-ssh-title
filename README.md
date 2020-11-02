use like

```tmux
set -g pane-border-format "#[fg=cyan][#{pane_index}#(~/.tmux/plugins/tmux-pane-ssh-title/tmux_pane_ssh_title.sh #{pane_id})#{pane_current_command}]"
```
