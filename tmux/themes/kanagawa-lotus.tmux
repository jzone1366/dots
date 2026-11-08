# NOTE: you can use vars with $<var> and ${<var>} as long as the str is double quoted: ""
# WARNING: hex colors can't contain capital letters

    thm_bg="#f2ecbc"            # LotusWhite3
    thm_bg_gutter="#e7dba0"     # LotusWhite4
    thm_fg="#545464"            # LotusInk1
    thm_cyan="#597b75"          # LotusAqua
    thm_gray="#8a8980"          # LotusGray3
    thm_magenta="#b35b79"       # LotusPink
    thm_red="#c84053"           # LotusRed
    thm_green="#6f894e"         # LotusGreen
    thm_yellow="#77713f"        # LotusYellow
    thm_blue="#9fb5c9"          # LotusBlue3
    thm_orange="#cc6d00"        # LotusOrange
    thm_hl_med="#e5ddb0"        # LotusWhite2

# ----------------------------=== Theme ===--------------------------

# status
    set -g status-position top
    set -g status "on"
    set -g status-bg "$thm_bg"
    set -g status-justify "left"
    set -g status-left-length "100"
    set -g status-right-length "100"

# messages
    set -g message-style fg="$thm_fg",bg="$thm_bg_gutter",align="centre"
    set -g message-command-style fg="$thm_fg",bg="$thm_bg_gutter",align="centre"

# panes
    set -g pane-border-style fg="$thm_bg_gutter"
    set -g pane-active-border-style fg="$thm_blue"

# windows
    setw -g window-status-activity-style fg="$thm_fg",bg="$thm_bg",none
    setw -g window-status-separator ""
    setw -g window-status-style fg="$thm_fg",bg="$thm_bg",none

# --------=== Statusline
#   # Left: the session name in bold
    # set -g status-left ""
    set -g status-left "#[bold] #S #[default] "
    set -g status-left-length 30

#   # Right: the session name in bold
    set -g status-right " #[fg=$thm_magenta,bold] %d.%m.%Y | %H:%M "


# current_dir
    setw -g window-status-format "#[fg=$thm_gray,bg=$thm_hl_med] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "
    setw -g window-status-current-format "#[fg=$thm_bg,bg=$thm_magenta] #I #[fg=$thm_fg,bg=$thm_bg_gutter] #{b:pane_current_path} "

# --------=== Modes
    setw -g clock-mode-colour "$thm_blue"
    setw -g mode-style "fg=$thm_fg bg=$thm_bg_gutter bold"
