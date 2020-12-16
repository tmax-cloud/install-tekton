#!/bin/bash

NAMESPACE=approval-system
kubectl apply --namespace ${NAMESPACE} --filename https://raw.githubusercontent.com/cqbqdd11519/mail-notifier/master/deploy/service.yaml
kubectl apply --namespace ${NAMESPACE} --filename https://raw.githubusercontent.com/cqbqdd11519/mail-notifier/master/deploy/server.yaml
