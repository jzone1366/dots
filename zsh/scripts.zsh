#!/usr/bin/env zsh

# +----------------------+
# | Linux-only functions |
# +----------------------+

if $IS_LINUX; then

screenres() {
    [ -n "$1" ] && xrandr --current | grep '*' | awk '{print $1}' | sed -n "${1}p"
}

screencast() {
    T="$(date +%d-%m-%Y-%H-%M-%S)".mkv
    if [ $# -gt 0 ]; then
        if echo $1 | grep '\....$' > /dev/null; then
            T=$1
        else
            T=$1.mkv
        fi
    fi

    # To list cams: v4l2-ctl --list-devices
    # Record screen 2 by default
    local screen=2
    local offset=""
    local heights=(`screenres 1 | awk -Fx '{print $2}'` `screenres 2 | awk -Fx '{print $2}'`)
    local bigger_height=$(echo $heights | tr ' ' '\n' | sort -rg | head -n 1)

    [ $screen -eq 1 ] && offset="+0,$(( $bigger_height - $(screenres 1 | awk -Fx '{print $2}') ))"
    ffmpeg -f x11grab -framerate 60 -s $(screenres $screen) -i :0.0$offset \
        -f v4l2 -framerate 30 -video_size 640x480 -i /dev/video2 \
        -f pulse -sample_rate 44100 -i default \
        -filter_complex "overlay=main_w-overlay_w-2:main_h-overlay_h-2" \
        -c:v libx264 -preset ultrafast -crf 18 -c:a aac -b:a 320k $T
}

oscreencast() {
    if [ -n "$1" ]; then
        ffmpeg -f x11grab -s $(xdpyinfo | grep dimensions | awk '{print $2}') -i :0.0 $1
    else
        echo "You need to precise an output file as first argument - eg 'example.mkv'"
    fi
}

fi # IS_LINUX

vidvolup() {
    local output="${3:-output.mkv}"
    if [ -n "$1" ] && [ -n "$2" ]; then
        local factor=$(echo "scale=4; 1 + $2/100" | bc)
        ffmpeg -i "$1" -filter:a "volume=$factor" -vcodec copy "$output"
    else
        echo "Usage: vidvolup <input> <percent_increase> [output] - eg 'vidvolup video.mkv 100' to double the volume"
    fi
}

updatesys() {
    sh $DOTFILES/update.sh
}

extract() {
    local file
    for file in "$@"; do
        if [[ ! -f "$file" ]]; then
            echo "'$file' is not a valid file"
            continue
        fi
        case "$file" in
            *.tar.bz2) tar xjf "$file"   ;;
            *.tar.gz)  tar xzf "$file"   ;;
            *.bz2)     bunzip2 "$file"   ;;
            *.gz)      gunzip "$file"    ;;
            *.tar)     tar xf "$file"    ;;
            *.tbz2)    tar xjf "$file"   ;;
            *.tgz)     tar xzf "$file"   ;;
            *.zip)     unzip "$file"     ;;
            *.7z)      7z x "$file"      ;;
            *.rar)     7z x "$file"      ;;
            *.iso)     7z x "$file"      ;;
            *.Z)       uncompress "$file" ;;
            *)         echo "'$file' cannot be extracted" ;;
        esac
    done
}

mkextract() {
    local file
    for file in "$@"; do
        if [[ ! -f "$file" ]]; then
            echo "'$file' is not a valid file"
            continue
        fi
        local filename=${file%\.*}
        mkdir -p "$filename"
        cp "$file" "$filename"
        cd "$filename"
        extract "$file"
        rm -f "$file"
        cd -
    done
}

compress() {
    local DATE="$(date +%Y%m%d-%H%M%S)"
    tar cvzf "$DATE.tar.gz" "$@"
}

screenshot() {
    local DIR="${SCREENSHOT:-$HOME/Pictures/Screenshots}"
    local NAME="${DIR}/screenshot-$(date +%Y%m%d-%H%M%S).png"
    mkdir -p "$DIR"

    if $IS_MAC; then
        case "$1" in
            win)  screencapture -W "$NAME" ;;
            scr)  screencapture "$NAME" ;;
            area) screencapture -i "$NAME" ;;
            *)    echo "Usage: screenshot [win|scr|area]" ;;
        esac
    elif $IS_LINUX; then
        if [ $# = 0 ]; then
            echo "No screenshot area has been specified. Please choose between: win, scr, area."
            return 1
        fi
        [ "$1" = "win" ]  && import -format png -quality 100 "${NAME}"
        [ "$1" = "scr" ]  && import -format png -quality 100 -window root "${NAME}"
        [ "$1" = "area" ] && import -format png -quality 100 "${NAME}"
        [[ $1 =~ "^[0-9].*x[0-9].*$" ]] && import -format png -quality 100 -resize $1 "${NAME}"
        [[ $1 =~ "^[0-9]+$" ]]           && import -format png -quality 100 -resize $1 "${NAME}"
    fi
}

imgsize() {
    local width=$(identify -format "%w" "$1")
    local height=$(identify -format "%h" "$1")
    echo "Size of $1: ${width}x${height}"
}

# Resize an image. Pass --inplace as $3 to overwrite the original.
imgresize() {
    local filename="${1%\.*}"
    local extension="${1##*.}"
    local finalName="${filename}_${2}.${extension}"
    [[ "$3" == "--inplace" ]] && finalName="$filename.$extension"
    convert "$1" -quality 100 -resize "$2" "$finalName"
    echo "$finalName resized to $2"
}

# Resize all images of a given extension in the current directory.
imgresizeall() {
    local ext="$1" size="$2"
    for f in *."$ext"; do
        imgresize "$f" "$size"
    done
}

# Optimize an image. Pass --inplace as $2 to overwrite the original.
imgoptimize() {
    local filename="${1%\.*}"
    local extension="${1##*.}"
    local finalName="${filename}_optimized.${extension}"
    [[ "$2" == "--inplace" ]] && finalName="$1"
    convert "$1" -strip -interlace Plane -quality 85% "$finalName"
    echo "$finalName created"
}

# Optimize all images of a given extension in the current directory.
imgoptimizeall() {
    local ext="$1"
    local inplace="${2:-}"
    for f in *."$ext"; do
        imgoptimize "$f" "$inplace"
    done
}

imgtojpg() {
    local file
    for file in "$@"; do
        local filename="${file%\.*}"
        convert -quality 100 "$file" "${filename}.jpg"
    done
}

imgtowebp() {
    local file
    for file in "$@"; do
        local filename="${file%\.*}"
        cwebp -q 100 "$file" -o "$(basename "$filename").webp"
    done
}

gtrm() {
    git tag -d $1

    if [ ! -z "$2" ]; then
        git push $2 :refs/tags/$1
    else
        git push origin :refs/tags/$1
    fi
}

ssh-create() {
    if [ ! -z "$1" ]; then
        ssh-keygen -f $HOME/.ssh/$1 -t rsa -N '' -C "$1"
        chmod 700 $HOME/.ssh/$1*
    fi
}

dback () {
    if [ ! -z $1 ] && [ ! -z $2 ]; then
        if [ ! -z $3 ]; then
            BS=$3
        else
            BS="512k"
        fi

        dialog --defaultno --title "Are you sure?" --yesno "This will copy $1 to $2 (bitsize: $BS). Everything on $2 will be deleted.\n\n
        Are you sure?"  15 60 || exit

        (sudo pv -n $1 | sudo dd of=$2 bs=$BS conv=notrunc,noerror) 2>&1 | dialog --gauge "Backup from disk $1 to disk $2... please wait" 10 70 0
    else
        echo "You need to provide an input disk as first argument (i.e /dev/sda) and an output disk as second argument (i.e /dev/sdb)"
    fi
}

blimg() {
    if [ ! -z $1 ] && [ ! -z $2 ] && [ ! -z $3 ]; then
        local CYEAR=$(date +'%Y')
        local BASEDIR="${HOME}/workspace/webtechno/static"
        #Basedir current year
        local BASEDIRY="${HOME}/workspace/webtechno/static/${CYEAR}"

        if [ ! -d $BASEDIRY ]; then
            mkdir $BASEDIRY
        fi

        #basedir current article
        local BASEDIRC="${BASEDIRY}/${2}"

        if [ ! -d $BASEDIRP ]; then
            mkdir $BASEDIRP
        fi

        local IMGRESIZED=imgresize "${1} 780"
        echo "$IMGRESIZED"
    fi
}

postgdump() {
    local USER="postgres"
    local HOST="localhost"
    if [ ! -z $1 ]; then
        if [ -f "${1}.sql" ]; then
            rm -i "${1}.sql"
        fi

        if [ $# = 1 ]; then
            pg_dump -c -U $USER -h $HOST $1 | pv --progress > "${1}.sql"
            echo $1
        fi

        if [ $# = 2 ]; then
            pg_dump -c -U $2 -h $HOST $1 | pv --progress > "${1}.sql"
            echo $1
        fi

        if [ $# = 3 ]; then
            pg_dump -c -U $2 -h $3 $1 | pv --progress > "${1}.sql"
            echo $1
        fi
    fi

    if [ $# = 0 ]; then
        echo "You need at least to provide the database name"
    fi
}

postgimport() {
    local USER="postgres"
    local HOST="localhost"
    if [ ! -z $1 ]; then
        DB=${1%\.*}
        # sed -i "1s/^/CREATE DATABASE $DB;\n/" $1
        if [ $# = 1 ];
        then
            pv --progress ${1} | psql -U $USER -h $HOST $1 -d $DB
            echo $1
        fi

        if [ $# = 2 ]; then
            pv --progress ${1} | psql -U $1 -h $HOST $1 -d $DB
            echo $1
        fi

        if [ $# = 3 ]; then
            pv --progress ${1} | psql -U $1 -h $2 $1 -d $DB
            echo $1
        fi
    fi

    if [ $# = 0 ]; then
        echo "You need at least to provide the database name"
    fi
}

matrix () {
    local lines=$(tput lines)
    cols=$(tput cols)

    awkscript='
    {
        letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
        lines=$1
        random_col=$3
        c=$4
        letter=substr(letters,c,1)
        cols[random_col]=0;
        for (col in cols) {
            line=cols[col];
            cols[col]=cols[col]+1;
            printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
            printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
            if (cols[col] >= lines) {
                cols[col]=0;
            }
    }
}
'

echo -e "\e[1;40m"
clear

while :; do
    echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
    sleep 0.05
done | awk "$awkscript"
}

pgdump() {
    pg_dump -U postgres -h localhost x_loc_0bdf08de > pulsecheck_service_test.sql
}

githeat() {
    $DOTFILES/bash/scripts/heatmap.sh
}

colorblocks() {
    $DOTFILES/bash/scripts/colorblocks.sh
}

colorcards() {
    $DOTFILES/bash/scripts/colorcards.sh
}

colors() {
    $DOTFILES/bash/scripts/colors.sh
}

pipes() {
    $DOTFILES/bash/scripts/pipes.sh
}

smedia() {
    $DOTFILES/bash/scripts/smedia.sh $@
}

mkcd() {
    mkdir -p "$@" && cd "$_"
}

mkcp() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
        mkdir -p "$dir" &&
        cp -r "$@"
}

mkmv() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
        mkdir -p "$dir" &&
        mv "$@"
    }

historystat() {
    history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head
}

promptspeed() {
    for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
}

ports() {
    sudo netstat -tulpn | grep LISTEN | fzf;
}

if $IS_LINUX; then

mnt() {
    local FILE="${2:-/mnt/external}"
    if [ -n "$1" ]; then
        sudo mount "$1" "$FILE" -o rw
        echo "Device in read/write mounted in $FILE"
    else
        echo "You need to provide the device (/dev/sd*) - use lsblk"
    fi
}

umnt() {
    local DIRECTORY="${1:-/mnt}"
    local MOUNTED=$(grep "$DIRECTORY" /proc/mounts | cut -f2 -d" " | sort -r)
    cd "/mnt"
    sudo umount $MOUNTED
    echo "$MOUNTED unmounted"
}

mntmtp() {
    local DIRECTORY="${2:-$HOME/mnt}"
    mkdir -p "$DIRECTORY"
    if [ -n "$1" ]; then
        simple-mtpfs --device "$1" "$DIRECTORY"
        echo "MTPFS device in read/write mounted in $DIRECTORY"
    else
        echo "You need to provide the device number - use simple-mtpfs -l"
    fi
}

umntmtp() {
    local DIRECTORY="${1:-$HOME/mnt}"
    cd "$HOME"
    umount "$DIRECTORY"
    echo "$DIRECTORY with mtp filesystem unmounted"
}

fi # IS_LINUX

# Silly little script to understand zstyle
names() {
    local user_name user_surname user_nickname computer_name

    zstyle -s ':name:' set_user_name user_name || user_name="LEELA"
    zstyle -s ':name:surname:' set_user_name user_surname || user_surname="TURANGA"
    zstyle -s ':name:nickname::' set_user_name user_nickname || user_nickname="CYCLOPE"
    zstyle -s ':name:' set_computer_name computer_name || computer_name="BENDER"

    echo "You're $user_name $user_surname $user_nickname and you're computer is called $computer_name"
}

# --restrict-filenames replace special characters like spaces in filenames.
ydlp() {
    if [ -n "$1" ]; then
        yt-dlp --restrict-filenames -f 22 -o "%(autonumber)s-%(title)s.%(ext)s" "$1"
    else
        echo "You need to specify a playlist url as argument"
    fi
}

ydl() {
    if [ -n "$1" ]; then
        yt-dlp --restrict-filenames -f 22 -o "%(title)s.%(ext)s" "$1"
    else
        echo "You need to specify a video url as argument"
    fi
}

initKondo() {
    mkdir .clj-kondo
    clj-kondo --lint "$(boot with-cp -w -f -)"
}

vinfo() {
    vim -c "Vinfo $1" -c 'silent only'
}

zshcomp() {
    for command completion in ${(kv)_comps:#-*(-|-,*)}
    do
        printf "%-32s %s\n" $command $completion
    done | sort
}

wav2flac() {
    for file in "$@"; do
        local filename=${file%\.*}
        local extension="${file##*.}"
        ffmpeg -i "$filename.wav" -af aformat=s32:176000 "$filename.flac"
    done
}

rmwav2flac() {
    for file in "$@"; do
        local filename=${file%\.*}
        local extension="${file##*.}"
        ffmpeg -i "$filename.wav" -af aformat=s32:176000 "$filename.flac"
        rm -f $file
    done
}

# Count number
blogwc() {
    DATE=$(date +"%Y")
    if [ ! -z $1 ]; then
        DATE=$1
    fi
    cd ~/workspace/webtechno/content/post && grep -l "date = \"$DATE" *.md | xargs wc && cd -
}

cheat() {
    curl cheat.sh/$1
}

duckduckgo() {
    if $IS_MAC; then
        open "https://duckduckgo.com/?q=$*"
    else
        xdg-open "https://duckduckgo.com/?q=$*"
    fi
}

wikipedia() {
    if $IS_MAC; then
        open "https://en.wikipedia.org/wiki?search=$*"
    else
        xdg-open "https://en.wikipedia.org/wiki?search=$*"
    fi
}

back() {
    for file in "$@"; do
        cp "$file" "$file".bak
    done
}

calcul() {
    bc -l <<< "$@"
}

tiny() {
    local URL=${1:?}
    curl -s "http://tinyurl.com/api-create.php?url=$1"
}

serve() {
    local -r PORT=${1:-8888}
    python3 -m http.server "$PORT"
}

backup() {
    "$DOTFILES/bash/scripts/backup/backup.sh" "$@" "$CLOUD/dotfiles/dir.csv"
}

kubecfg() {
    . "$CLOUD/development/dotfiles_projects/amboss/kubecfg.sh"
}

scratchpad() {
    "$DOTFILES/bash/scripts/scratchpad.sh" "$@"
}

git-jump() {
    "$DOTFILES/bash/scripts/git-jump.sh" "$@"
}

pom() {
    local -r HOURS=${1:?}
    local -r MINUTES=${2:-0}
    local -r POMODORO_DURATION=${3:-25}

    bc <<< "(($HOURS * 60) + $MINUTES) / $POMODORO_DURATION"
}

