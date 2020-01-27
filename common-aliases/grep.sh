# "grep here"

gh() {
    grep -rn . -ie "$@" --color=always | sed 's/:/\n/2'
}
