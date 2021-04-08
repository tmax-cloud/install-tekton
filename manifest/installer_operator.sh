#!/bin/bash

function prepare_cicd_operator_online(){
  curl -s "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/release.yaml" -o "$install_dir/yaml/operator.yaml"

  sudo docker pull "tmaxcloudck/cicd-operator:$operatorVersion"
  sudo docker tag "tmaxcloudck/cicd-operator:$operatorVersion" "cicd-operator:$operatorVersion"
  sudo docker save "cicd-operator:$operatorVersion" > "$install_dir/tar/cicd-operator-$operatorVersion.tar"
}

function prepare_cicd_operator_offline(){
  sudo docker load < "$install_dir/tar/cicd-operator-$operatorVersion.tar"
  sudo docker tag "cicd-operator:$operatorVersion" "$imageRegistry/cicd-operator:$operatorVersion"
  sudo docker push "$imageRegistry/cicd-operator:$operatorVersion"
}

function install_cicd_operator(){
  echo  "========================================================================="
  echo  "===================  Start Installing CI/CD Operator ===================="
  echo  "========================================================================="
  # Set tekton config
  kubectl -n tekton-pipelines patch configmap feature-flags --type merge -p '{"data": {"enable-custom-tasks": "true", "disable-affinity-assistant": "true"}}' "$kubectl_opt"

  if [[ "$imageRegistry" == "" ]]; then
    kubectl apply -f "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/release.yaml" "$kubectl_opt"
  else
    sed -i -E "s/tmaxcloudck\/([^\n\"]*)/$imageRegistry\/\1/g" "$install_dir/yaml/operator.yaml"

    kubectl apply -f "$install_dir/yaml/operator.yaml" "$kubectl_opt"
  fi

  kubectl -n cicd-system patch configmap cicd-config --type merge -p '{"data": {"ingressClass": "nginx-shd"}}' "$kubectl_opt"
  echo  "========================================================================="
  echo  "================  Successfully Installed CI/CD Operator ================="
  echo  "========================================================================="
}

function uninstall_cicd_operator(){
  echo  "========================================================================="
  echo  "==================  Start Uninstalling CI/CD Operator ==================="
  echo  "========================================================================="
  get_resources crd | grep '^[^\.]*\.cicd\.tmax\.io' | awk '{print $1}' | while read line; do
    echo "Deleting $line"
    delete_resources "$line"
  done

  kubectl -n cicd-system delete deployment cicd-operator "$kubectl_opt"
  echo  "========================================================================="
  echo  "===============  Successfully Uninstalled CI/CD Operator ================"
  echo  "========================================================================="
}
