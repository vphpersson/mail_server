FROM archlinux

RUN pacman -Syu --noconfirm && pacman -S --noconfirm opendmarc

USER operdmarc

CMD ["opendmarc", "-f"]
