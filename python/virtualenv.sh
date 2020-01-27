vn() {
    python3 -m venv "/home/ras/.venv/$@"
}

va() {
    source "/home/ras/.venv/$@/bin/activate"
}

vd() {
    deactivate
}

vl() {
    ls /home/ras/.venv/
}

