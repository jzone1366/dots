#!/usr/bin/env zsh

# Long-running command notifier — cross-platform (macOS + Linux)
# Sends a system notification when a command takes longer than $NOTIFY_THRESHOLD seconds.
# Source this from zshrc to enable it.

NOTIFY_THRESHOLD=${NOTIFY_THRESHOLD:-10}

# Commands to skip notifications for (interactive TUIs where duration is meaningless)
cmdignore=(htop tmux top vim nvim pgcli bat mux tmuxp gc lazygit)

function notifyosd-precmd() {
    local retval=$?
    [[ ${cmdignore[(r)$cmd_basename]} == $cmd_basename ]] && return
    [[ -z "$cmd" ]] && return

    local cmd_end=$(date +%s)
    (( cmd_secs = cmd_end - cmd_start ))

    if (( cmd_secs > NOTIFY_THRESHOLD )); then
        local cmd_time=$(printf '%dh:%dm:%ds' $((cmd_secs/3600)) $((cmd_secs%3600/60)) $((cmd_secs%60)))
        local status_word=$(( retval > 0 )) && echo "failed" || echo "completed"
        local title="$cmd_basename $status_word"
        local body="\"$cmd\" took $cmd_time"
        [[ -n $SSH_TTY ]] && title="$cmd_basename $status_word on $(hostname)"

        if $IS_MAC; then
            osascript -e "display notification \"$body\" with title \"$title\"" 2>/dev/null
        elif $IS_LINUX; then
            local urgency=$(( retval > 0 )) && echo "critical" || echo "normal"
            notify-send -u "$urgency" "$title" "$body" 2>/dev/null
        fi
    fi

    unset cmd
}

function notifyosd-preexec() {
    cmd=$1
    cmd_basename=${${cmd:s/sudo //}[(ws: :)1]}
    cmd_start=$(date +%s)
}

precmd_functions+=( notifyosd-precmd )
preexec_functions+=( notifyosd-preexec )
