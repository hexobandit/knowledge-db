# Kubernetes Certified Security Associate (KCSA) Cheat Sheet

![image](https://github.com/user-attachments/assets/7320bafd-636c-4113-be74-cf310485858c)
source: https://kubernetes.io/images/docs/components-of-kubernetes.svg

## Overview of Cloud Native Security (14%) 🛰️
### The 4Cs of Cloud Native Security
- **Code, Container, Cluster, Cloud**: Security layers to address vulnerabilities.
- **Key Practice**: Secure each layer independently and collectively.

### Cloud Provider and Infrastructure Security
- Use private clusters and IAM policies.
- Encrypt data at rest and in transit (TLS 1.2+).
- Enable logging and audit trails for cloud services.

### Controls and Frameworks
- Use RBAC, Pod Security Standards, and Network Policies.
- Align with CIS Benchmarks, NIST CSF, and OWASP recommendations.

### Isolation Techniques
- Use namespaces for logical separation.
- Apply Network Policies for pod-to-pod traffic control.
- Use taints and tolerations to isolate workloads.

### Artifact Repository and Image Security
- Use private registries and automate image vulnerability scanning.
- Sign and verify images (e.g., Cosign).
- Use minimal, patched base images.

### Workload and Application Code Security
- Scan code and dependencies for vulnerabilities.
- Enforce Pod Security Standards (e.g., non-root users).
- Secure secrets with external tools (e.g., Vault).


## Kubernetes Cluster Component Security (22%) 🛰️
### API Server
Acts as the central management interface for Kubernetes. Validates and processes REST API requests, serving as the frontend for the cluster. Coordinates communication between all components.
- Enable RBAC, disable anonymous access.
- Restrict access to private networks.
- Use `--secure-port` and audit logging.

### Controller Manager
Runs control loops (e.g., node, deployment, replication controllers) to reconcile the cluster’s desired state with its actual state.
- Enable `--use-service-account-credentials`.
- Disable unused controllers.
- Use `--profiling=false`.

### Scheduler
Assigns pods to the most appropriate node based on resource availability and constraints like affinity/anti-affinity rules.
- Restrict access with secure kubeconfig.
- Enable leader election.
- Disable profiling endpoints.

### Kubelet
Runs on each node and ensures that containers in pods are running as specified. Communicates with the container runtime to start, stop, and monitor containers.
- Require authentication and disable anonymous access.
- Enforce secure pod configurations (`runAsNonRoot=true`).

### Container Runtime
The software that runs containers, such as Docker, containerd, or CRI-O. Works with the Kubelet to manage container lifecycles.
- Use non-root containers and minimal images.
- Scan for runtime vulnerabilities.
- Restrict runtime privileges.

### KubeProxy
Manages network rules to route and load balance traffic to pods. Configures networking on nodes for pod communication.
- Use secure API communication.
- Restrict node traffic with firewalls.
- Monitor logs for unusual patterns.

### Pod
The smallest deployable unit in Kubernetes, encapsulating one or more containers. Runs on a node and shares resources like network and storage.
- Enforce Pod Security Standards (`restricted` profile).
- Disable privilege escalation.
- Use resource limits (`CPU`, `memory`).

### Etcd
A distributed key-value store that stores all cluster configuration and state data. Acts as the “brain” of Kubernetes, backing up its entire state.
- Encrypt data at rest and enforce TLS.
- Limit access with firewalls.
- Back up regularly and test restores.

### Container Networking
Provides communication between pods and external services. Implements networking via CNI plugins like Calico or Cilium.
- Apply Network Policies for pod-to-pod and external traffic.
- Use secure CNI plugins with mTLS.

### Client Security
Refers to securing access to Kubernetes via tools like kubectl or API calls. Includes proper use of kubeconfig files, RBAC, and certificate rotation.
- Use kubeconfig with unique credentials per user.
- Rotate tokens and certificates periodically.
- Avoid sharing kubeconfigs.

### Storage
Integrates persistent storage with pods using Persistent Volumes (PVs) and Persistent Volume Claims (PVCs). Supports dynamic and static provisioning of storage from providers like Azure, AWS, or GCP.
- Use CSI drivers and encrypt volumes.
- Limit PVC access to namespaces.
- Monitor for unauthorized access.


## Kubernetes Security Fundamentals (22%) 🛰️
### Pod Security Standards
- Apply Baseline, Restricted, or Privileged profiles.
- Enforce policies using Pod Security Admission.

### Pod Security Admissions
- Enable `PodSecurity` admission plugin for rule enforcement.

### Authentication
- Use certificates, OIDC, or tokens for secure access.

### Authorization
- Implement RBAC for least privilege access.
- Audit roles and bindings periodically.

### Secrets
- Store secrets securely using CSI drivers or external tools.
- Avoid secrets in environment variables or images.

### Isolation and Segmentation
- Use namespaces, Network Policies, and taints for isolation.

### Audit Logging
- Enable API server audit logging for traceability.

### Network Policy
- Restrict ingress and egress traffic with Network Policies.


## Kubernetes Threat Model (16%) 🛰️
### Kubernetes Trust Boundaries and Data Flow
- Understand API server, nodes, and pod interactions.
- Trust boundaries (Internet, API Server, Master Components (kube-controller-manager, cloud-controller-manager), Master Data (etcd), Worker (kubelet, kubeproxy), Container)

### Persistence
- Protect cluster data by securing etcd and RBAC.

### Denial of Service
- Enforce resource limits on pods to prevent overuse.
- LimitRange - CPU and memory limits per pod or container
- ResourceQuota - CPU and memory limits per namespace

### Malicious Code Execution
- Use vulnerability scanning tools and enforce non-root containers.

### Attacker on the Network
- Use mTLS for pod communication and restrict CIDR access.

### Access to Sensitive Data
- Encrypt data at rest and in transit.
- Restrict secret access with RBAC.

### Privilege Escalation
- Disable privilege escalation and use restricted profiles.

---

## Platform Security (16%) 🛰️
### Supply Chain Security
- Use signed images and scan for vulnerabilities in CI/CD pipelines.

### Image Repository
- Use private registries with access control and audit logs.

### Observability
- Use tools like Prometheus and Grafana for monitoring.
- Enable API server and controller logs.

### Service Mesh
- Enforce mTLS and secure pod-to-pod communication.

### PKI
- Use strong TLS certificates for secure communication.

### Connectivity
- Restrict API server and Kubelet endpoints to private networks.

### Admission Control
- Use OPA or Kyverno for policy enforcement on resource creation.


## Compliance and Security Frameworks (10%) 🛰️
### Compliance Frameworks
- Implement CIS Benchmarks, PCI DSS, HIPAA, or GDPR requirements.

### Threat Modelling Frameworks
- Use STRIDE or DREAD to identify and prioritize threats.

### Supply Chain Compliance
- Verify artifacts with SBOMs and enforce trusted sources.

### Automation and Tooling
- Use Falco, Trivy, and kube-bench for automation and continuous scanning.
