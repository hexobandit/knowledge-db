# Kubescape 📡
## Installation 

Windows

    choco install kubescape

Bash

    curl -s https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh | /bin/bash

Mac

    brew install kubescape

## Running the Kubescape 

    kubescape scan --verbose

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

## Kubescape Running in the Cluster 🎥

### Installation via Helm
(change `clusterName=kind-kindopa`)

    helm repo add kubescape https://kubescape.github.io/helm-charts/
    helm repo update
    helm upgrade --install kubescape kubescape/kubescape-operator -n kubescape --create-namespace --set clusterName=kind-kindopa --set capabilities.continuousScan=enable
    kubectl get pods -n kubescape

Expected results:
```
kubescape               kubescape-5587d4fb4f-cqtkp                          1/1     Running             0              92s
kubescape               kubevuln-8784f7575-fsx8n                            0/1     Running             0              92s
kubescape               node-agent-vnj6x                                    0/1     Running             0              93s
kubescape               operator-688fd945fb-pzkmp                           0/1     ContainerCreating   0              92s
kubescape               storage-6df8cc57d5-vxjw5                            0/1     ContainerCreating   0              92s
```

### Getting vuln sammaries:
Run this:

    kubectl get vulnerabilitymanifestsummaries -A
    
Which gets you something like:
```
NAMESPACE            NAME                                            CREATED AT
open                 pod-nginx1-                                     2024-12-18T15:06:19Z
```

Then you continue with:

    kubectl describe vulnerabilitymanifestsummaries pod-nginx1- -n open

Which will finally get you something like this:
```
Name:         pod-nginx1-
Namespace:    open
Labels:       kubescape.io/context=filtered
              kubescape.io/image-id=docker-io-library-nginx-sha256-fb197595ebe76b9c0c14ab68159fd3c0
Annotations:  kubescape.io/image-id: docker.io/library/nginx@sha256:fb197595ebe76b9c0c14ab68159fd3c08bd067ec62300583543f0ebda353b5be
              kubescape.io/image-tag: nginx:latest
API Version:  spdx.softwarecomposition.kubescape.io/v1beta1
Kind:         VulnerabilityManifestSummary
Metadata:
  Creation Timestamp:  2024-12-18T15:06:19Z
  Resource Version:    4
  UID:                 1a95d494-4ba1-4328-852f-09b68a57d6ca
Spec:
  Severities:
    Critical:
      All:  2
    High:
      All:  9
    Low:
      All:  7
  Vulnerabilities Ref:
    All:
      Kind:       vulnerabilitymanifests
      Name:       docker.io-library-nginx-latest-53b5be
      Namespace:  open
    Relevant:
      Kind:       vulnerabilitymanifests
      Name:       pod-nginx1-nginx1-85c4-4652
      Namespace:  open
Status:
Events:  <none>    
```

### Now Let`s get detailed vuln report:

    kubectl get vulnerabilitymanifests -A

Which get you something like:
```
NAMESPACE   NAME                                                                        CREATED AT
kubescape   pod-nginx1-nginx1-85c4-4652                                                 2024-12-18T15:05:57Z
```

Then you continue with this:

    kubectl describe vulnerabilitymanifest pod-nginx1-nginx1-85c4-4652 -n kubescape

Which will finally get you all the beefy details you are after.

If you like JSON you can do this:

    kubectl get vulnerabilitymanifest -A -o json

Or if you like to dig through logs:

    kubectl logs operator-688fd945fb-pzkmp -n kubescape
    
    
