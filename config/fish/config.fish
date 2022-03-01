set -x TERM xterm-256color
set -xU LS_COLORS "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34:su=0:sg=0:tw=0:ow=0:"

# Enable color in grep

set -x GREP_OPTIONS '--color=auto'
set -x GREP_COLOR '3;33'

set -x LESS '--ignore-case --raw-control-chars'
set -Ux PAGER 'less'
set -Ux EDITOR 'nvim'
set -Ux VISUAL 'nvim'

set -x LANG en_US.UTF-8
set -x LC_CTYPE "en_US.UTF-8"
set -x LC_MESSAGES "en_US.UTF-8"
set -x LC_COLLATE C

if status is-interactive
  # Commands to run in interactive sessions can go here
end

source "$HOME/.config/fish/colors/RosePine.fish"
source "$HOME/.config/fish/abbreviations.fish"
source "$HOME/.config/fish/rust.fish"
