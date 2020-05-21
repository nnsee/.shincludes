# depends: yay

alias i='yay -S'
alias up='yay -Syu'
alias whoowns='yay -Qo'

alias ip='ip -h -c' # adds some colour
alias ipa='ip -br a' # brief IP listing

# depends: highlight
alias ccat='highlight -O truecolor --base16'

saved() {
    # my Downloads is a tmpfs
    for file in $@; do
        mv "$HOME/Downloads/$file" "$HOME/SavedDownloads/$file"
    done
}

alias clear-logs='sudo /bin/sh -c "journalctl --rotate && journalctl --vacuum-time=1s"'
