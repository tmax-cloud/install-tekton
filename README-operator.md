# CI/CD Operator 설치 가이드

## 구성 요소 및 버전
* Operator ([tmaxcloudck/cicd-operator:v0.1.3](https://hub.docker.com/layers/tmaxcloudck/cicd-operator/v0.1.3/images/sha256-748476cd8402c25603ee21e6018010ca45b90a57946f8cddd2407605c48c2d60?context=explore))

## 폐쇄망 설치 가이드
설치를 진행하기 전 아래의 과정을 통해 필요한 이미지 및 yaml 파일을 준비한다.
1. 폐쇄망에서 설치하는 경우 사용하는 image repository에 CI/CD Operator 설치 시 필요한 이미지를 push한다.
    * 작업 디렉토리 생성 및 환경 설정
    ```bash
    mkdir -p $HOME/cicd-operator-install
    cd $HOME/cicd-operator-install
    ```
    * 외부 네트워크 통신이 가능한 환경에서 필요한 이미지를 다운받는다.
    ```bash
    # Operator 이미지 Pull / 태그 / Save
    docker pull tmaxcloudck/cicd-operator:v0.1.3
    docker tag tmaxcloudck/cicd-operator:v0.1.3 cicd-operator:v0.1.3
    docker save cicd-operator:v0.1.3 > cicd-operator-v0.1.3.tar
    ```
    * install yaml을 다운로드한다.
    ```bash
    wget https://raw.githubusercontent.com/tmax-cloud/cicd-operator/v0.1.3/config/release.yaml -O cicd-operator-v0.1.3.yaml
    ```

2. 폐쇄망 환경으로 전송
    ```bash
    # 생성된 파일 모두 SCP 또는 물리 매체를 통해 폐쇄망 환경으로 복사
    scp -r $HOME/cicd-operator-install <REMOTE_SERVER>:<PATH>
    ``` 

3. 위의 과정에서 생성한 tar 파일들을 폐쇄망 환경으로 이동시킨 뒤 사용하려는 registry에 이미지를 push한다.
    ```bash
    # 이미지 레지스트리 주소
    REGISTRY=[IP:PORT]
   
    cd <PATH> 
    
    # Load/Tag/Push images
    docker load < cicd-operator-v0.1.3.tar
    docker tag cicd-operator:v0.1.3 $REGISTRY/cicd-operator:v0.1.3
    docker push $REGISTRY/cicd-operator:v0.1.3
    ```
4. YAML 수정
    ```bash
    REGISTRY=[IP:PORT]
    
    cp cicd-operator-v0.1.3.yaml updated.yaml
    sed -i "s/tmaxcloudck\/[^\n\"]*/$REGISTRY\/cicd-operator:v0.1.3/g" updated.yaml
    ```

## 설치 가이드
1. [Tekton 기본 설정](#step-1-tekton-기본-설정)
1. [Operator 설치](#step-2-operator-설치)

## Step 1. Tekton 기본 설정
* 목적: CI/CD Operator가 작동 가능하도록 Tekton 설정
* 생성 순서 : 아래 command로 Tekton 설정 적용
  ```bash
  kubectl -n tekton-pipelines patch configmap feature-flags \
  --type merge \
  -p '{"data": {"enable-custom-tasks": "true", "disable-affinity-assistant": "true"}}'
  ```

## Step 2. Operator 설치
* 목적 : `CI/CD Operator에 필요한 구성 요소 설치`
* 생성 순서 : 아래 command로 설치 yaml 적용
    * (외부망 연결된 환경 설치 시 실행)
    ```bash
    kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/cicd-operator/v0.1.3/config/release.yaml
    ```
    * (폐쇄망 환경 설치 시 실행)
    ```bash
    kubectl apply -f updated.yaml 
    ```


## 삭제 가이드
1. [IntegrationJob 삭제](#step-1-pipelines-삭제)
2. [IntegrationConfig 삭제]()

## Step 1. Pipelines 삭제
* 목적 : `Tekton Pipelines 구성 요소 삭제`
* 생성 순서 : 아래 command로 설치 yaml 삭제
    * (외부망 연결된 환경 설치 시 실행)
    ```bash
    kubectl delete -f https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.12.1/release.yaml
    ```
    * (폐쇄망 환경 설치 시 실행)
    ```bash
    kubectl delete -f updated.yaml 
