# depends: bat git

bcat() (
  # cat a binary file
  for bin in "$@"; do
    LOCATION=$(whence -p "$bin")
    if [[ -z "$LOCATION" ]]; then
      echo "no such bin: $bin" 1>&2
    else
      bat "$LOCATION"
    fi
  done
)

saved() (
  # my Downloads is a tmpfs
  mv $@ "$HOME/SavedDownloads/"
)

randchars() (
  < /dev/urandom tr -dc 'a-zA-Z0-9' | head -c $1
)

bgr() (
  # run in background, silence everything
  nohup $@ 2>&1 > /dev/null &
)

incognito() {
  # disable history
  unsetopt hist_append
  unsetopt hist_expand
  export HISTFILE=
  export HISTSIZE=0
  export SAVEHIST=0
  export INCOGNITO=1
}

glog() (
  # pretty git log
  LOG="git log --color --graph \
    --pretty=format:'%G? %C(dim)%h%Creset %s %Cgreen(%cr)%C(yellow)%d%C(blue) <%an>%Creset' \
    --abbrev-commit"
  PR1='s/(\*.*\s)('
  PR2=')(\s.*[a-f0-9]{7})/\1\x1b['
  PR3='m\2\x1b[0m\3/g'
  eval $LOG | sed -E \
    -e "${PR1}B${PR2}31${PR3}"   `# B - Bad`               \
    -e "${PR1}G${PR2}1;32${PR3}" `# G - Good`              \
    -e "${PR1}U${PR2}32${PR3}"   `# U - Good, unknown`     \
    -e "${PR1}X${PR2}32${PR3}"   `# X - Good, expired`     \
    -e "${PR1}Y${PR2}33${PR3}"   `# Y - Good, expired key` \
    -e "${PR1}R${PR2}33${PR3}"   `# R - Good, revoked key` \
    -e "${PR1}E${PR2}33${PR3}"   `# E - Missing key`       \
    -e "${PR1}N${PR2}2${PR3}"    `# N - No signature`      \
    | less --quit-if-one-screen -R
)
