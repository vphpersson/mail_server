FROM archlinux

RUN pacman -Syu --noconfirm && pacman -S --noconfirm opendmarc

USER opendmarc

CMD ["opendmarc", "-f", "-c", "/etc/opendmarc/opendmarc.conf"]
