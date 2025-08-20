FROM debian:bookworm

ENV TZ=Asia/Seoul
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR:ko
ENV LC_ALL=ko_KR.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends dbus-x11 locales x11-xserver-utils xfce4 xfce4-goodies xorgxrdp xrdp fonts-noto-cjk ibus ibus-hangul sudo vim net-tools chromium git gnupg2 gnome-software curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && locale-gen $LANG

# install vscode
RUN curl -L -o vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
RUN apt install ./vscode.deb

EXPOSE 3389

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
