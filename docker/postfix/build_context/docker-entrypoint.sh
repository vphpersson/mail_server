#!/usr/bin/env bash

for postfix_user in ${POSTFIX_USERS}; do
    useradd --shell /usr/bin/nologin "$postfix_user"
done

regex='^.+ postfix/smtpd\[[0-9]+\]: \[([^]]+)\]:[0-9]+ [<>] [^[]+\[([^]]+)\]:([0-9]+): (.+)$'

postalias /etc/postfix/aliases
new aliases
postfix reload

postfix start-fg | tee /dev/stderr | while IFS= read line; do
    if [[ $line =~ $regex ]]; then
        dest_addr="${BASH_REMATCH[1]}"
        client_addr="${BASH_REMATCH[2]}"
        client_port="${BASH_REMATCH[3]}"

        message="${BASH_REMATCH[4]}"

        if [[ $dest_addr == '127.0.0.1' ]] || [[ $client_addr = '127.0.0.1' ]]; then
            continue
        fi

        printf '%s\n' "$message" >> "${client_addr}_${client_port}"
    fi
done
