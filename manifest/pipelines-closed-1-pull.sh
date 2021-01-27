#!/bin/bash

mkdir -p $HOME/tekton-install
cd $HOME/tekton-install

# 외부 네트워크 통신이 가능한 환경에서 필요한 이미지를 다운받는다.
# Tekton Pipleine 필수 이미지 Pull
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/controller:v0.12.1@sha256:0ca86ec6f246f49c1ac643357fd1c8e73a474aaa216548807b1216a9ff12f7be
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:v0.12.1@sha256:67dcd447b0c624befa12843ce9cc0bcfc502179bdb28d59563d761a7f3968509
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/creds-init:v0.12.1@sha256:6266d023172dde7fa421f626074b4e7eedc7d7d5ff561c033d6d63ebfff4a2f2
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.12.1@sha256:d82c78288699dd6ee40c852b146cb3bd89b322b42fb3bc4feec28ea54bb7b36c
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/entrypoint:v0.12.1@sha256:7f3db925f7660673a74b0e1030e65540adea36fe361ab7f06f5b5c47cdcef47d
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:v0.12.1@sha256:e8f08214baad9054bbed7be2b8617c6964b9a1c5405cf59eabcc3d3267a6253f
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:v0.12.1@sha256:71e0226346e0d3d57af7c35b6cb907d42d3142e845b0f865ba0c86d3e248f3cb
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/vendor/github.com/googlecloudplatform/cloud-builders/gcs-fetcher/cmd/gcs-fetcher:v0.12.1@sha256:ae5721bf0d883947c3c13f519ca26129792f4058d5f9dfedd50174d9e7acb2bc
docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/webhook:v0.12.1@sha256:69f065d493244dbd50563b96f5474bf6590821a6308fd8c69c5ef06cf4d988b2
docker pull tianon/true
docker pull busybox
docker pull google/cloud-sdk:289.0.0

# 이미지 태그
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/controller:v0.12.1@sha256:0ca86ec6f246f49c1ac643357fd1c8e73a474aaa216548807b1216a9ff12f7be controller:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:v0.12.1@sha256:67dcd447b0c624befa12843ce9cc0bcfc502179bdb28d59563d761a7f3968509 kubeconfigwriter:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/creds-init:v0.12.1@sha256:6266d023172dde7fa421f626074b4e7eedc7d7d5ff561c033d6d63ebfff4a2f2 creds-init:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.12.1@sha256:d82c78288699dd6ee40c852b146cb3bd89b322b42fb3bc4feec28ea54bb7b36c git-init:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/entrypoint:v0.12.1@sha256:7f3db925f7660673a74b0e1030e65540adea36fe361ab7f06f5b5c47cdcef47d entrypoint:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:v0.12.1@sha256:e8f08214baad9054bbed7be2b8617c6964b9a1c5405cf59eabcc3d3267a6253f imagedigestexporter:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:v0.12.1@sha256:71e0226346e0d3d57af7c35b6cb907d42d3142e845b0f865ba0c86d3e248f3cb pullrequest-init:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/vendor/github.com/googlecloudplatform/cloud-builders/gcs-fetcher/cmd/gcs-fetcher:v0.12.1@sha256:ae5721bf0d883947c3c13f519ca26129792f4058d5f9dfedd50174d9e7acb2bc gcs-fetcher:v0.12.1
docker tag gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/webhook:v0.12.1@sha256:69f065d493244dbd50563b96f5474bf6590821a6308fd8c69c5ef06cf4d988b2 webhook:v0.12.1
docker tag tianon/true tianon-true:v0.12.1
docker tag busybox busybox:v0.12.1
docker tag google/cloud-sdk:289.0.0 google-cloud-sdk:v0.12.1

# Tekton Pipleine 필수 이미지 Save
docker save controller:v0.12.1 > tekton-pipeline-controller-v0.12.1.tar
docker save kubeconfigwriter:v0.12.1 > tekton-pipeline-kubeconfigwriter-v0.12.1.tar
docker save creds-init:v0.12.1 > tekton-pipeline-creds-init-v0.12.1.tar
docker save git-init:v0.12.1 > tekton-pipeline-git-init-v0.12.1.tar
docker save entrypoint:v0.12.1 > tekton-pipeline-entrypoint-v0.12.1.tar
docker save imagedigestexporter:v0.12.1 > tekton-pipeline-imagedigestexporter-v0.12.1.tar
docker save pullrequest-init:v0.12.1 > tekton-pipeline-pullrequest-init-v0.12.1.tar
docker save gcs-fetcher:v0.12.1 > tekton-pipeline-gcs-fetcher-v0.12.1.tar
docker save webhook:v0.12.1 > tekton-pipeline-webhook-v0.12.1.tar
docker save tianon-true:v0.12.1 > tekton-pipeline-tianon-true-v0.12.1.tar
docker save busybox:v0.12.1 > tekton-pipeline-busybox-v0.12.1.tar
docker save google-cloud-sdk:v0.12.1 > tekton-pipeline-google-cloud-sdk-v0.12.1.tar

# install yaml을 다운로드한다.
wget https://raw.githubusercontent.com/tmax-cloud/install-tekton/4.1/manifest/tekton-pipeline-v0.12.1.yaml -O tekton-pipeline-v0.12.1.yaml
