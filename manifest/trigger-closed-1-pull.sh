#!/bin/bash

# 작업 디렉토리 생성 및 환경 설정
mkdir -p $HOME/tekton-trigger-install
cd $HOME/tekton-trigger-install

# 외부 네트워크 통신이 가능한 환경에서 필요한 이미지를 다운받는다.
# Tekton Trigger 필수 이미지 Pull
docker pull gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/controller@sha256:bf3517ddccace756e39cee0f0012bbe879c6b28d962a1c904a415e7c60ce5bc2
docker pull gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/eventlistenersink@sha256:76c208ec1d73d9733dcaf850240e1b3990e5977709a03c2bd98ad5b20fab9867
docker pull gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/webhook@sha256:d7f1526a9294e671c500f0071b61e050262fb27fb633b54d764a556969855764

# 이미지 태그
docker tag gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/controller@sha256:bf3517ddccace756e39cee0f0012bbe879c6b28d962a1c904a415e7c60ce5bc2 triggers-controller:v0.4.0
docker tag gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/eventlistenersink@sha256:76c208ec1d73d9733dcaf850240e1b3990e5977709a03c2bd98ad5b20fab9867 triggers-eventlistenersink:v0.4.0
docker tag gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/webhook@sha256:d7f1526a9294e671c500f0071b61e050262fb27fb633b54d764a556969855764 triggers-webhook:v0.4.0


# Tekton Trigger 필수 이미지 Save
docker save triggers-controller:v0.4.0 > tekton-triggers-controller-v0.4.0.tar
docker save triggers-eventlistenersink:v0.4.0 > tekton-triggers-eventlistenersink-v0.4.0.tar
docker save triggers-webhook:v0.4.0 > tekton-triggers-webhook-v0.4.0.tar

# install yaml을 다운로드한다.
wget https://raw.githubusercontent.com/tmax-cloud/install-tekton/4.1/manifest/tekton-triggers-v0.4.0.yaml -O tekton-triggers-v0.4.0.yaml
