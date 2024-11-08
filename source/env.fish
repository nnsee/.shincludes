if set -q SHINCLUDES_ENV_DONE
    return
end

if type -q nvim
    set -x EDITOR "nvim"
end

set -x GOMODCACHE "$HOME/.cache/go-mod"
set -x GOPATH "$HOME/.go"
set -x PATH $PATH "$HOME/.go/bin"

if not set -q SSH_AUTH_SOCK
    set -x SSH_AUTH_SOCK "/var/run/user/1000/gcr/ssh"
end

set -x PATH $PATH "$HOME/.local/bin"
set -x PATH $PATH "$HOME/.cargo/bin"
set -x PATH $PATH "$HOME/.local/share/gem/ruby/3.0.0/bin"
set -x PATH $PATH "$HOME/.npm-packages/bin"

set -x TIMEFMT "cpu %P | usr %*U | sys %*S | tot %*E"
set -x PAGER "cat"

set -x SHINCLUDES_ENV_DONE 1
