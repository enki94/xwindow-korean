FROM debian:trixie

ENV TZ=Asia/Seoul
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR:ko
ENV LC_ALL=ko_KR.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends dbus-x11 locales x11-xserver-utils xfce4 xfce4-goodies xorgxrdp xrdp fonts-noto-cjk ibus ibus-hangul sudo vim net-tools chromium git curl npm golang && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && sed -i 's/^# *ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && locale-gen $LANG && update-locale LANG=$LANG

# install vscode
RUN curl -L -o vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
RUN apt install ./vscode.deb

# hangul input
RUN echo "GTK_IM_MODULE=ibus" >> /etc/environment && \
    echo "QT_IM_MODULE=ibus" >> /etc/environment && \
    echo "XMODIFIERS=@im=ibus" >> /etc/environment

# no sandbox options
RUN sed -i 's|^CHROMIUM_FLAGS=""|CHROMIUM_FLAGS="--no-sandbox --start-maximized --disable-gpu"|' /usr/bin/chromium
RUN sed -i 's|ELECTRON_RUN_AS_NODE=1 "\$ELECTRON" "\$CLI" "\$@"|ELECTRON_RUN_AS_NODE=1 "\$ELECTRON" "\$CLI" --no-sandbox --disable-gpu "\$@"|' /usr/bin/code

EXPOSE 3389

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY autostart.sh /autostart.sh
RUN chmod +x /autostart.sh

ENTRYPOINT /entrypoint.sh
