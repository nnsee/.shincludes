_SHINCLUDES_PATH="$(dirname $(readlink -f "${(%):-%x}"))"

for includefile in ${_SHINCLUDES_PATH}/source/*; do
  . "$includefile"
done

fpath=( ${_SHINCLUDES_PATH}/autoload{,-private} "${fpath[@]}" )
autoload -Uz ${_SHINCLUDES_PATH}/autoload/*(-.:t)
[ -d "${_SHINCLUDES_PATH}/autoload-private" ] && autoload -Uz ${_SHINCLUDES_PATH}/autoload-private/*(-.:t)

unset _SHINCLUDES_PATH
