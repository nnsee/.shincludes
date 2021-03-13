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

mpva() {
    # mpv with basic auth
    if [[ -z "$AHEADER" ]]; then
	echo -n "Password: "
	stty -echo
	read -n password
	stty echo
	# yes, I know this isn't secure
	AHEADER="Authorization: Basic $(b64e "xx:${password}")"
	unset password
    fi

    mpv $@ --http-header-fields="$AHEADER"

    RET=$?
    [[ $RET = 2 ]] && unset AHEADER

    return $RET
}
