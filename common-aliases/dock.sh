# depends: dockd feh

# alias dock="sudo dockd --set docked; ~/.fehbg"
dock() {
    sudo dockd --set docked
    $HOME/.fehbg
}

# alias undock="sudo dockd --set undocked; ~/.fehbg"
undock() {
    sudo dockd --set undocked
    $HOME/.fehbg
}