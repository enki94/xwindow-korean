#!/bin/bash
set -e

export TZ=Asia/Seoul
export LANG=ko_KR.UTF-8
export LANGUAGE=ko_KR:ko
export LC_ALL=ko_KR.UTF-8

# set username
XWINDOW_USER="${XWINDOW_USER:-user}"
if ! id -u $XWINDOW_USER >/dev/null 2>&1; then
    useradd -m -s /bin/bash $XWINDOW_USER
    echo "user '$XWINDOW_USER' generated."
fi

# set password
if [ -z "$XWINDOW_PASSWORD" ]; then
    XWINDOW_PASSWORD=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
    echo "$XWINDOW_USER's generated password: $XWINDOW_PASSWORD"
fi
echo "$XWINDOW_USER:$XWINDOW_PASSWORD" | chpasswd  
echo "user '$XWINDOW_USER' password set."

# change own and permission
chown $XWINDOW_USER:$XWINDOW_USER /home/$XWINDOW_USER
chmod 700 /home/$XWINDOW_USER   

# add sudo group
usermod -aG sudo $XWINDOW_USER

# remove pid files
[ ! -f /var/run/xrdp/xrdp-sesman.pid ] || rm -f /var/run/xrdp/xrdp-sesman.pid
[ ! -f /var/run/xrdp/xrdp.pid ] || rm -f /var/run/xrdp/xrdp.pid

# check sandbox mode
set +e
SANDBOX_CHECK_OUTPUT=$(unshare -U true 2>&1)
SANDBOX_CHECK_EXIT_CODE=$?
if [ "$SANDBOX_CHECK_EXIT_CODE" -ne 0 ]; then
    sed -i 's|^CHROMIUM_FLAGS=""|CHROMIUM_FLAGS="--no-sandbox --start-maximized --disable-gpu"|' /usr/bin/chromium
    rm -rf /usr/bin/code
    ln -s /usr/share/code/bin/code /usr/bin/code
    sed -i 's|ELECTRON_RUN_AS_NODE=1 "\$ELECTRON" "\$CLI" "\$@"|ELECTRON_RUN_AS_NODE=1 "\$ELECTRON" "\$CLI" --no-sandbox --disable-gpu "\$@"|' /usr/share/code/bin/code
fi
set -e

# run program
/usr/sbin/xrdp-sesman
/usr/sbin/xrdp --nodaemon
