FROM base/archlinux
MAINTAINER Paolo Galeone <nessuno@nerdz.eu>

RUN sed -i -e 's#https://mirrors\.kernel\.org#http://mirror.clibre.uqam.ca#g' /etc/pacman.d/mirrorlist && \
       pacman -Sy haveged archlinux-keyring --noconfirm && haveged -w 1024 -v 1 && \
       pacman-key --init && pacman-key --populate archlinux
RUN pacman -Sy sudo base-devel nginx subversion libunistring --noconfirm
RUN pacman-db-upgrade
RUN pacman -S hardening-wrapper  --noconfirm

COPY builder /opt/
RUN bash /opt/builder

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
