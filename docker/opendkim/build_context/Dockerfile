FROM archlinux

RUN pacman -Syu --noconfirm && pacman -S --noconfirm opendkim && useradd -s /usr/bin/nologin opendkim

USER opendkim

CMD ["opendkim", "-f"]
