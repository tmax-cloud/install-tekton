#!/bin/bash

# 이미지 레지스트리 주소
if [[ "$REGISTRY" == "" ]]; then
  echo "REGISTRY is not set"
  exit 1
fi

cp server.yaml updated.yaml
sed -i "s/tmaxcloudck\/mail-sender-server:v0.0.3/$REGISTRY\/mail-sender-server:v0.0.3/g" updated.yaml
