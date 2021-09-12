# Reduce prompt latency by fetching git status asynchronously.
autoload -Uz add-zsh-hook
add-zsh-hook precmd .prompt.git-status.async

.prompt.git-status.async() {
  local fd
  exec {fd}< <( .prompt.git-status.parse )
  zle -Fw "$fd" .prompt.git-status.callback
}

zle -N .prompt.git-status.callback

.prompt.git-status.callback() {
  local fd=$1 REPLY
  {
    zle -F "$fd"  # Unhook this callback.

    [[ $2 == (|hup) ]] ||
        return  # Error occured.

    read -ru $fd
    .prompt.git-status.repaint "$REPLY"
  } always {
    exec {fd}<&-  # Close file descriptor.
  }
}

# Periodically sync git status in prompt.
TMOUT=2  # Update interval in seconds
trap .prompt.git-status.sync ALRM

.prompt.git-status.sync() {
  [[ $CONTEXT == start ]] ||
      return  # Update only on primary prompt.

  if (( SECONDS - _prompt_last_fetch > 120 )); then
    ( git fetch -q &> /dev/null ) &|
    _prompt_last_fetch=$SECONDS
  fi
  .prompt.git-status.repaint "$( .prompt.git-status.parse )"
}

.prompt.git-status.repaint() {
  [[ $1 == $RPS1 ]] &&
      return  # Don't repaint when there's no change.

  RPS1=$1
  zle .reset-prompt
}

.prompt.git-status.parse() {
  local MATCH MBEGIN MEND
  local -a lines

  lines=( ${(f)"$( git -c color.status=always status -sbu 2> /dev/null )"} ) ||
      { print; return } # Not a git repo

  local -aU symbols=( ${(@MSu)lines[2,-1]##[^[:blank:]]##} )
  print -r -- "${${lines[1]/'##'/$symbols}//(#m)$'\C-[['[;[:digit:]]#m/%{${MATCH}%\}}"
}
