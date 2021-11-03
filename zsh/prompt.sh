# depends: grml-zsh-config

# virtualenv prompt prompt

HOSTNAME=$(</proc/sys/kernel/hostname)

function virtual_env_prompt () {
  REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}

# grml_theme_add_token virtual-env -f virtual_env_prompt '%F{magenta}' '%f'

# show hostname when ssh'd in

function ssh_conn_prompt () {
  REPLY=${SSH_CONNECTION+@${HOSTNAME:t} }
}

grml_theme_add_token ssh-conn -f ssh_conn_prompt '%F{white}' '%f'

zstyle ':prompt:grml:left:setup' items rc ssh-conn virtual-env change-root path percent
zstyle ':prompt:grml:right:setup' use-rprompt false
RPS1=''

function set_title_precmd () {
  set_title ${(%):-"%~"}
}

# Sets the title as name of program currently running
function set_title_preexec () {
  set_title "${(%):-}" "$2"
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook -Uz precmd set_title_precmd
  add-zsh-hook -Uz preexec set_title_preexec
fi
