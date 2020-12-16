#!/bin/bash

# 이미지 레지스트리 주소
if [[ "$REGISTRY" == "" ]]; then
  echo "REGISTRY is not set"
  exit 1
fi

cp tekton-triggers-v0.4.0.yaml updated.yaml
sed -i -E "s/gcr.io\/tekton-releases\/.*\/([^@]*)@[^\n\"]*/$REGISTRY\/triggers-\1:v0.4.0/g" updated.yaml
