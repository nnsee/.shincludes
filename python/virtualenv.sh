# depends: python3

vn() {
    python3 -m venv "$HOME/.venv/$@"
}

va() {
    source "$HOME/.venv/$@/bin/activate"
}

vd() {
    deactivate
}

vl() {
    ls "$HOME/.venv/"
}
