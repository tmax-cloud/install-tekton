#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/crds/tmax.io_approvals_crd.yaml
kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/service_account.yaml
kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/role.yaml
kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/role_binding.yaml
kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/service.yaml
kubectl apply -f https://raw.githubusercontent.com/tmax-cloud/approval-watcher/master/deploy/proxy-server.yaml
