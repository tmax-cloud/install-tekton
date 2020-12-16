#!/bin/bash

# 작업 디렉토리 생성 및 환경 설정
mkdir -p $HOME/approval-install
cd $HOME/approval-install

# 외부 네트워크 통신이 가능한 환경에서 필요한 이미지를 다운받는다.
# Approval 필수 이미지 Pull
docker pull tmaxcloudck/approval-watcher:0.0.3
docker pull tmaxcloudck/approval-step-server:0.0.3

# 이미지 태그
docker tag tmaxcloudck/approval-watcher:0.0.3 approval-watcher:0.0.3
docker tag tmaxcloudck/approval-step-server:0.0.3 approval-step-server:0.0.3

# Approval 필수 이미지 Save
docker save approval-watcher:0.0.3 > approval-watcher-0.0.3.tar
docker save approval-step-server:0.0.3 > approval-step-server-0.0.3.tar

# install yaml을 다운로드한다.
wget https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/crds/tmax.io_approvals_crd.yaml crd.yaml
wget https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/namespace.yaml
wget https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/service_account.yaml
wget https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/role.yaml
wget https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/role_binding.yaml
wget https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/service.yaml
wget https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/proxy-server.yaml
