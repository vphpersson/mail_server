#!/usr/bin/env bash

REGEX='^.+ postfix(/submission)?/smtpd\[[0-9]+\]: \[([^]]*)\]:([0-9]+) [<>] [^[]+\[([^]]+)\]:([0-9]+): (.+)$'

if [[ -z "$POSTFIX_HOSTNAME" ]]; then
    echo 'The environment variable POSTFIX_HOSTNAME must be set.' 1>&2
    exit 1
fi

cp /etc/postfix/main_host.cf /etc/postfix/main.cf

newaliases
postconf -e "myhostname = ${POSTFIX_HOSTNAME}"

postfix start-fg | tee /dev/stderr | while IFS= read line; do
    if [[ $line =~ $REGEX ]]; then
        server_address="${BASH_REMATCH[2]}"
        server_port="${BASH_REMATCH[3]}"
        client_address="${BASH_REMATCH[4]}"
        client_port="${BASH_REMATCH[5]}"

        message="${BASH_REMATCH[6]}"

        if [[ $server_address == '127.0.0.1' ]] || [[ $server_address = '127.0.0.1' ]]; then
            continue
        fi

        umask 0000

        printf '%s\n' "$message" >> "/transcript_volume/${server_address}_${server_port}_${client_address}_${client_port}"
    fi
done
