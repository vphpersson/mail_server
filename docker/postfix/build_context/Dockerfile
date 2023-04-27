FROM archlinux

ARG POSTFIX_VERSION

RUN pacman -Syu --noconfirm && pacman -S --noconfirm db curl openssl sed base-devel libnsl && mkdir /postfix

WORKDIR /postfix

RUN curl "https://ftpmirror1.infania.net/mirror/postfix-release/official/postfix-${POSTFIX_VERSION}.tar.gz" \
    | tar --gunzip --extract --strip-components=1 \
    && sed --in-place \
        --expression='185s!^!//!' \
        --expression='186s/^.\+$/msg_info("[%s]:%s < %s: %s", state->dest_addr, state->dest_port, state->namaddr, STR(state->buffer));/' \
        --expression='248s!^!//!' \
        --expression='249s/^.\+$/msg_info("[%s]:%s > %s: %s", state->dest_addr, state->dest_port, state->namaddr, cp);/' \
        /postfix/src/smtpd/smtpd_chat.c \
    && make makefiles  \
        command_directory=/usr/bin \
        daemon_directory=/usr/lib/postfix/bin \
        manpage_directory=/usr/share/man \
        readme_directory=/usr/share/doc/postfix \
        sendmail_path=/usr/bin/sendmail \
        shlib_directory= \
        CCARGS="-DUSE_SASL_AUTH -DDEF_SERVER_SASL_TYPE=\\\"dovecot\\\" -DUSE_TLS" \
        AUXLIBS="-lssl -lcrypto" \
    && make \
    && useradd -s /usr/bin/nologin postfix  \
    && groupadd postdrop \
    && chmod +x ./postfix-install \
    && ./postfix-install -non-interactive

USER postfix

COPY ./docker-entrypoint.sh .

ENTRYPOINT [ "./docker-entrypoint.sh" ]
