# depends: warpdrive

wd() {
    . $HOME/.local/share/wd/wd.sh
}

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
