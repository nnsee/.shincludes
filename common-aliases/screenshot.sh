# depends: grim slurp imagemagick imv wl-clipboard curl

local_screenshot_old () {
    local FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
    grim -g "$(slurp)" "$FILENAME"
    wl-copy < "$FILENAME"
}

local_screenshot () {
    # pauses the screen when doing a selection
    # requires the following line in sway config to work properly
    # for_window [title="imv.*screenshot"] fullscreen global
    local FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
    local screenshot="$(mktemp --suffix screenshot.ppm)"
    grim -c -t ppm "${screenshot}"
    imv -s none "${screenshot}" &
    local imv_pid=$!

    local selection="$(slurp -df '%wx%h+%x+%y')"
    if [ $? -eq 0 ]; then
        convert -crop "${selection}" "${screenshot}" "${FILENAME}"
        wl-copy < "${FILENAME}"
    fi

    kill -SIGKILL ${imv_pid}
    rm "${screenshot}"
}
