_auto_bell_send() {
    if [[ ! -v AUTO_BELL_START ]]; then
        return
    fi

    local current="$(date +"%s")"
    let "elapsed = current - AUTO_BELL_START"

    if [[ $elapsed -gt 10 ]]; then
        echo -n $'\a'
    fi

    _auto_bell_reset_tracking
}

_auto_bell_track() {
    AUTO_BELL_START="$(date +"%s")"
}

_auto_bell_reset_tracking() {
    unset AUTO_BELL_START
}

disable_auto_bell() {
    add-zsh-hook -D preexec _auto_bell_track
    add-zsh-hook -D precmd _auto_bell_send
}

enable_auto_bell() {
    autoload -Uz add-zsh-hook
    add-zsh-hook preexec _auto_bell_track
    add-zsh-hook precmd _auto_bell_send
}

_auto_bell_reset_tracking

enable_auto_bell
