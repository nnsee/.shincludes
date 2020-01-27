wgu() {
    sudo wg-quick up "${@}-wg"
}

wgd() {
    sudo wg-quick down "${@}-wg"
}