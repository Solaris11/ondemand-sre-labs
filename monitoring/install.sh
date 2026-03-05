#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="monitoring"
RELEASE="monitoring"

kubectl get ns "${NAMESPACE}" >/dev/null 2>&1 || kubectl create namespace "${NAMESPACE}"

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts >/dev/null
helm repo update >/dev/null

helm upgrade --install "${RELEASE}" prometheus-community/kube-prometheus-stack \
  -n "${NAMESPACE}"
