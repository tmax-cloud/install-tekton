#!/bin/bash

# 작업 디렉토리 생성 및 환경 설정
mkdir -p $HOME/mail-install
cd $HOME/mail-install

# 외부 네트워크 통신이 가능한 환경에서 필요한 이미지를 다운받는다.
# Mail Notifier 필수 이미지 Pull
docker pull tmaxcloudck/mail-sender-server:v0.0.4
docker pull tmaxcloudck/mail-sender-client:v0.0.4

# 이미지 태그
docker tag tmaxcloudck/mail-sender-server:v0.0.4 mail-sender-server:v0.0.4
docker tag tmaxcloudck/mail-sender-client:v0.0.4 mail-sender-client:v0.0.4

# Mail Notifier 필수 이미지 Save
docker save mail-sender-server:v0.0.4 > mail-sender-server-v0.0.4.tar
docker save mail-sender-client:v0.0.4 > mail-sender-client-v0.0.4.tar

# install yaml을 다운로드한다.
wget https://raw.githubusercontent.com/cqbqdd11519/mail-notifier/master/deploy/service.yaml
wget https://raw.githubusercontent.com/cqbqdd11519/mail-notifier/master/deploy/server.yaml
wget https://raw.githubusercontent.com/cqbqdd11519/mail-notifier/master/deploy/secret.yaml.template
