# EXPORTS
# Setup terminal, and turn on colors
#export CLICOLOR=1
#export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
#export GREP_COLOR='3;33'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export EDITOR='nvim'

export LC_COLLATE=C

export GOPATH="${HOME}/Go"
export PATH="${GOPATH}/bin:${PATH}"


# Python Stuff
#export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS=' -p /usr/bin/python3 '

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

#export PATH="/usr/local/lib/nvim-osx64/bin:$PATH"

# Add home/.dotnet/tools
export PATH="$HOME/.dotnet/tools:$PATH"
