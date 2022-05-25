whence -p nvim > /dev/null && export EDITOR=nvim || true

# don't let golang dump stuff into $HOME
export GOMODCACHE="$HOME/.cache/go-mod"
export GOPATH="$HOME/.go"
export PATH="$PATH:$HOME/.go/bin"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.nimble/bin"

# docker rootless
export PATH=$HOME/bin:$PATH
export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock
