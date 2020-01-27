### my zsh includes

include these by adding the following lines to `.zshrc`:

```
for includefile in $HOME/.shincludes/**/*.sh; do
	. "$includefile"
done
```
