# NOTE: you can use vars with $<var> and ${<var>} as long as the str is double quoted: ""
# WARNING: hex colors can't contain capital letters

    thm_bg="#181616"            # DragonBlack3
    thm_bg_gutter="#282727"     # DragonBlack4
    thm_fg="#c5c9c5"            # DragonWhite
    thm_cyan="#8ea4a2"          # DragonAqua
    thm_gray="#7a8382"          # DragonGray3
    thm_magenta="#a292a3"       # DragonPink
    thm_red="#c4746e"           # DragonRed
    thm_green="#87a987"         # DragonGreen
    thm_yellow="#c4b28a"        # DragonYellow
    thm_blue="#8ba4b0"          # DragonBlue2
    thm_orange="#d98d7b"        # DragonOrange2
    thm_hl_med="#1d1c19"        # DragonBlack2


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
