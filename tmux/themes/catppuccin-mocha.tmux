# NOTE: you can use vars with $<var> and ${<var>} as long as the str is double quoted: ""
# WARNING: hex colors can't contain capital letters

    thm_bg="#1e1e2e"
    thm_bg_gutter="#11111b"
    thm_fg="#cdd6f4"
    thm_cyan="#74c7ec"
    thm_gray="#313244"
    thm_magenta="#b4befe"
    thm_red="#f38ba8"
    thm_green="#a6e3a1"
    thm_yellow="#f9e2af"
    thm_blue="#89b4fa"
    thm_orange="#fab387"
    thm_bg_highlight="#585b70"
    thm_hl_med="#a6adc8"

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
    set -g status-left ""
    set -g status-right "#[fg=$thm_cyan,bg=$thm_bg,nobold,nounderscore,noitalics]█#[fg=$thm_bg,bg=$thm_cyan,nobold,nounderscore,noitalics] #[fg=$thm_cyan,bg=$thm_bg_gutter,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_bg_gutter]#W #[fg=$thm_green,bg=$thm_bg_gutter]█#[fg=$thm_bg,bg=$thm_green] #[fg=$thm_green,bg=$thm_bg_gutter,nobold,nounderscore,noitalics]#[fg=$thm_fg,bg=$thm_bg_gutter] #S #[fg=$thm_orange,bg=$thm_bg_gutter]█#[fg=$thm_bg,bg=$thm_orange] #[fg=$thm_orange,bg=$thm_bg_gutter,nobold,nounderscore,noitalics]#[fg=$thm_fg,bg=$thm_bg_gutter] %d.%m.%Y #{?client_prefix,#[fg=$thm_red],#[fg=$thm_yellow]}#[bg=$thm_bg_gutter]█#{?client_prefix,#[bg=$thm_red],#[bg=$thm_yellow]}#[fg=$thm_bg] #{?client_prefix,#[fg=$thm_red],#[fg=$thm_yellow]}#[bg=$thm_bg_gutter]#[fg=$thm_fg,bg=$thm_bg_gutter] %H:%M:%S "

# current_dir
    setw -g window-status-format "#[fg=$thm_gray,bg=$thm_hl_med] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "
    setw -g window-status-current-format "#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_bg_gutter] #{b:pane_current_path} "

# --------=== Modes
    setw -g clock-mode-colour "$thm_blue"
    setw -g mode-style "fg=$thm_cyan bg=$thm_bg_highlight bold"

