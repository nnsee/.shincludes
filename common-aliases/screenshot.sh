# depends: grim slurp imagemagick imv wl-clipboard curl
# optional depends: libnotify

__try_notify() {
    which notify-send || return 0
    notify-send --icon $1 "Image copied to clipboard" \
      "$(basename $1)"
}

local_screenshot_old () {
    local FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
    grim -g "$(slurp)" "$FILENAME"
    wl-copy < "$FILENAME"
}

local_screenshot () {
    # pauses the screen when doing a selection
    # requires the following line in sway config to work properly
    # for_window [title="imv.*/proc/self/fd/0"] fullscreen global
    local FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
    local screenshot="$(grim -c -t ppm /proc/self/fd/1)"
    imv -s none /proc/self/fd/0 <<< $screenshot &
    local imv_pid=$!

    local selection="$(slurp -df '%wx%h+%x+%y')"
    if [ $? -eq 0 ]; then
        convert -crop "${selection}" ppm:- "${FILENAME}" <<< $screenshot
        wl-copy < "${FILENAME}"
        __try_notify "${FILENAME}" 
    fi

    kill -SIGKILL ${imv_pid}
}
