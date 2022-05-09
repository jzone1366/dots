#!/usr/bin/env bash

# RosePine Dawn colors for Tmux
base="#faf4ed"
surface="#fffaf3"
overlay="#f2e9e1"
muted="#9893a5"
subtle="#797593"
text="#575279"
love="#b4637a"
gold="#ea9d34"
rose="#d7827e"
pine="#286983"
foam="#56949f"
iris="#907aa9"

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

