# Tekton Pipelines 설치 가이드

## 구성 요소 및 버전
* controller ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/controller:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/controller@sha256:972ee9c3f43c88495b074bfc0a8350eb34131355ab9ddc5da63c59f64d74e83d/details?tab=info))
* webhook ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/webhook:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/webhook@sha256:1c9c9acf8451fd40ce46dc4069d1b589a7fe1b9e5798652beb4f514e4a17e8cb/details?tab=info))
* kubeconfigwriter ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/kubeconfigwriter@sha256:1727868bd5a22dd8e45a4efca0a7f0b5b00cd1bbbe97068e60986ae221b828c3/details?tab=info))
* git-init ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/git-init@sha256:db18a9c1607c8cbbcd72f61d0c4d795b9ff528669deacd5f8a1672e4ef198ffd/details?tab=info))
* entrypoint ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/entrypoint:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/entrypoint@sha256:d5af7d58c2ad222548e7fcaf7d8e8172837df254b49cc636d1f9d0d8c499beb8/details?tab=info))
* nop ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/nop:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/nop@sha256:8172a046a040a6267888ab9755b48631bbcf92ea58534ae506bb80125ee94cc2?tag=v0.21.0))
* imagedigestexporter ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/imagedigestexporter@sha256:265641edf8fbb19f844f7d2006d1b81927f43fd1b19f037709355938a1e3c78e?tag=v0.21.0))
* pullrequest-init ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/cmd/pullrequest-init@sha256:6e2c398d27d5d9f6de3a41ed2d70d9c940e22a648a349c5cb5bbdbb76484c9fe?tag=v0.21.0))
* gcs-fetcher ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/vendor/github.com/googlecloudplatform/cloud-builders/gcs-fetcher/cmd/gcs-fetcher:v0.21.0](https://console.cloud.google.com/gcr/images/tekton-releases/GLOBAL/github.com/tektoncd/pipeline/vendor/github.com/googlecloudplatform/cloud-builders/gcs-fetcher/cmd/gcs-fetcher@sha256:41c251a2cc7e7c6e6c0f8d3bc3f0c3cc6a980325e754d4d95570c775a2a80b35/details?tab=info))
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
