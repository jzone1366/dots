# Special Folders
abbr dotfiles 'cd ~/.dotfiles'
abbr dev 'cd ~/dev'

# Git
abbr g 'git'
abbr ga. 'git add .'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbd 'git branch -D'
abbr gcm 'git commit'
abbr gcm!!! 'git add .; and git commit -m "Update"; and git push'
abbr gc 'git checkout'
abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gcod 'git checkout develop'
abbr gi 'gitignore'
abbr gl 'git log'
abbr gm 'git merge'
abbr gpl "git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
abbr gps 'git push'
abbr gp 'git push'
abbr gpsu 'git push -u origin master'
abbr gs 'git status'
abbr gcl 'git clone'
abbr gd 'git diff'
abbr gra 'git remote add'
abbr grr 'git remote rm'
abbr gpu 'git pull'
abbr gta 'git tag -a -m'
abbr gf 'git reflog'
abbr gv 'git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'
abbr gdb 'git diff master..`git rev-parse --abbrev-ref HEAD`'
abbr gr 'git diff master..'
abbr gd 'git diff'

# TMUX
abbr attach "tmux attach -t base || tmux new -s base"
abbr ta 'tmux attach -t'
abbr tn 'tmux new -s'
abbr tls 'tmux ls'
abbr tk 'tmux kill-session -t'

# MISC
abbr py3 'python3'
abbr py2 'python2'
abbr nerdfetch 'curl -fsSL https://raw.githubusercontent.com/ThatOneCalculator/NerdFetch/master/nerdfetch | sh'

# SSH
abbr ssh 'TERM=xterm ssh'

abbr yw 'yarn workspace'
