# Kubescape Installation 📡
## Windows

    choco install kubescape

## Bash

    curl -s https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh | /bin/bash

# Running the Kubescape 

    kubescape scan

You should get result similar to this:

```
 ✅  Initialized scanner
 ✅  Loaded policies
 ✅  Loaded exceptions
 ✅  Loaded account configurations
 ✅  Accessed Kubernetes objects
Control: C-0271 100% |████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| (47/47, 35 it/s)
 ✅  Done scanning. Cluster: kind-kindopa
 ✅  Done aggregating results


Security posture overview for cluster: 'kind-kind'

In this overview, Kubescape shows you a summary of your cluster security posture, including the number of users who can perform administrative actions. For each result greater than 0, you should evaluate its need, and then define an exception to allow it. This baseline can be used to detect drift in future.

Control plane
┌────┬─────────────────────────────────────┬────────────────────────────────────┐
│    │ Control name                        │ Docs                               │
├────┼─────────────────────────────────────┼────────────────────────────────────┤
│ ✅ │ API server insecure port is enabled │ https://hub.armosec.io/docs/c-0005 │
│ ❌ │ Anonymous access enabled            │ https://hub.armosec.io/docs/c-0262 │
│ ❌ │ Audit logs enabled                  │ https://hub.armosec.io/docs/c-0067 │
│ ✅ │ RBAC enabled                        │ https://hub.armosec.io/docs/c-0088 │
│ ❌ │ Secret/etcd encryption enabled      │ https://hub.armosec.io/docs/c-0066 │
└────┴─────────────────────────────────────┴────────────────────────────────────┘

Access control
┌────────────────────────────────────────────────────┬───────────┬────────────────────────────────────┐
│ Control name                                       │ Resources │ View details                       │
├────────────────────────────────────────────────────┼───────────┼────────────────────────────────────┤
│ Administrative Roles                               │     3     │ $ kubescape scan control C-0035 -v │
│ List Kubernetes secrets                            │    13     │ $ kubescape scan control C-0015 -v │
│ Minimize access to create pods                     │     4     │ $ kubescape scan control C-0188 -v │
│ Minimize wildcard use in Roles and ClusterRoles    │     3     │ $ kubescape scan control C-0187 -v │
│ Portforwarding privileges                          │     3     │ $ kubescape scan control C-0063 -v │
│ Prevent containers from allowing command execution │     3     │ $ kubescape scan control C-0002 -v │
│ Roles with delete capabilities                     │     6     │ $ kubescape scan control C-0007 -v │
│ Validate admission controller (mutating)           │     3     │ $ kubescape scan control C-0039 -v │
│ Validate admission controller (validating)         │     3     │ $ kubescape scan control C-0036 -v │
└────────────────────────────────────────────────────┴───────────┴────────────────────────────────────┘

Secrets
┌─────────────────────────────────────────────────┬───────────┬────────────────────────────────────┐
│ Control name                                    │ Resources │ View details                       │
├─────────────────────────────────────────────────┼───────────┼────────────────────────────────────┤
│ Applications credentials in configuration files │     1     │ $ kubescape scan control C-0012 -v │
└─────────────────────────────────────────────────┴───────────┴────────────────────────────────────┘

Network
┌────────────────────────┬───────────┬────────────────────────────────────┐
│ Control name           │ Resources │ View details                       │
├────────────────────────┼───────────┼────────────────────────────────────┤
│ Missing network policy │    16     │ $ kubescape scan control C-0260 -v │
└────────────────────────┴───────────┴────────────────────────────────────┘

Workload
┌─────────────────────────┬───────────┬────────────────────────────────────┐
│ Control name            │ Resources │ View details                       │
├─────────────────────────┼───────────┼────────────────────────────────────┤
│ Host PID/IPC privileges │     0     │ $ kubescape scan control C-0038 -v │
│ HostNetwork access      │     1     │ $ kubescape scan control C-0041 -v │
│ HostPath mount          │     1     │ $ kubescape scan control C-0048 -v │
│ Non-root containers     │    17     │ $ kubescape scan control C-0013 -v │
│ Privileged container    │     0     │ $ kubescape scan control C-0057 -v │
└─────────────────────────┴───────────┴────────────────────────────────────┘


Highest-stake workloads
───────────────────────

High-stakes workloads are defined as those which Kubescape estimates would have the highest impact if they were to be exploited.

1. namespace: kube-system, name: kindnet, kind: DaemonSet
   '$ kubescape scan workload DaemonSet/kindnet --namespace kube-system'
2. namespace: open, name: test-csv, kind: Pod
   '$ kubescape scan workload Pod/test-csv --namespace open'
3. namespace: open, name: nginx1, kind: Pod
   '$ kubescape scan workload Pod/nginx1 --namespace open'
```
