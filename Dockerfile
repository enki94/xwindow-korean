FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# locale gen
RUN apt-get install -y locales
ENV TZ=Asia/Seoul
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR:ko
ENV LC_ALL=ko_KR.UTF-8
RUN sed -i 's/^# *ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && locale-gen $LANG && update-locale LANG=$LANG

# install modules
RUN apt-get install -y dbus-x11 x11-xserver-utils xfce4 xfce4-goodies xorgxrdp xrdp tumbler \
    ibus ibus-gtk3 fcitx5-hangul fcitx5-config-qt fcitx5-frontend-gtk3 fcitx5-frontend-gtk4 fcitx5-frontend-qt5 fonts-noto-cjk \
    sudo nano vim net-tools chromium git curl npm \ 
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# install vscode
RUN curl -q -L -o vscode.deb https://update.code.visualstudio.com/1.103.2/linux-deb-x64/stable \
    && apt-get install ./vscode.deb \
    && rm -rf ./vscode.deb /etc/apt/sources.list.d/vscode.sources

# no sandbox options
RUN sed -i 's|^CHROMIUM_FLAGS=""|CHROMIUM_FLAGS="--no-sandbox --start-maximized --disable-gpu"|' /usr/bin/chromium
RUN rm -rf /usr/bin/code
RUN ln -s /usr/share/code/bin/code /usr/bin/code
RUN sed -i 's|ELECTRON_RUN_AS_NODE=1 "\$ELECTRON" "\$CLI" "\$@"|ELECTRON_RUN_AS_NODE=1 "\$ELECTRON" "\$CLI" --no-sandbox --disable-gpu "\$@"|' /usr/share/code/bin/code

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY user-entrypoint.sh /etc/X11/Xsession.d/97user-entrypoint

COPY initial-resource/ /var/initial-resource/

# korean keycode correction
RUN sed -i 's/<HNGL> =  209;/<HNGL> =  122;/g' /usr/share/X11/xkb/keycodes/xfree86
RUN sed -i 's/<HJCV> =  210;/<HJCV> =  121;/g' /usr/share/X11/xkb/keycodes/xfree86

# startup profile
RUN echo "TZ=Asia/Seoul" >> /etc/environment && \
    echo "LANG=ko_KR.UTF-8" >> /etc/environment && \
    echo "LANGUAGE=ko_KR:ko" >> /etc/environment && \
    echo "LC_ALL=ko_KR.UTF-8" >> /etc/environment && \
    echo "GTK_IM_MODULE=fcitx" >> /etc/environment && \
    echo "QT_IM_MODULE=fcitx" >> /etc/environment && \
    echo "QT4_IM_MODULE=fcitx" >> /etc/environment && \
    echo "QT5_IM_MODULE=fcitx" >> /etc/environment && \
    echo "XMODIFIERS=@im=fcitx" >> /etc/environment

EXPOSE 3389
ENTRYPOINT /entrypoint.sh
