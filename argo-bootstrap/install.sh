#!/bin/bash

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo/argo-cd --namespace argocd --create-namespace --values values-initial-argo.yaml

# helm upgrade argocd -n argocd argo/argo-cd -f values-initial-argo.yaml
