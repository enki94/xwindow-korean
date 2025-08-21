#!/bin/bash
set -e

export TZ=Asia/Seoul
export LANG=ko_KR.UTF-8
export LANGUAGE=ko_KR:ko
export LC_ALL=ko_KR.UTF-8

# set username
X11_USER="${X11_USER:-user}"
if ! id -u $X11_USER >/dev/null 2>&1; then
    useradd -m -s /bin/bash $X11_USER
    echo "user '$X11_USER' generated."
fi

# set password
if [ -z "$X11_PASSWORD" ]; then
    X11_PASSWORD=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
    echo "$X11_USER's generated password: $X11_PASSWORD"
fi
echo "$X11_USER:$X11_PASSWORD" | chpasswd  
echo "user '$X11_USER' password set."

# add sudo group
usermod -aG sudo $X11_USER

# remove pid files
[ ! -f /var/run/xrdp/xrdp-sesman.pid ] || rm -f /var/run/xrdp/xrdp-sesman.pid
[ ! -f /var/run/xrdp/xrdp.pid ] || rm -f /var/run/xrdp/xrdp.pid

# run program
/usr/sbin/xrdp-sesman
/usr/sbin/xrdp --nodaemon
