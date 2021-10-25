bcat() {
    # cat a binary file
    for bin in "$@"; do
        LOCATION=$(/usr/bin/which --skip-functions "$bin" 2>/dev/null)
        if [[ -z "$LOCATION" ]]; then
            echo "no such bin: $bin" 1>&2
        else
            cat "$LOCATION"
        fi
    done
}

saved() {
    # my Downloads is a tmpfs
    for file in $@; do
        mv "$HOME/Downloads/$file" "$HOME/SavedDownloads/$file"
    done
}

bgr() {
    # run in background, silence everything
    nohup $@ 2>&1 > /dev/null &
    disown
}

incognito() {
    # disable history
    unsetopt hist_append
    unsetopt hist_expand
    export HISTFILE=
    export HISTSIZE=0
    export SAVEHIST=0
    export INCOGNITO=1
}