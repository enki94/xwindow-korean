export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

xdg-settings set default-web-browser chromium.desktop

ibus-daemon -drx
sleep 5
ibus engine hangul
