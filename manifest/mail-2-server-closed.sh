#!/bin/bash

NAMESPACE=approval-system
kubectl apply --namespace ${NAMESPACE} -f service.yaml
kubectl apply --namespace ${NAMESPACE} -f updated.yaml
