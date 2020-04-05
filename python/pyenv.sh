# depends: pyenv
# install note: "curl https://pyenv.run | bash"
export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

pyenv-init() {
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
}
