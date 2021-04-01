# CI/CD Operator 설치 가이드

## 구성 요소 및 버전
* operator ([tmaxcloudck/cicd-operator:v0.2.2](https://hub.docker.com/layers/tmaxcloudck/cicd-operator/v0.2.2/images/sha256-4d73f2956257c4a38bf818c5ea281d8ef5f1ca9cce7c3d3502e22598fc080ed0?context=explore))

## 폐쇄망 설치 가이드
설치를 진행하기 전 아래의 과정을 통해 필요한 이미지 및 yaml 파일을 준비한다.
1. 폐쇄망에서 설치하는 경우 사용하는 image repository에 CI/CD Operator 설치 시 필요한 이미지를 push한다.
    * 작업 디렉토리 생성 및 환경 설정
   ```bash
   git clone https://github.com/tmax-cloud/install-tekton.git -b 5.0 --single-branch
   cd install-tekton
   
   source common.sh
   source installer_operator.sh
    
   prepare_cicd_operator_online
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
   source installer_operator.sh
   
   prepare_cicd_operator_offline
   ```

## 설치 가이드
1. [Operator 설치](#step-1-operator-설치)

## Step 1. Operator 설치
* 목적 : `CI/CD Operator에 필요한 구성 요소 설치`
* 생성 순서 : 아래 command로 설치 yaml 적용
   ```bash
   source common.sh
   source installer_operator.sh
  
   install_cicd_operator
   ```


## 삭제 가이드
1. [IntegrationJob 삭제](#step-1-pipelines-삭제)

## Step 1. Pipelines 삭제
* 목적 : `Tekton Pipelines 구성 요소 삭제`
* 생성 순서 : 아래 command로 설치 yaml 삭제
   ```bash
   source common.sh
   source installer_operator.sh
  
   uninstall_cicd_operator
   ```
