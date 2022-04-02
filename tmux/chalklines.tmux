# NOTE: you can use vars with $<var> and ${<var>} as long as the str is double quoted: ""
# WARNING: hex colors can't contain capital letters

# --> chalklines
thm_bg="#070a0e"
thm_fg="#fcf7f8"
thm_cyan="#71b3d9"
#thm_black="#040507"
thm_gray1="#29323a"
thm_magenta="#f8a0b7"
thm_pink="#ed7782"
thm_red="#bf3f50"
thm_green="#5cab7d"
thm_yellow="#fcd772"
thm_blue="#577fa1"
thm_orange="#de8b61"
thm_black4="#181e24"
thm_mauve="#866FA0"

# ----------------------------=== Theme ===--------------------------

# status
set -g status-position top
set -g status "on"
set -g status-bg "$thm_bg"
set -g status-justify "left"
set -g status-left-length "100"
set -g status-right-length "100"

# messages
set -g message-style fg="$thm_cyan",bg="$thm_gray1",align="centre"
set -g message-command-style fg="$thm_cyan",bg="$thm_gray1",align="centre"

# panes
set -g pane-border-style fg="$thm_gray1"
set -g pane-active-border-style fg="$thm_blue"

# windows
setw -g window-status-activity-style fg="$thm_fg",bg="$thm_bg",none
setw -g window-status-separator ""
setw -g window-status-style fg="$thm_fg",bg="$thm_bg",none

# --------=== Statusline

set -g status-left ""
set -g status-right "#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray1] #W #[fg=$thm_green,bg=$thm_gray1]#[fg=$thm_bg,bg=$thm_green] #[fg=$thm_fg,bg=$thm_gray1] #S #[fg=$thm_mauve,bg=$thm_gray1]#[fg=$thm_bg,bg=$thm_mauve] #[fg=$thm_fg,bg=$thm_gray1] %d.%m.%Y #{?client_prefix,#[fg=$thm_red],#[fg=$thm_yellow]}#[bg=$thm_gray1]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_yellow]}#[fg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray1] %H:%M:%S "

# current_dir
setw -g window-status-format "#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray1] #{b:pane_current_path} "
setw -g window-status-current-format "#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "

# --------=== Modes
setw -g clock-mode-colour "${thm_blue}"
setw -g mode-style "fg=${thm_pink} bg=${thm_black4} bold"
