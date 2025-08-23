#!/bin/bash

FIRST_LOGIN_SETUP_FLAG="$HOME/.first_login_setup_done"

# first login script
if [ ! -f "$FIRST_LOGIN_SETUP_FLAG" ]; then
    
    # 디폴트 브라우져 설정
    xdg-settings set default-web-browser chromium.desktop

    # fcitx5 설정 복사
    cp /var/initial-resource/.config ~ -R

    # .desktop 파일 복사
    cp /var/initial-resource/Desktop/*.desktop ~/Desktop/

    # Desktop/*.desktop 반복 처리
    for FILE in ~/Desktop/*.desktop; do
        # 1. 실행 권한 부여
        chmod +x "$FILE"
    
        # 2. XFCE 체크섬 설정
        if command -v gio >/dev/null 2>&1; then
            SHA256=$(sha256sum "$FILE" | awk '{print $1}')
            gio set "$FILE" metadata::xfce-exe-checksum "$SHA256"
            chmod 700 "$FILE"
        fi
    done
    
    touch "$FIRST_LOGIN_SETUP_FLAG"
fi

# normal start scripts ------------------------------------------------------------------------
fcitx5 -d
sleep 5
xmodmap -e "keycode 121 = Hangul_Hanja"
xmodmap -e "keycode 122 = Hangul"
xmodmap -e "keycode 123 = Hangul_Hanja"
