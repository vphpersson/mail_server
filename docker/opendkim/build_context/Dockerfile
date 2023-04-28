FROM archlinux

RUN pacman -Syu --noconfirm && pacman -S --noconfirm opendkim

USER opendkim

CMD ["opendkim", "-f", "-x", "/etc/opendkim/opendkim.conf"]
