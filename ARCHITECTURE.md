# Reliability Lab Architecture

This document describes the architecture of the SRE reliability lab used to demonstrate autoscaling, observability, and system behavior under load in Kubernetes.

The goal of this lab is to simulate real-world reliability engineering scenarios including traffic spikes, monitoring, and automatic scaling.

---

## Repository Layout

- `k8s/demo-app.yaml` — Demo app Deployment + Service
- `load-testing/k6-load-test.js` — k6 script used to generate synthetic traffic
- `monitoring/install.sh` — Monitoring stack install script (Prometheus + Grafana)
- `monitoring/port-forward-grafana.sh` — Convenience port-forward script for Grafana
- `monitoring/grafana-password.sh` — Helper script to retrieve Grafana admin password
- `diagrams/reliability-lab-architecture.png` — Architecture diagram
- `assets/autoscaling-grafana.png` — Grafana evidence screenshot
- `assets/hpa-output.png` — HPA evidence screenshot
- `README.md` — Overview + labs + evidence
- `RUNBOOK.md` — Troubleshooting and operational procedures

---

## System Components

### Kubernetes Cluster

The demo application runs inside a Kubernetes cluster.

Kubernetes responsibilities:

- scheduling containers
- managing deployments
- restarting failed pods
- scaling workloads

---

### Demo Application

A simple NGINX container is deployed as the application workload.

Deployment characteristics:

- multiple replicas
- exposed via Kubernetes Service
- monitored for CPU usage

---

### Prometheus

Prometheus collects metrics from the Kubernetes cluster including:

- pod CPU usage
- pod memory usage
- namespace metrics
- container resource consumption

These metrics are used to understand system behavior during load tests.

---

### Grafana

Grafana visualizes the metrics collected by Prometheus.

Dashboards provide visibility into:

- CPU usage
- memory usage
- pod count
- autoscaling behavior

This allows engineers to observe system behavior in real time.

---

### k6 Load Testing

k6 is used to generate synthetic traffic to the Kubernetes service.

The load test simulates user traffic and increases CPU usage within the pods.

This allows us to observe:

- system behavior under load
- scaling events
- resource consumption

---

### Horizontal Pod Autoscaler (HPA)

The Horizontal Pod Autoscaler automatically increases or decreases the number of pods based on CPU utilization.

Example configuration:

- minimum pods: 2
- maximum pods: 10
- target CPU utilization: 20%

When CPU usage exceeds the threshold, Kubernetes automatically creates additional pods.

---

## Architecture Diagram

![Reliability Lab Architecture](diagrams/reliability-lab-architecture.png)

---

## Request Flow
````markdown
User Traffic
↓
k6 Load Generator (load-testing/k6-load-test.js)
↓
Kubernetes Service (demo-service)
↓
Pods (demo-app)
↓
Metrics
↓
Prometheus → Grafana Dashboard
↓
HPA scales pods based on CPU utilization
````

---

## Operational Evidence

- Grafana metrics screenshot: `assets/autoscaling-grafana.png`
- HPA scaling output screenshot: `assets/hpa-output.png`

---

## Autoscaling Behavior

Under heavy load:

- CPU utilization increases
- HPA detects threshold breach
- Kubernetes creates additional pods
- replicas increase (e.g., 2 → 10)

This demonstrates Kubernetes' ability to automatically maintain service availability during traffic spikes.

---

## Observability

The monitoring stack provides visibility into:

- resource utilization
- scaling events
- pod lifecycle
- application performance

Observability is a core principle of Site Reliability Engineering.
