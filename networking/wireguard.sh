# depends: wireguard-tools

wgu() {
    for interface in "$@"; do
        sudo wg-quick up "${interface}-wg"
    done
}

wgd() {
    if [[ -z "${@}" ]]; then
        # bring all down
        for interface in $(wg show interfaces); do
            sudo wg-quick down $interface
        done
        return
    fi

    for interface in "$@"; do
        sudo wg-quick down "${interface}-wg"
    done
}