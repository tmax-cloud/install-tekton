#!/bin/bash

function prepare_tekton_trigger_online(){
  curl -s "https://storage.googleapis.com/tekton-releases/triggers/previous/$triggerVersion/release.yaml" -o yaml/trigger.yaml

  docker pull "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/controller:$triggerVersion"
  docker pull "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/webhook:$triggerVersion"
  docker pull "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/interceptors:$triggerVersion"
  docker pull "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/eventlistenersink:$triggerVersion"

  docker tag "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/controller:$triggerVersion" "trigger-controller:$triggerVersion"
  docker tag "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/webhook:$triggerVersion" "trigger-webhook:$triggerVersion"
  docker tag "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/interceptors:$triggerVersion" "trigger-interceptors:$triggerVersion"
  docker tag "gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/eventlistenersink:$triggerVersion" "trigger-eventlistenersink:$triggerVersion"

  docker save "trigger-controller:$triggerVersion" > "$install_dir/tar/trigger-controller-$triggerVersion.tar"
  docker save "trigger-webhook:$triggerVersion" > "$install_dir/tar/trigger-webhook-$triggerVersion.tar"
  docker save "trigger-interceptors:$triggerVersion" > "$install_dir/tar/trigger-interceptors-$triggerVersion.tar"
  docker save "trigger-eventlistenersink:$triggerVersion" > "$install_dir/tar/trigger-eventlistenersink-$triggerVersion.tar"
}

function prepare_tekton_trigger_offline(){
  docker load < "$install_dir/tar/trigger-controller-$triggerVersion.tar"
  docker load < "$install_dir/tar/trigger-webhook-$triggerVersion.tar"
  docker load < "$install_dir/tar/trigger-interceptors-$triggerVersion.tar"
  docker load < "$install_dir/tar/trigger-eventlistenersink-$triggerVersion.tar"

  docker tag "trigger-controller:$triggerVersion" "$imageRegistry/trigger-controller:$triggerVersion"
  docker tag "trigger-webhook:$triggerVersion" "$imageRegistry/trigger-webhook:$triggerVersion"
  docker tag "trigger-interceptors:$triggerVersion" "$imageRegistry/trigger-interceptors:$triggerVersion"
  docker tag "trigger-eventlistenersink:$triggerVersion" "$imageRegistry/trigger-eventlistenersink:$triggerVersion"

  docker push "$imageRegistry/trigger-controller:$triggerVersion"
  docker push "$imageRegistry/trigger-webhook:$triggerVersion"
  docker push "$imageRegistry/trigger-interceptors:$triggerVersion"
  docker push "$imageRegistry/trigger-eventlistenersink:$triggerVersion"
}

function install_tekton_trigger(){
  echo  "========================================================================="
  echo  "===================  Start Installing Tekton Trigger ===================="
  echo  "========================================================================="

  if [[ "$imageRegistry" == "" ]]; then
    kubectl apply -f "https://storage.googleapis.com/tekton-releases/triggers/previous/$triggerVersion/release.yaml" "$kubectl_opt"
  else
    sed -i -E "s/gcr.io\/tekton-releases\/.*\/([^@]*)@[^\n\"]*/$imageRegistry\/trigger-\1/g" "$install_dir/yaml/trigger.yaml"

    kubectl apply -f "$install_dir/yaml/trigger.yaml" "$kubectl_opt"
  fi
  echo  "========================================================================="
  echo  "================  Successfully Installed Tekton Trigger ================="
  echo  "========================================================================="
}

function uninstall_tekton_trigger(){
  echo  "========================================================================="
  echo  "==================  Start Uninstalling Tekton Trigger ==================="
  echo  "========================================================================="
  get_resources crd | grep '^[^\.]*\.triggers\.tekton\.dev' | awk '{print $1}' | while read line; do
    echo "Deleting $line"
    delete_resources "$line"
  done

  kubectl -n tekton-pipelines delete deployment tekton-triggers-core-interceptors "$kubectl_opt"
  kubectl -n tekton-pipelines delete deployment tekton-triggers-webhook "$kubectl_opt"
  kubectl -n tekton-pipelines delete deployment tekton-triggers-controller "$kubectl_opt"
  echo  "========================================================================="
  echo  "===============  Successfully Uninstalled Tekton Trigger ================"
  echo  "========================================================================="
}
