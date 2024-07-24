# Various Kubernetes Commands and Scripts

## Get Root Containers 📦
### Motivation:
Running Kubernetes containers as root can lead to security vulnerabilities and malicious attacks, 
as well as unintended changes to the host system. It's best to avoid running containers 
as root and use a non-root user with minimal privileges instead.

### What does it do:
This script retrieves a JSON output of all pods in a Kubernetes cluster and checks 
if any of the containers are running as root by examining their security context. 
It then outputs the namespace, pod name, container name, and whether it's running as root or not.

### Script

    kubectl get pods --all-namespaces -o json | jq -r '.items[] | {ns: .metadata.namespace, pod: .metadata.name, containers: .spec.containers[]} | "Namespace: \(.ns) - Pod: \(.pod) - Container: \(.containers.name) - Running as root: \(.containers.securityContext.runAsUser == 0 or .containers.securityContext.runAsUser == null)"'

### Results:

```
Namespace: default - Pod: kali-latest - Container: kali-latest - Running as root: true
Namespace: default - Pod: nginx-latest - Container: nginx-latest - Running as root: true
Namespace: kube-system - Pod: aws-node-7nznw - Container: aws-node - Running as root: true
Namespace: kube-system - Pod: aws-node-7nznw - Container: aws-eks-nodeagent - Running as root: true
Namespace: kube-system - Pod: coredns-6f6d89bcc9-j7q2j - Container: coredns - Running as root: true
Namespace: kube-system - Pod: coredns-6f6d89bcc9-rbh2x - Container: coredns - Running as root: true
Namespace: kube-system - Pod: eks-pod-identity-agent-kdctc - Container: eks-pod-identity-agent - Running as root: true
Namespace: kube-system - Pod: kube-proxy-czh57 - Container: kube-proxy - Running as root: true
```
