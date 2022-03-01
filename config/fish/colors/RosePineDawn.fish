# RosePine Dawn Color Palette
# https://rosepinetheme.com/palette
set -l base faf4ed
set -l surface fffaf3
set -l overlay f2e9de
set -l inactive 9893a5
set -l subtle 797593
set -l text 575279
set -l love b4637a
set -l gold ea9d34
set -l rose d7827e
set -l pine 286983
set -l foam 56949f
set -l iris 907aa9

# Syntax Highlighting Colors
set -U fish_color_normal normal
set -U fish_color_command $iris
set -U fish_color_quote $gold
set -U fish_color_redirection $pine
set -U fish_color_end $iris
set -U fish_color_error $love
set -U fish_color_param $text
set -U fish_color_comment $subtle
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator $foam
set -U fish_color_escape $foam
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion $subtle
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r

# Completion Pager Colors
set -U fish_pager_color_completion normal
set -U fish_pager_color_description $rose yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
