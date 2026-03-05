#!/usr/bin/env bash
set -euo pipefail

kubectl get secret -n monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
echo
