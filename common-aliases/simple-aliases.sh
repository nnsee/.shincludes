# depends: yay
alias i='yay -S'
alias up='yay -Syu'
alias whoowns='yay -Qo'
alias ownswhom='yay -Ql'
alias whatprovides='yay -F'

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
