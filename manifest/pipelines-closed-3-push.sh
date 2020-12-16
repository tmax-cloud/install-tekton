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
docker load < tekton-pipeline-controller-v0.12.1.tar
docker load < tekton-pipeline-kubeconfigwriter-v0.12.1.tar
docker load < tekton-pipeline-creds-init-v0.12.1.tar
docker load < tekton-pipeline-git-init-v0.12.1.tar
docker load < tekton-pipeline-entrypoint-v0.12.1.tar
docker load < tekton-pipeline-imagedigestexporter-v0.12.1.tar
docker load < tekton-pipeline-pullrequest-init-v0.12.1.tar
docker load < tekton-pipeline-gcs-fetcher-v0.12.1.tar
docker load < tekton-pipeline-webhook-v0.12.1.tar
docker load < tekton-pipeline-tianon-true-v0.12.1.tar
docker load < tekton-pipeline-busybox-v0.12.1.tar
docker load < tekton-pipeline-google-cloud-sdk-v0.12.1.tar

# Tag images
docker tag controller:v0.12.1 $REGISTRY/controller:v0.12.1
docker tag kubeconfigwriter:v0.12.1 $REGISTRY/kubeconfigwriter:v0.12.1
docker tag creds-init:v0.12.1 $REGISTRY/creds-init:v0.12.1
docker tag git-init:v0.12.1 $REGISTRY/git-init:v0.12.1
docker tag entrypoint:v0.12.1 $REGISTRY/entrypoint:v0.12.1
docker tag imagedigestexporter:v0.12.1 $REGISTRY/imagedigestexporter:v0.12.1
docker tag pullrequest-init:v0.12.1 $REGISTRY/pullrequest-init:v0.12.1
docker tag gcs-fetcher:v0.12.1 $REGISTRY/gcs-fetcher:v0.12.1
docker tag webhook:v0.12.1 $REGISTRY/webhook:v0.12.1
docker tag tianon-true:v0.12.1 $REGISTRY/tianon-true:v0.12.1
docker tag busybox:v0.12.1 $REGISTRY/busybox:v0.12.1
docker tag google-cloud-sdk:v0.12.1 $REGISTRY/google-cloud-sdk:v0.12.1

# Push images
docker push $REGISTRY/controller:v0.12.1
docker push $REGISTRY/kubeconfigwriter:v0.12.1
docker push $REGISTRY/creds-init:v0.12.1
docker push $REGISTRY/git-init:v0.12.1
docker push $REGISTRY/entrypoint:v0.12.1
docker push $REGISTRY/imagedigestexporter:v0.12.1
docker push $REGISTRY/pullrequest-init:v0.12.1
docker push $REGISTRY/gcs-fetcher:v0.12.1
docker push $REGISTRY/webhook:v0.12.1
docker push $REGISTRY/tianon-true:v0.12.1
docker push $REGISTRY/busybox:v0.12.1
docker push $REGISTRY/google-cloud-sdk:v0.12.1
