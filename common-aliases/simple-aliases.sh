# depends: yay

alias i='yay -S'
alias up='yay -Syu'
alias whoowns='yay -Qo'

alias ip='ip -h -c' # adds some colour

saved() {
    # my Downloads is a tmpfs
    for file in $@; do
        mv "$HOME/Downloads/$file" "$HOME/SavedDownloads/$file"
    done
}
