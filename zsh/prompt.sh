# depends: grml-zsh-config

# virtualenv prompt prompt

HOSTNAME=$(hostname)

function virtual_env_prompt () {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}

# grml_theme_add_token virtual-env -f virtual_env_prompt '%F{magenta}' '%f'

# show hostname when ssh'd in

function ssh_conn_prompt () {
    REPLY=${SSH_CONNECTION+@${HOSTNAME:t} }
}

grml_theme_add_token ssh-conn -f ssh_conn_prompt '%F{white}' '%f'

# change git display

autoload -U colors && colors
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%} "

zstyle ':prompt:grml:left:setup' items rc ssh-conn virtual-env change-root path vcs percent
