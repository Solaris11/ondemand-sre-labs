# OnDemand SRE Reliability Lab

Production-style reliability engineering lab used to simulate failure scenarios, test observability pipelines, and demonstrate incident response patterns.

This lab environment is used to reproduce real-world reliability challenges such as:

- Kubernetes service failures
- regional failover simulations
- traffic spikes and load testing
- monitoring and alerting pipelines
- incident response workflows

The goal is to demonstrate practical Site Reliability Engineering techniques used to improve system resilience.

---

# Architecture

The lab simulates a multi-region production system.

Components include:

- Kubernetes clusters (k3d)
- NGINX services
- Prometheus monitoring
- Grafana dashboards
- Alertmanager alerts
- k6 load testing
- chaos failure simulation

Example architecture:

![Reliability Lab Architecture](../ondemand-sre-web/public/reliability-lab-architecture.png)

---

# Lab Scenarios

The lab is used to simulate real reliability incidents such as:

### Pod failure simulation

kubectl delete pod demo-app-xxxx


Observability dashboards capture:

- request spikes
- latency increases
- error rate changes

---

### Traffic load simulation

k6 run load-test.js


This generates controlled traffic load to observe system behavior.

---

### Failover experiments

Failure drills simulate regional service degradation and recovery patterns.

These experiments help test:

- alert accuracy
- system resilience
- recovery automation

---

# Repository Structure

ondemand-sre-labs
│
├── k8s
│ └── demo-app.yaml
│
├── monitoring
│
├── load-testing
│
├── chaos
│
└── README.md


---

# Purpose

This repository supports the **OnDemand SRE** consulting platform.

It demonstrates practical reliability engineering practices including:

- observability-driven operations
- incident simulation
- production failure analysis
- resilience testing

---

# Website

https://ondemandsre.com

---

# License

MIT

