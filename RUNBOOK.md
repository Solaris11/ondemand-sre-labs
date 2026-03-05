SRE Runbook

This runbook describes operational procedures for troubleshooting the reliability lab environment.

Purpose
Provide production-style checks for service reachability, metrics availability, HPA behavior, and observability validation.

Quick Commands
Check Pods

CMD: kubectl get pods -l app=demo

Check Service

CMD: kubectl get svc demo-service

Port Forward Service

CMD: kubectl port-forward svc/demo-service 8080:80

Run Load Test

CMD: k6 run load-testing/k6-load-test.js

Check Metrics

CMD: kubectl top pods -l app=demo

Check HPA

CMD: kubectl get hpa

Describe HPA

CMD: kubectl describe hpa demo-app

Watch Pods

CMD: kubectl get pods -l app=demo -w

Watch HPA

CMD: kubectl get hpa -w

Verify Deployment
Confirm Pods

CMD: kubectl get pods -l app=demo

Confirm Service Exists

CMD: kubectl get svc demo-service

If Service Is Missing

CMD: kubectl apply -f k8s/demo-app.yaml

Verify Service Reachability
Start Port Forward

CMD: kubectl port-forward svc/demo-service 8080:80

Confirm HTTP Response

CMD: curl -I http://localhost:8080

Symptom: Connection Refused in k6

If k6 reports connect: connection refused, the port-forward is not running or the local port is not listening.

Confirm Local Listener

CMD: lsof -nP -iTCP:8080 -sTCP:LISTEN

Verify Metrics Availability
Confirm Metrics API Works

CMD: kubectl top pods -l app=demo

Why This Matters

HPA requires metrics to compute utilization. If metrics are unavailable, HPA will not scale.

Verify HPA Status
Check Current HPA

CMD: kubectl get hpa

Inspect Events and Conditions

CMD: kubectl describe hpa demo-app

What To Look For

Current CPU utilization vs target, scaling events, min and max replica constraints, and any warnings.

Verify CPU Requests Are Defined
Check Deployment Resources

CMD: kubectl get deploy demo-app -o jsonpath='{.spec.template.spec.containers[0].resources}'; echo

Expected Result

Resources should not be empty. If resources are empty, HPA utilization targets may be unknown or inaccurate.

Fix

Update k8s/demo-app.yaml to include CPU requests and re-apply.

Observe Scaling Behavior
Watch Pods During Load

CMD: kubectl get pods -l app=demo -w

Watch HPA Targets and Replicas

CMD: kubectl get hpa -w

Expected Behavior Under Load

HPA targets exceed threshold and replicas increase up to the configured maximum.

Run Load Test
Ensure Service Port Forward Is Running

CMD: kubectl port-forward svc/demo-service 8080:80

Start Load

CMD: k6 run load-testing/k6-load-test.js

Confirm CPU Changes

CMD: kubectl top pods -l app=demo

Verify Observability
Access Grafana

CMD: kubectl get svc -n monitoring | grep grafana
CMD: kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80

Validate In Grafana

Confirm CPU utilization rises during k6 load, pod count changes during scaling, and dashboards show the scaling event.

Evidence Files

PATH: assets/autoscaling-grafana.png
PATH: assets/hpa-output.png

Common Issues
HPA Shows cpu: <unknown>

Check metrics availability and CPU requests.

CMD: kubectl top pods -l app=demo
CMD: kubectl get deploy demo-app -o jsonpath='{.spec.template.spec.containers[0].resources}'; echo
CMD: kubectl describe hpa demo-app

HPA Does Not Scale Up

Confirm traffic reaches the service, CPU increases, and HPA target is configured correctly.

CMD: curl -I http://localhost:8080

CMD: kubectl top pods -l app=demo
CMD: kubectl describe hpa demo-app

Simulate Failure
Delete a Pod

CMD: kubectl delete pod -l app=demo

Expected Result

Kubernetes recreates pods to maintain desired replicas and service remains available if replicas are greater than one.

Key Concepts

Demonstrated Concepts
Kubernetes workload management, autoscaling under load, observability, synthetic traffic generation, and self-healing.
