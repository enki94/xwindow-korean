![Repo Size](https://img.shields.io/github/repo-size/lancard/xwindow-korean)
![File Count](https://img.shields.io/github/directory-file-count/lancard/xwindow-korean)
![Docker Pulls](https://img.shields.io/docker/pulls/lancard/xwindow-korean)
![Docker Image Size](https://img.shields.io/docker/image-size/lancard/xwindow-korean)

# 설명
RDP(리모트 데스크탑) 지원하는 경량 debian 13 (trixie) base 한글 XWINDOW(wayland) docker

# 설치된 프로그램
- Visual studio code
- Chromium
- vim
- git
- npm + nodejs

# 사용법
- docker 3389 port 열어서 띄우시면 됩니다. 그 후 윈도우 원격 데스크탑(3389포트)으로 해당 컨테이너 접속.
- 사용자명을 지정하고 싶은 경우, docker env 에다가 XWINDOW_USER=(사용자명), XWINDOW_PASSWORD=(패스워드) 를 입력하시면 됩니다.
- 만약 입력안하시는 경우 사용자명은 'user', 패스워드는 임의로 생성되며, 패스워드는 docker logs 에 표시됩니다.

# 사용자 데이터 및 볼륨 유지
- docker 에서 /home/(사용자명) 볼륨을 연결하시는 경우 home 디렉토리 안에 있는 자료는 유지되며 계속 사용하실 수 있습니다.

# 로컬리소스 (드라이브) 연결
- 보안 상 로컬리소스가 붙는게 막혀있습니다. 로컬 리소스를 연결해서 CTRL+C / CTRL+V 같은 파일 복사를 원하시는 경우에는 privileged 모드로 실행하세요.
- privileged 모드로 실행하는 경우 C: 같은 드라이브는 home 디렉토리 내 thinclient_drives 에 마운트 됩니다.

# 새 사용자 생성
sudo su 하셔서 루트 권한으로 adduser 하시면 됩니다.

# 주의사항
- privileged mode 가 아닌 경우 vscode 나 chromium 이 no-sandbox 모드에서 실행됩니다. 참고하십시오.
- sound 관련이 충돌이 많고 버그가 많아 포함시키지 않았습니다. 테스트 결과 설치하더라도 끊기거나 안정적이지 않습니다. 게다가 설치 용량도 너무 커지는 관계로 제외하였습니다.
