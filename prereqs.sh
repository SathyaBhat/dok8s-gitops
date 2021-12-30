#!/bin/bash

## install ambassador 
kubectl apply -f https://www.getambassador.io/yaml/aes-crds.yaml && kubectl wait --for condition=established --timeout=90s crd -lproduct=aes && kubectl apply -f https://www.getambassador.io/yaml/aes.yaml && kubectl -n ambassador wait --for condition=available --timeout=90s deploy -lproduct=aes


## install cert manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.0.0/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io && helm repo update
kubectl create ns cert-manager
helm install cert-manager --namespace cert-manager jetstack/cert-manager

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v1.7.6/manifests/install.yaml

kubectl apply -f apps/manifests/ambassador-tls.yaml
kubectl apply -f apps/manifests/ambassador-service.yaml
kubectl apply -f apps/manifests/argocd-ambassador.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.16.0/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/previous/v0.8.1/release.yaml


kubectl create configmap config-artifact-pvc \
--from-literal=size=10Gi \
--from-literal=storageClassName=do-block-storage \
-o yaml -n tekton-pipelines \
--dry-run=true | kubectl replace -f -

argocd repo add https://github.com/SathyaBhat/tekton-pipeline-example-app --username $SCM_USERNAME --password $SCM_PAT
argocd repo add https://github.com/SathyaBhat/tekton-pipeline-example-pipeline --username $SCM_USERNAME --password $SCM_PAT

argocd app create tekton-pipeline-app --repo https://github.com/SathyaBhat/tekton-pipeline-example-pipeline --path tekton-pipeline --dest-server https://kubernetes.default.svc --dest-namespace tekton-argocd-example
argocd app create 2048-game-app --repo https://github.com/SathyaBhat/tekton-pipeline-example-app --path kustomize --dest-server https://kubernetes.default.svc --dest-namespace game-2048 --sync-option CreateNamespace=true