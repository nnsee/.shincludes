for includefile in $(dirname $(readlink -f ${(%):-%x}))/*/*.sh; do
	. "$includefile"
done
