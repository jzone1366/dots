#!/usr/bin/env bash

# RosePine Main colors for Tmux
base="#191724"
surface="#1f1d2e"
#overlay="#26233a"
muted="#6e6a86"
subtle="#908caa"
text="#e0def4"
#love="#eb6f92"
#gold="#f6c177"
#rose="#ebbcba"
pine="#31748f"
foam="#9ccfd8"
#iris="#c4a7e7"

set -g mode-style "fg=$base,bg=$muted"

set -g message-style "fg=$text,bg=$base"
set -g message-command-style "fg=$text,bg=$base"

set -g pane-border-style "fg=$surface"
set -g pane-active-border-style "fg=$text"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=$text,bg=$base"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=$base,bg=$pine,bold] #S #[fg=$pine,bg=$base,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=$base,bg=$base,nobold,nounderscore,noitalics]#[fg=$text,bg=$base] #{prefix_highlight} #[fg=$surface,bg=$base,nobold,nounderscore,noitalics]#[fg=$text,bg=$surface] %Y-%m-%d  %I:%M %p #[fg=$text,bg=$surface,nobold,nounderscore,noitalics]#[fg=$surface,bg=$text,bold] #h "

setw -g window-status-activity-style "underscore,fg=$subtle,bg=$surface"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=$subtle,bg=$surface"
setw -g window-status-format "#[fg=$surface,bg=$surface,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=$surface,bg=$base,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=$base,bg=$foam,nobold,nounderscore,noitalics]#[fg=$base,bg=$foam,bold] #I  #W #F #[fg=$foam,bg=$base,nobold,nounderscore,noitalics]"
