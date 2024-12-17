# Various Kubernetes Commands and Scripts

## List all pods from all namespaces and their containers 📦

    $kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{"\n"}{"NAMESPACE: "}{.metadata.namespace}{"\n"}{"POD NAME: "}{.metadata.name}{"\n"}{"CONTAINER NAMES:"}{range .spec.containers[*]}{"\n"}{.name}{end}{end}'

### Expected results:

```
NAMESPACE: default
POD NAME: kali-latest
CONTAINER NAMES:
kali-latest
NAMESPACE: default
POD NAME: nginx-latest
CONTAINER NAMES:
nginx-latest
NAMESPACE: kube-system
POD NAME: aws-node-7nznw
CONTAINER NAMES:
aws-node
aws-eks-nodeagent
```

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

## Inspect Containers 👾
Container introspection tool. Find out what container runtime is being used as well as features available.

    cd /tmp; curl -L -o amicontained https://github.com/genuinetools/amicontained/releases/download/v0.4.7/amicontained-linux-amd64; chmod 555 amicontained; ./amicontained

### Results:

```
Container Runtime: kube
Has Namespaces:
        pid: true
        user: false
AppArmor Profile: unconfined
Capabilities:
        BOUNDING -> chown dac_override fowner fsetid kill setgid setuid setpcap net_bind_service net_raw sys_chroot mknod audit_write setfcap
Seccomp: filtering
Blocked Syscalls (16):
        SYSLOG SETSID VHANGUP PIVOT_ROOT ACCT SETTIMEOFDAY SWAPON SWAPOFF REBOOT SETHOSTNAME SETDOMAINNAME INIT_MODULE DELETE_MODULE FANOTIFY_INIT OPEN_BY_HANDLE_AT FINIT_MODULE
```
