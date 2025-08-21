FIRST_LOGIN_SETUP_FLAG="$HOME/.config/first_login_setup_done"

if [ ! -f "$FIRST_LOGIN_SETUP_FLAG" ]; then
    mkdir -p "$HOME/.config"

    # first login script ------------------------------------------------------------------------
    xdg-settings set default-web-browser chromium.desktop
    # first login script ------------------------------------------------------------------------

    touch "$FIRST_LOGIN_SETUP_FLAG"
fi

# normal start scripts ------------------------------------------------------------------------
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

ibus-daemon -drx
sleep 5
ibus engine hangul
