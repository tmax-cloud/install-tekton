#!/bin/bash

# SMTP 서버 URL
if [[ "$SMTP_SERVER" == "" ]]; then
  echo "SMTP_SERVER is not set"
  exit 1
fi

# SMTP 계정
if [[ "$SMTP_USER" == "" ]]; then
  echo "SMTP_USER is not set"
  exit 1
fi

# SMTP 계정 비밀번호
if [[ "$SMTP_PW" == "" ]]; then
  echo "SMTP_PW is not set"
  exit 1
fi

NAMESPACE=approval-system

cp secret.yaml.template secret.yaml
sed -i "s/<SMTP Address (IP:PORT)>/'${SMTP_SERVER}'/g" secret.yaml
sed -i "s/<SMTP User ID>/'${SMTP_USER}'/g" secret.yaml
sed - i"s/<SMTP User PW>/'${SMTP_PW}'/g" secret.yaml
kubectl apply --namespace ${NAMESPACE} -f secret.yaml
