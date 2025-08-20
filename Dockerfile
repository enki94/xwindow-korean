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

RUN echo "xfce4-session" > /etc/skel/.xsession && \
    echo "export GTK_IM_MODULE=ibus" >> /etc/skel/.xsessionrc && \
    echo "export XMODIFIERS=@im=ibus" >> /etc/skel/.xsessionrc && \
    echo "export QT_IM_MODULE=ibus" >> /etc/skel/.xsessionrc

EXPOSE 3389

ENTRYPOINT bash -c ' \
  adduser --disabled-password --gecos "" user && \
  NEW_PASS=$(openssl rand -base64 6) && \
  echo "user:${NEW_PASS}" | chpasswd && \
  echo "==================================" && \
  echo "user 계정의 비밀번호가 변경되었습니다." && \
  echo "새 비밀번호: ${NEW_PASS}" && \
  echo "==================================" && \
  /usr/sbin/xrdp-sesman && /usr/sbin/xrdp --nodaemon'
