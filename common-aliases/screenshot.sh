# depends: maim xclip curl

randchars () {
    < /dev/urandom tr -dc 'a-zA-Z0-9' | head -c $1
}

file_exists () {
    curl "$1" -f -s -o /dev/null && \
      return 0 # file exists

    return 1 # file does not exist
}

take_screenshot () { 
    DOMAIN="arse.ee"
    SCREENSHOT=$(maim -u -s 2>/dev/null | cat)

    FILENAME="$(randchars 8).png"
    while file_exists "https://${DOMAIN}/${FILENAME}"; do
        FILENAME="$(randchars 8).png"
    done

    ssh s "dd of=/var/www/${DOMAIN}/${FILENAME}" <<< "$SCREENSHOT"

    echo -n "https://${DOMAIN}/${FILENAME}" | xclip -selection c
}
