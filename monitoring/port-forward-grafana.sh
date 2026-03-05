#!/usr/bin/env bash
set -euo pipefail

kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
