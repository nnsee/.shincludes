b64e () {
	echo -n "${@}" | base64
}

b64d () {
	base64 -d <<< "$@"
}

