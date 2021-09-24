# depends: maim wl-clipboard curl
# optional dep: libnotify

randchars () {
    < /dev/urandom tr -dc 'a-zA-Z0-9' | head -c $1
}

file_exists () {
    curl "$1" -f -s -o /dev/null && \
      return 0 # file exists

    return 1 # file does not exist
}

take_screenshot () {
    DOMAIN="arse.ee"
#   SCREENSHOT=$(maim -u -s /proc/self/fd/1 2> /dev/null)
    SCREENSHOT=$(grim -g "$(slurp)" /proc/self/fd/1 2>/dev/null)

    [ $? -eq 0 ] || return 1 # screenshot failed

    FILENAME="$(randchars 8).png"
    URL="${DOMAIN}/${FILENAME}"
    while file_exists "https://${URL}"; do
        FILENAME="$(randchars 8).png"
    done

    ssh s "dd of=/var/www/${URL}" <<< "$SCREENSHOT"
    RETCODE=$?

    echo -n "https://${URL}" | wl-copy

    [ -z "$(which notify-send)" ] && return $RETCODE

    if [ 0 -eq $RETCODE ]; then
        MSG="Image uploaded"
	LINK="<a href='https://${URL}'>https://${URL}</a>"
    else
        MSG="Image upload failed"
	LINK=""
    fi

    notify-send -t 5000 "$MSG" "$LINK"
    return $RETCODE
}

local_screenshot_old () {
    FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
    grim -g "$(slurp)" "$FILENAME"
    wl-copy < "$FILENAME"
}

local_screenshot () {
    # pauses the screen when doing a selection
    # requires the following line in sway config to work properly
    # for_window [title="imv.*screenshot"] fullscreen global
    # also requires a patched sway due to a bug in cursor detection
    # see: https://github.com/swaywm/sway/pull/6545
    FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
    screenshot="$(mktemp --suffix screenshot.ppm)"
    grim -c -t ppm "${screenshot}"
    imv -s none "${screenshot}" &
    imv_pid=$!

    selection="$(slurp -df '%wx%h+%x+%y')"
    if [ $? -eq 0 ]; then
        convert -crop "${selection}" "${screenshot}" "${FILENAME}"
        wl-copy < "${FILENAME}"
    fi

    kill -SIGKILL ${imv_pid}
    rm "${screenshot}"
}
