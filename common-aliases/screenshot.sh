# depends: grim slurp imagemagick imv wl-clipboard curl ffmpeg wf-recorder
# optional depends: libnotify

__try_notify() (
  whence -p notify-send > /dev/null || return 0
  notify-send --icon "$1" "Image copied to clipboard" \
    "$(basename $1)"
)

__try_notify_fail() (
  whence -p notify-send > /dev/null || return 0
  notify-send "Failed to take screenshot" \
    "Error code: $1"
)

__try_notify_rec() (
  whence -p notify-send > /dev/null || return 0
  ICON=$(mktemp --suffix .png)
  ffmpeg -y -i "$1" -vframes 1 -f image2 "${ICON}"
  notify-send --icon "${ICON}" "Recording copied to clipboard" \
    "$(basename $1)"
  rm "${ICON}"
)

__try_notify_fail_rec() (
  whence -p notify-send > /dev/null || return 0
  notify-send "Failed to take recording" \
    "Error code: $1"
)

__slurp_windows() (
  WINDOWS=$(swaymsg -t get_tree | \
    jq -r '.. | select(.pid? and .visible?) | .rect |
    "\(.x),\(.y) \(.width)x\(.height)"' | \
    slurp $@)
  RET=$?
  if [ $RET -eq 0 ]; then
    echo -n "$WINDOWS"
  fi
  return $RET
)

local_screenshot_old() (
  FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
  grim -g "$(slurp)" "$FILENAME"
  wl-copy < "$FILENAME"
)

local_screenshot() (
  # pauses the screen when doing a selection
  # requires the following line in sway config to work properly
  # for_window [title="imv.*/proc/self/fd/0"] fullscreen global
  FILENAME=/home/xx/Pictures/ss/$(date '+%F-%H-%M-%S').png
  screenshot="$(grim -c -t ppm /proc/self/fd/1)"
  imv -s none /proc/self/fd/0 <<< $screenshot &
  imv_pid=$!

  selection="$(__slurp_windows -df '%wx%h+%x+%y')"
  errcode=$?
  if [ $errcode -eq 0 ]; then
    convert -crop "${selection}" ppm:- "${FILENAME}" <<< $screenshot
    wl-copy < "${FILENAME}"
    __try_notify "${FILENAME}"
  else
    __try_notify_fail "${errcode}"
  fi

  kill -SIGKILL ${imv_pid}
)

local_screenrecord() (
  RUNPID=$(pidof wf-recorder)
  if [ ! -z "${RUNPID}" ]; then
    kill -s SIGINT $RUNPID
    return
  fi

  selection="$(__slurp_windows)"
  errcode=$?
  if [ $errcode -eq 0 ]; then
    FILENAME=/home/xx/Videos/rec/$(date '+%F-%H-%M-%S').mp4
    wf-recorder -g "${selection}" -f "${FILENAME}"
    wl-copy < "${FILENAME}"
    __try_notify_rec "${FILENAME}"
  else
    __try_notify_fail_rec "${errcode}"
  fi
)
