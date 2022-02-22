# RosePine Dawn Color Palette
# https://rosepinetheme.com/palette
set -l foreground 575279 #text
set -l selection f2e9e1 #overlay
set -l comment 9893a5 #muted
set -l red b4637a #love
set -l orange ea9d34 #gold
set -l yellow dfdad9 #highlight_med
set -l green 56949f #foam
set -l purple 907aa9 #iris
set -l cyan 286983 #pine
set -l pink d7827e #rose

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


