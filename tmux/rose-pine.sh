#!/usr/bin/env bash

# RosePine colors for Tmux

set -g mode-style "fg=#e0def4,bg=#1f1d2e"

set -g message-style "fg=#e0def4,bg=#1f1d2e"
set -g message-command-style "fg=#e0def4,bg=#1f1d2e"

set -g pane-border-style "fg=#1f1d2e"
set -g pane-active-border-style "fg=#e0def4"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#e0def4,bg=#1f1d2e"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#1f1d2e,bg=#9ccfd8,bold] #S #[fg=#9ccfd8,bg=#1f1d2e,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#1f1d2e,bg=#1f1d2e,nobold,nounderscore,noitalics]#[fg=#e0def4,bg=#1f1d2e] #{prefix_highlight} #[fg=#1f1d2e,bg=#1f1d2e,nobold,nounderscore,noitalics]#[fg=#e0def4,bg=#1f1d2e] %Y-%m-%d  %I:%M %p #[fg=#e0def4,bg=#1f1d2e,nobold,nounderscore,noitalics]#[fg=#15161E,bg=#e0def4,bold] #h "

setw -g window-status-activity-style "underscore,fg=#908caa,bg=#1f1d2e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#908caa,bg=#1f1d2e"
setw -g window-status-format "#[fg=#1f1d2e,bg=#1f1d2e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#9ccfd8,bg=#9ccfd8,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#1f1d2e,bg=#1f1d2e,nobold,nounderscore,noitalics]#[fg=#e0def4,bg=#1f1d2e,bold] #I  #W #F #[fg=#1f1d2e,bg=#1f1d2e,nobold,nounderscore,noitalics]"
