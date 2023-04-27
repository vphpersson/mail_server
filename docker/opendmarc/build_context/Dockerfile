FROM archlinux

RUN pacman -Syu --noconfirm && pacman -S --noconfirm opendmarc && useradd -s /usr/bin/nologin opendmarc

USER operdmarc

CMD ["opendmarc", "-f"]
