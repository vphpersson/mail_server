#!/usr/bin/env bash

REGEX='^.+ postfix/smtpd\[[0-9]+\]: \[([^]]+)\]:[0-9]+ [<>] [^[]+\[([^]]+)\]:([0-9]+): (.+)$'

if [[ -z "$POSTFIX_HOSTNAME" ]]; then
  echo 'The environment variable POSTFIX_HOSTNAME must be set.' 1>&2
  exit 1
fi

cp /etc/postfix/main_host.cf /etc/postfix/main.cf

newaliases
postconf -e "myhostname = ${POSTFIX_HOSTNAME}"

postfix start-fg | tee /dev/stderr | while IFS= read line; do
    if [[ $line =~ $REGEX ]]; then
        dest_addr="${BASH_REMATCH[1]}"
        client_addr="${BASH_REMATCH[2]}"
        client_port="${BASH_REMATCH[3]}"

        message="${BASH_REMATCH[4]}"

        if [[ $dest_addr == '127.0.0.1' ]] || [[ $client_addr = '127.0.0.1' ]]; then
            continue
        fi

        umask 0000

        printf '%s\n' "$message" >> "/transcript_volume/${client_addr}_${client_port}"
    fi
done
