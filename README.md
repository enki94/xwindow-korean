# 설명
debian 13 (trixie) base 한글 x11 docker

# 설치된 프로그램
- Visual studio code
- Chromium
- vim
- git
- npm + nodejs

# 사용법
- docker 3389 port 열어서 띄우시면 됩니다. 그 후 윈도우 원격 데스크탑(3389포트)으로 해당 컨테이너 접속.
- 사용자명을 지정하고 싶은 경우, docker env 에다가 X11_USER=(사용자명), X11_PASSWORD=(패스워드) 를 입력하시면 됩니다.
- 만약 입력안하시는 경우 사용자명은 'user', 패스워드는 임의로 생성되며, 패스워드는 docker logs 에 표시됩니다.

# 사용자 데이터 및 볼륨 유지
docker 에서 /home/(사용자명) 볼륨을 연결하시는 경우 home 디렉토리 안에 있는 자료는 유지되며 계속 사용하실 수 있습니다.

# 새 사용자 생성
sudo su 하셔서 루트 권한으로 adduser 하시면 됩니다.

# 주의사항
- docker 에서 돌리는 관계로 vscode 나 chromium 이 sandbox 모드에서 돌지 않습니다. 보안에 유의하십시오.
- sound 관련이 충돌이 많고 버그가 많아 포함시키지 않았습니다. 테스트 결과 설치하더라도 끊기거나 안정적이지 않습니다. 게다가 설치 용량도 너무 커지는 관계로 제외하였습니다.
