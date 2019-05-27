# SETOPT

# Basics
setopt no_beep			# don't beep on errors
setopt interactivecomments	# allow comments even in interative shells
setopt autoparamslash		# tab completing directory appends a slash
setopt autopushd		# cd automatically old dir onto dir stack 
setopt clobber			# allow clobbering with >, no need to use >!
setopt nonomatch		# unmatched patterns are left unchanged
setopt pushdsilent		# don't print dir stack after pushing/popping

# Changing Directories
setopt autocd			# .. is shortcut for cd .. (etc)
setopt pushdignoredups		# don't push multiple copies of same dir onto stack
setopt cdablevarS		# us arguments for directory

# Expansion and globbing
setopt extendedglob		# treat #, ~, and ^  as part of patterns of filenames

# History
setopt appendhistory		# Allow multiple terminal sessions to append to one history file
setopt extendedhistory		# save timestamp and duration of command
setopt incappendhistory		# Add commands as they are typed. 
setopt histexpiredupsfirst	# trim oldest dups from history first
setopt histignoredups		# filter dups from history
setopt histignorespace		# don't record commands starting with a space
setopt histfindnodups		# when searching history don't display results already cycled through twice
setopt histverify		# confirm history expansion
setopt histreduceblanks		# remove extra blanks from each command line
setopt sharehistory		# share history across shells

# Completion
setopt alwaystoend		# when compeleting move to end of word
setopt automenu			# show completion menu on successive tab presses. needs unsetopt menu_complete to work.
setopt autonamedirs		# any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt completeinword		# Allow completion from within word or phrase
unsetopt menucomplete		# do not autoselect the first menu option

# Correction 
setopt correct			# command auto-correct
setopt correctall		# argument auto-correct

# Prompt
setopt promptsubst		# enable parameter expansion
setopt transientrprompt		# only show right prompt on current prompt

# Script and functions
setopt multios # perform implicit tees or cats when multiple redirections are attempted
