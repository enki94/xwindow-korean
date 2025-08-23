#!/bin/bash

FIRST_LOGIN_SETUP_FLAG="$HOME/.config/first_login_setup_done"

if [ ! -f "$FIRST_LOGIN_SETUP_FLAG" ]; then
    mkdir -p "$HOME/.config"

    # first login script ------------------------------------------------------------------------
    
    # 디폴트 브라우져 설정
    xdg-settings set default-web-browser chromium.desktop
    
    # Desktop/*.desktop 반복 처리
    for FILE in ~/Desktop/*.desktop; do
        # 1. 실행 권한 부여
        chmod +x "$FILE"
    
        # 2. XFCE 체크섬 설정
        if command -v gio >/dev/null 2>&1; then
            SHA256=$(sha256sum "$FILE" | awk '{print $1}')
            gio set "$FILE" metadata::xfce-exe-checksum "$SHA256"
        fi
    done
    
    # first login script ------------------------------------------------------------------------

    touch "$FIRST_LOGIN_SETUP_FLAG"
fi

# normal start scripts ------------------------------------------------------------------------
fcitx5 -d
sleep 5
xmodmap -e "keycode 121 = Hangul_Hanja"
xmodmap -e "keycode 122 = Hangul"
xmodmap -e "keycode 123 = Hangul_Hanja"
