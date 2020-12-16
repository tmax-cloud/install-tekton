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
docker load < approval-watcher-0.0.3.tar
docker load < approval-step-server-0.0.3.tar

# Tag images
docker tag approval-watcher:0.0.3 $REGISTRY/approval-watcher:0.0.3
docker tag approval-step-server:0.0.3 $REGISTRY/approval-step-server:0.0.3

# Push images
docker push $REGISTRY/approval-watcher:0.0.3
docker push $REGISTRY/approval-step-server:0.0.3
