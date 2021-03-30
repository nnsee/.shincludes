[ -z ${ID+x} ] && source /etc/os-release

[ ${ID} = "arch" ] && \
	PATHS=(
		"/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
		"/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
		"/usr/share/fzf/completion.zsh"
		"/usr/share/fzf/key-bindings.zsh"
	)

[ ${ID} = "ubuntu" ] && \
	PATHS=(
		"/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
		"/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
		"/usr/share/doc/fzf/examples/completion.zsh"
		"/usr/share/doc/fzf/examples/key-bindings.zsh"
	)

for file in "${PATHS[@]}"; do
	[ -f "$file" ] && source "$file"
done

