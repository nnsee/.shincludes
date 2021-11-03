b64e() {
	[[ -p /dev/stdin ]] && IN="$(</dev/stdin)" || IN="${@}"
	echo -n "${IN}" | base64
}

b64d() (
	[[ -p /dev/stdin ]] && IN="$(</dev/stdin)" || IN="${@}"
	base64 -d <<< "${IN}"
)
