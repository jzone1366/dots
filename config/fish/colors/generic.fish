set -l foreground e0def4 #text
set -l selection 26233a #overlay
set -l comment 6e6a86 #muted
set -l red eb6f92 #love
set -l orange f6c177 #gold
set -l yellow 403d52 #highlight_med
set -l green 9ccfd8 #foam
set -l purple c4a7e7 #iris
set -l cyan 31748f #pine
set -l pink ebbcba #rose

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment


