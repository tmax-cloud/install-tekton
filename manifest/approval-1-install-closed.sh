#!/bin/bash

kubectl apply -f crd.yaml
kubectl apply -f namespace.yaml
kubectl apply -f service_account.yaml
kubectl apply -f role.yaml
kubectl apply -f role_binding.yaml
kubectl apply -f service.yaml
kubectl apply -f updated.yaml
