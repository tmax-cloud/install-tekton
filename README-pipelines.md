# Tekton Pipelines 설치 가이드

## 구성 요소 및 버전
* controller ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/controller:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/controller@sha256:e6e92621e4192768fd5f189b5c10724c652bbcc2565f225ebca1c73fb9f52f58/details?tab=info))
* webhook ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/webhook:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/webhook@sha256:244815c2daecc8ee60c27a8df9947fe67d0c7b9f52e809de450bdccb32c8dd75/details?tab=info))
* kubeconfigwriter ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/kubeconfigwriter@sha256:bee70aa4869c6087470476882eec33d1d22843361933c01869fd2bc4f1e243cd/details?tab=info))
* git-init ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/git-init@sha256:720ba70dc20f6bb3672ce696fbeb58ca1b005fcd96acdeacaa2dbaf75bbc9a50/details?tab=info))
* entrypoint ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/entrypoint:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/entrypoint@sha256:599e95ac34de374a34cb93a25b7f653714bd17824d8c0f7260036a7ba0a9bc30/details?tab=info))
* nop ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/nop:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/nop@sha256:45500af4d68be54b99c7c84f99a61595cf73e3e761c69a8009fe1adcc8ccd2af/details?tab=info))
* imagedigestexporter ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/imagedigestexporter@sha256:f35d8a739e2c91cbb4deece8e9f85a010d869979066532a2fbdf59e43270c656/details?tab=info))
* pullrequest-init ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:v0.22.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/pullrequest-init@sha256:6b03c03f0d00a3e4c5c62e8a3379b1a0853e229b0fedf9ec8d8d4d790dfa1c52/details?tab=info))
* cloud-sdk ([gcr.io/google.com/cloudsdktool/cloud-sdk](https://console.cloud.google.com/gcr/images/google.com:cloudsdktool/GLOBAL/cloud-sdk@sha256:27b2c22bf259d9bc1a291e99c63791ba0c27a04d2db0a43241ba0f1f20f4067f/details?tab=info))
* base ([gcr.io/distroless/base](https://console.cloud.google.com/gcr/images/distroless/GLOBAL/base@sha256:92720b2305d7315b5426aec19f8651e9e04222991f877cae71f40b3141d2f07e/details?tab=info))

## 폐쇄망 설치 가이드
설치를 진행하기 전 아래의 과정을 통해 필요한 이미지 및 yaml 파일을 준비한다.
1. 폐쇄망에서 설치하는 경우 사용하는 image repository에 Tekton Pipelines 설치 시 필요한 이미지를 push한다.
    * 작업 디렉토리 생성 및 환경 설정
   ```bash
   git clone https://github.com/tmax-cloud/install-tekton.git -b 5.0 --single-branch
   cd install-tekton
   
   source common.sh
   source installer_pipeline.sh
    
   prepare_tekton_pipeline_online
   ```

2. 폐쇄망 환경으로 전송
   ```bash
   # 생성된 파일 모두 SCP 또는 물리 매체를 통해 폐쇄망 환경으로 복사
   cd ..
   scp -r install-tekton <REMOTE_SERVER>:<PATH>
   ``` 

3. cicd.config 설정
   ```config
   imageRegistry=172.22.11.2:30500 # 레지스트리 주소 (폐쇄망 아닐 경우 빈 값으로 설정)
   ```

4. 위의 과정에서 생성한 tar 파일들을 폐쇄망 환경으로 이동시킨 뒤 사용하려는 registry에 이미지를 push한다.
   ```bash
   source common.sh
   source installer_pipeline.sh
   
   prepare_tekton_pipeline_offline
   ```

## 설치 가이드
1. [Pipelines 설치](#step-1-pipelines-설치)

## Step 1. Pipelines 설치
* 목적 : `Tekton Pipelines에 필요한 구성 요소 설치`
* 생성 순서 : 아래 command로 설치 yaml 적용
   ```bash
   source common.sh
   source installer_pipeline.sh
  
   install_tekton_pipeline 
   ```


## 삭제 가이드
1. [Pipelines 삭제](#step-1-pipelines-삭제)

## Step 1. Pipelines 삭제
* 목적 : `Tekton Pipelines 구성 요소 삭제`
* 생성 순서 : 아래 command로 설치 yaml 삭제
   ```bash
   source common.sh
   source installer_pipeline.sh
  
   uninstall_tekton_pipeline 
   ```
