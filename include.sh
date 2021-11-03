_SHINCLUDES_PATH="$(dirname $(readlink -f "${(%):-%x}"))"

. ${_SHINCLUDES_PATH}/env.sh

for includefile in ${_SHINCLUDES_PATH}/*/*.sh; do
  . "$includefile"
done

unset _SHINCLUDES_PATH
