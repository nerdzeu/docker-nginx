#!/usr/bin/env bash

set -e

cd /tmp
svn checkout svn://svn.archlinux.org/packages/nginx/trunk nginx
cd nginx

head -n $(expr $(awk '/\.\/configure/ { print FNR }' < PKGBUILD) - 1) PKGBUILD > pknew
cat  << EOF >> pknew
./configure --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/run/nginx.pid \
    --lock-path=/run/nginx.lock \
    --http-client-body-temp-path=/var/lib/nginx/client-body \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
    --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
    --http-scgi-temp-path=/var/lib/nginx/scgi \
    --user=http \
    --group=http \
    --with-http_ssl_module \
    --with-http_perl_module \
    --with-http_spdy_module \
    --with-ipv6
EOF

tail -n $(expr $(wc -l < PKGBUILD) - $(awk '/make$/ { print FNR }' < PKGBUILD) + 1) PKGBUILD >> pknew

mv pknew PKGBUILD

env PKGEXT=".pkg.tar" makepkg
pacman -U --noconfirm *.pkg.tar
cd && rm -rf /tmp/nginx
