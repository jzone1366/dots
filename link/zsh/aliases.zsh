### Aliases

## DIRECTORY SHORTCUTS
alias dotfiles='~/.dotfiles'
alias dev='~/dev'

## DIRECTORY INFORMATION
if [[ $IS_MAC -eq 1 ]]; then
	alias lh='ls -d .*' # show hidden files/directories only
	alias lsd='ls -aFhlG'
	alias l='ls -al'
	alias ls='ls -GFh' # Colorize output, add file type indicator, and put sizes in human readable format
	alias ll='ls -GFhl' # Same as above, but in long listing format
fi
if [[ $IS_LINUX -eq 1 ]]; then
	alias lh='ls -d .* --color' # show hidden files/directories only
	alias lsd='ls -aFhlG --color'
	alias l='ls -al --color'
	alias ls='ls -GFh --color' # colorize output, add file type indicator, and put sizes in human readable format
	alias ll='ls -GFhl --color' # same as above, but in long listing format
fi
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias 'dirdus=du -sckx * | sort -nr' #directories sorted by size
alias 'dus=du -kx | sort -nr | less' #files sorted by size

alias 'wordy=wc -w * | sort | tail -n10' # sort files in current directory by the number of words they contain
alias 'filecount=find . -type f | wc -l' # number of files (not directories)

## these require zsh
alias ltd='ls *(m0)' # files & directories modified in last day
alias lt='ls *(.m0)' # files (no directories) modified in last day
alias lnew='ls *(.om[1,3])' # list three newest

## TMUX STUFF
alias attach="tmux attach -t base || tmux new -s base"
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'
alias tk='tmux kill-session -t'

## GIT
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gpl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gcm='git commit'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'
alias gdb='git diff master..`git rev-parse --abbrev-ref HEAD`'
alias gr='git diff master..'

# MISC
alias sz='source ~/.zshrc'
alias py3='python3'
alias py2='python2'
alias vi='nvim'
