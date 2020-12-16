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
docker load < tekton-triggers-controller-v0.4.0.tar
docker load < tekton-triggers-eventlistenersink-v0.4.0.tar
docker load < tekton-triggers-webhook-v0.4.0.tar

# Tag images
docker tag triggers-controller:v0.4.0 $REGISTRY/triggers-controller:v0.4.0
docker tag triggers-eventlistenersink:v0.4.0 $REGISTRY/triggers-eventlistenersink:v0.4.0
docker tag triggers-webhook:v0.4.0 $REGISTRY/triggers-webhook:v0.4.0

# Push images
docker push $REGISTRY/triggers-controller:v0.4.0
docker push $REGISTRY/triggers-eventlistenersink:v0.4.0
docker push $REGISTRY/triggers-webhook:v0.4.0
