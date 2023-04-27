FROM archlinux

RUN pacman -Syu --noconfirm && pacman -S --noconfirm amavisd-new

USER amavis

EXPOSE 10024
EXPOSE 10026

CMD ["amavisd", "foreground"]
