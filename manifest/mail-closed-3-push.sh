#!/bin/bash

# 이미지 레지스트리 주소
if [[ "$REGISTRY" == "" ]]; then
  echo "REGISTRY is not set"
  exit 1
fi

# 이미지 tar 및 yaml 다운로드되어있는 디렉토리 경로
if [[ "$REMOTE_PATH" == "" ]]; then
  echo "REMOTE_PATH is not set"
  exit 1
fi

cd $REMOTE_PATH

# Load images
docker load < mail-sender-server-v0.0.4.tar
docker load < mail-sender-client-v0.0.4.tar

# Tag images
docker tag mail-sender-server:v0.0.4 $REGISTRY/mail-sender-server:v0.0.4
docker tag mail-sender-client:v0.0.4 $REGISTRY/mail-sender-client:v0.0.4

# Push images
docker push $REGISTRY/mail-sender-server:v0.0.4
docker push $REGISTRY/mail-sender-client:v0.0.4
