# depends: jq

urle() (
  [[ -p /dev/stdin ]] && IN="$(</dev/stdin)" || IN="${@}"
  echo -n "${IN}" | jq -sRr @uri
)

urle_all() (
  [[ -p /dev/stdin ]] && IN="$(</dev/stdin)" || IN="${@}"
  echo -n "${IN}" | xxd -p | sed 's/../%&/g'
)

urld() (
  [[ -p /dev/stdin ]] && IN="$(</dev/stdin)" || IN="${@}"
  echo -ne "$(echo -n ${IN} | sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
)
