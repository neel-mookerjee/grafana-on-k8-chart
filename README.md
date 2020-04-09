# Grafana on K8
This simple helm chart deploys a stateless Grafana deployment on K8

# Makefile
```
Grafana upgrade/tiller   Upgrade tiller to the latest version.
Grafana upgrade/stack    Deploy stack into kubernetes. vars: stack
Grafana install/stack    Deploy stack into kubernetes. vars: stack
Grafana open/ui          Open stack in browser. vars: stack
Grafana install/debug    View all variables and configs generated before deployment. vars: stack
Grafana delete/stack     delete stack from reference
```
