#!/bin/bash

# 이미지 레지스트리 주소
if [[ "$REGISTRY" == "" ]]; then
  echo "REGISTRY is not set"
  exit 1
fi

cp proxy-server.yaml updated.yaml
sed -i "s/tmaxcloudck\/approval-watcher:latest/$REGISTRY\/approval-watcher:0.0.3/g" updated.yaml
