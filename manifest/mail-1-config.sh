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

curl https://raw.githubusercontent.com/cqbqdd11519/mail-notifier/master/deploy/secret.yaml.template -s | \
sed "s/<SMTP Address (IP:PORT)>/'${SMTP_SERVER}'/g" | \
sed "s/<SMTP User ID>/'${SMTP_USER}'/g" | \
sed "s/<SMTP User PW>/'${SMTP_PW}'/g" | \
kubectl apply --namespace ${NAMESPACE} -f -
