#!/usr/bin/env bash
# Nightfox colors for Tmux
# Style: dayfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/dayfox/nightfox_tmux.tmux
blue="#6080B0"
fg_gutter="#AAACB3"
background="#EAEAEA"
black="#1D344F"
black_dm="#1C2F44"


set -g mode-style "fg=$blue,bg=$fg_gutter"
set -g message-style "fg=$blue,bg=$fg_gutter"
set -g message-command-style "fg=$blue,bg=$fg_gutter"
set -g pane-border-style "fg=$fg_gutter"
set -g pane-active-border-style "fg=$blue"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=$blue,bg=$background"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE
set -g status-left "#[fg=$background,bg=$blue,bold] #S #[fg=$blue,bg=$background,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=$background,bg=$background,nobold,nounderscore,noitalics]#[fg=$blue,bg=$background] #{prefix_highlight} #[fg=$fg_gutter,bg=$background,nobold,nounderscore,noitalics]#[fg=$black,bg=$fg_gutter] %Y-%m-%d  %I:%M %p #[fg=$blue,bg=$fg_gutter,nobold,nounderscore,noitalics]#[fg=$bg,bg=$blue,bold] #h "
setw -g window-status-activity-style "underscore,fg=$black_dm,bg=$background"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=$blue,bg=$background"
setw -g window-status-format "#[fg=$background,bg=$background,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=$blue,bg=$background,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=$background,bg=$fg_gutter,nobold,nounderscore,noitalics]#[fg=$black,bg=$fg_gutter,bold] #I  #W #F #[fg=$fg_gutter,bg=$background,nobold,nounderscore,noitalics]"
