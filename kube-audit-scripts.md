# Kubernetes Audit Scripts

## Get Root Containers 📦

### Motivation:
Running Kubernetes containers as root can lead to security vulnerabilities and malicious attacks, 
as well as unintended changes to the host system. It's best to avoid running containers 
as root and use a non-root user with minimal privileges instead.

### What does it do:
This script retrieves a JSON output of all pods in a Kubernetes cluster and checks 
if any of the containers are running as root by examining their security context. 
It then outputs the namespace, pod name, container name, and whether it's running as root or not.

### Script1

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

### Script2
    kubectl get pods --all-namespaces -o custom-columns="NAMESPACE:.metadata.namespace,POD:.metadata.name,CONTAINER:.spec.containers[*].name,RUN_AS_ROOT:.spec.containers[*].securityContext.runAsUser"

```
NAMESPACE    POD               CONTAINER     RUN_AS_ROOT
default      my-pod            my-container  <none>
flux-system  another-pod       app           0
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

Well that`s interestin.. While some key security features are present (PID namespace, Seccomp filtering), the lack of user namespace isolation, unconfined AppArmor, and excessive capabilities create potential vulnerabilities.

- Namespaces
    - pid: true:
        - Process namespace isolation is enabled, meaning processes inside the container are isolated from processes on the host.
        - This is standard for containers and ensures better security by preventing access to host processes.
    - user: false:
        - User namespace isolation is not enabled.
        - This means the container’s user IDs (UID/GID) map directly to the host system’s user IDs.
        - **Risk**: If the container is running as root (UID 0), it also has root access on the host unless mitigated by other mechanisms.
        - **Recommendation**: Enable user namespace isolation to map container user IDs to non-privileged host user IDs.

- AppArmor Profile
    - unconfined:
        - todo

## Verify PSA Settings 📰
Start with the api-server configuration:

    kubectl get pods -A | grep api
    kubectl describe pod kube-apiserver-control-plane -n kube-system | grep -- --enable-admission-plugin

### Expected Results:

    --enable-admission-plugins=NodeRestriction,PodSecurity

- However from Kubernetes 1.23 onward, PSA is enabled by default unless explicitly disabled.
- Even if the PodSecurity isnt't listed in `--enable-admission-plugins` it can still enforce profiles based on ns annotations.

### Check ns annotations for `pod-security`
Run either of these two commands:

    kubectl describe namespace flux-system
    kubectl get namespaces flux-system -o json

and look for: 

    "pod-security.kubernetes.io/enforce": "restricted",
    "pod-security.kubernetes.io/enforce-version": "latest"

For all the namespaces do:
### Verify Pod Security Admission Configuration 👈
The command checks for PSA-related labels on namespaces. These labels control how PSA enforces the PSS (Pod Security Standards) for that namespace. 

    kubectl get namespaces -o custom-columns="NAMESPACE:.metadata.name,ENFORCE:.metadata.labels.pod-security\.kubernetes\.io/enforce,AUDIT:.metadata.labels.pod-security\.kubernetes\.io/audit,WARN:.metadata.labels.pod-security\.kubernetes\.io/warn"

Please note: Check the previous -o json results to observe where is the `pod-security` layered. E.g., it could be `annotations`

### Expected Results: 🥳
```
NAMESPACE               ENFORCE      AUDIT        WARN
default                 <none>       <none>       <none>
flux-system             <none>       <none>       restricted
gatekeeper-system       restricted   restricted   restricted
open                    <none>       <none>       <none>
```

## Other Useful Things

Don`t know cluster name?

     kubectl config current-context

