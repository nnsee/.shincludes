[ -z ${OS_RELEASE+x} ] && export OS_RELEASE=$(lsb_release -si)

# depends: paru
[ $OS_RELEASE = "Arch" ] && \
    alias i='paru -S' && \
    alias up='paru -Syu' && \
    alias whoowns='paru -Qo' && \
    alias ownswhom='paru -Ql' && \
    alias whatprovides='paru -F'

# depends: paru
[ $OS_RELEASE = "Ubuntu" ] && \
    alias i='sudo apt install' && \
    alias up='sudo apt update && sudo apt -y full-upgrade' && \
    alias whoowns='dpkg -S' && \
    alias ownswhom='dpkg -L' # && \
#    alias whatprovides='' # not implemented on ubuntu yet

alias bthp='bluetoothctl power on; bluetoothctl connect 94:DB:56:6B:E3:8A'

alias weather='curl -s v2.wttr.in/Tallinn | head -n-1'

alias ip='ip -h -c' # adds some colour
alias ipa='ip -br a' # brief IP listing

# depends: highlight
alias ccat='highlight -O truecolor --base16'

# depends: nvim
alias svim='sudo -E nvim'

# depends: exa
alias ls='exa -lh --git'

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


alias clear-logs='sudo /bin/sh -c "journalctl --rotate && journalctl --vacuum-time=1s"'
