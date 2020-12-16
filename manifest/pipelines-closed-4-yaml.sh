#!/bin/bash

# 이미지 레지스트리 주소
if [[ "$REGISTRY" == "" ]]; then
  echo "REGISTRY is not set"
  exit 1
fi

cp tekton-pipeline-v0.12.1.yaml updated.yaml
sed -i -E "s/gcr.io\/tekton-releases\/.*\/([^@]*)@[^\n\"]*/$REGISTRY\/\1/g" updated.yaml
sed -i "s/tianon\/true@[^\n\"]*/$REGISTRY\/tianon-true:v0.12.1/g" updated.yaml
sed -i "s/busybox@[^\n\"]*/$REGISTRY\/busybox:v0.12.1/g" updated.yaml
sed -i "s/google\/cloud-sdk@[^\n\"]*/$REGISTRY\/google-cloud-sdk:v0.12.1/g" updated.yaml
