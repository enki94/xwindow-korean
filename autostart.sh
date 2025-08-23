#!/bin/bash

FIRST_LOGIN_SETUP_FLAG="$HOME/.config/first_login_setup_done"

if [ ! -f "$FIRST_LOGIN_SETUP_FLAG" ]; then
    mkdir -p "$HOME/.config"

    # first login script ------------------------------------------------------------------------
    xdg-settings set default-web-browser chromium.desktop
    # first login script ------------------------------------------------------------------------

    touch "$FIRST_LOGIN_SETUP_FLAG"
fi

# normal start scripts ------------------------------------------------------------------------
fcitx5 -d
sleep 5
xmodmap -e "keycode 121 = Hangul_Hanja"
xmodmap -e "keycode 122 = Hangul"
xmodmap -e "keycode 123 = Hangul_Hanja"
