# Status line and pane styling, shared by every palette.
# Colors come from @thm_* options set by a palette file (e.g. kanagawa-dragon.tmux).
# They are written as #{@thm_*} formats, so tmux looks them up each time it draws:
# loading a different palette recolors everything without re-sourcing this file.

# --------=== Status
set -g status on
set -g status-position top
set -g status-justify left
set -g status-style "bg=#{@thm_bg}"

# Left: the session name in bold
set -g status-left "#[fg=#{@thm_magenta},bold] #S #[default] "
set -g status-left-length 30

# Right: date and time
set -g status-right " #[fg=#{@thm_magenta},bold] %d.%m.%Y | %H:%M "
set -g status-right-length 100

# --------=== Messages
set -g message-style         "fg=#{@thm_fg},bg=#{@thm_bg_gutter},align=centre"
set -g message-command-style "fg=#{@thm_fg},bg=#{@thm_bg_gutter},align=centre"

# --------=== Windows
setw -g window-status-separator ""
setw -g window-status-style          "fg=#{@thm_fg},bg=#{@thm_bg},none"
setw -g window-status-activity-style "fg=#{@thm_fg},bg=#{@thm_bg},none"
# Window number, then the current directory's name
setw -g window-status-format         "#[fg=#{@thm_gray},bg=#{@thm_hl_med}] #I #[fg=#{@thm_fg},bg=#{@thm_bg}] #{b:pane_current_path} "
setw -g window-status-current-format "#[fg=#{@thm_bg},bg=#{@thm_magenta}] #I #[fg=#{@thm_fg},bg=#{@thm_bg_gutter}] #{b:pane_current_path} "

# --------=== Panes
# Inactive pane borders blend in, active one gets an accent
set -g pane-border-style        "fg=#{@thm_bg_gutter}"
set -g pane-active-border-style "fg=#{@thm_cyan}"
# Active border yellow in copy mode and red when panes are synchronized
#set -g pane-active-border-style "#{?pane_in_mode,fg=#{@thm_yellow},#{?synchronize-panes,fg=#{@thm_red},fg=#{@thm_cyan}}}"

set -g pane-border-lines heavy          # single | double | heavy | simple | number
set -g pane-border-status top           # show a label on each border
set -g pane-border-format "#{?pane_active,#[fg=#{@thm_bg}#,bg=#{@thm_cyan}#,bold],#[fg=#{@thm_gray}]} #{pane_index} #{pane_current_command} #[default]"

# --------=== Modes
# A colour option, not a style, so expand it now (-F) instead of at draw time
setw -gF clock-mode-colour "#{@thm_blue}"
setw -g mode-style "fg=#{@thm_fg},bg=#{@thm_bg_gutter},bold"

# --------=== Built-in theme colours
# tmux draws its own UI (the tree's +/- markers, menus, popups, copy-mode matches)
# with themegreen, themeblue, etc. Point those at the palette so they match.
# Set both the dark and light sets: whichever palette is loaded is the active one.
set -s dark-theme-black      "#{@thm_bg}"
set -s dark-theme-white      "#{@thm_fg}"
set -s dark-theme-light-grey "#{@thm_gray}"
set -s dark-theme-dark-grey  "#{@thm_bg_gutter}"
set -s dark-theme-green      "#{@thm_green}"
set -s dark-theme-yellow     "#{@thm_yellow}"
set -s dark-theme-red        "#{@thm_red}"
set -s dark-theme-blue       "#{@thm_blue}"
set -s dark-theme-cyan       "#{@thm_cyan}"
set -s dark-theme-magenta    "#{@thm_magenta}"
set -s light-theme-black      "#{@thm_bg}"
set -s light-theme-white      "#{@thm_fg}"
set -s light-theme-light-grey "#{@thm_gray}"
set -s light-theme-dark-grey  "#{@thm_bg_gutter}"
set -s light-theme-green      "#{@thm_green}"
set -s light-theme-yellow     "#{@thm_yellow}"
set -s light-theme-red        "#{@thm_red}"
set -s light-theme-blue       "#{@thm_blue}"
set -s light-theme-cyan       "#{@thm_cyan}"
set -s light-theme-magenta    "#{@thm_magenta}"
