[ -z "${ID+x}" ] && source /etc/os-release

# depends: paru
{[ "${ID}" = "arch" ] || [ "${ID_LIKE}" = "arch" ]} && {
    alias i='paru -S'
    alias up='paru -Syu'
    alias whoowns='paru -Qo'
    alias ownswhom='paru -Ql'
    alias whatprovides='paru -F'
}

# depends: apt-file
{[ "${ID}" = "ubuntu" ] || [ "${ID}" = "debian" ]} && {
    alias i='sudo apt install'
    alias up='sudo apt update && sudo apt -y full-upgrade'
    alias whoowns='dpkg -S'
    alias ownswhom='dpkg -L'
    function whatprovides {
        for file in $@; do
            apt-file find -x "/${file}\$"
        done
    }
}

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

alias clear-logs='sudo /bin/sh -c "journalctl --rotate && journalctl --vacuum-time=1s"'
