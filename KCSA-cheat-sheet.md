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
- https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K01-insecure-workload-configurations
   - hostPID
   - hostIPC
   - hostNetwork
   - secureContext


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
Runs on each node and ensures that containers in pods are running as specified. Communicates with the container runtime to start, stop, and monitor containers. Ensures containers in pods are running but **doesn’t assign pods to nodes**.
- Require authentication and disable anonymous access.
- Enforce secure pod configurations (`runAsNonRoot=true`).
- The `--anonymous-auth=false` flag disables anonymous access to the Kubelet API, ensuring that only authenticated requests are allowed.

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





## Sample Random Questions 🥳👍
https://kubernetes-security-kcsa-mock.vercel.app 👈

- Which command can be used to list all ServiceAccounts in the 'dev' namespace?
   - `kubectl get sa -n dev`, `kubectl get serviceaccounts --namespace=dev`

- Which command lists all processes listening on TCP and UDP ports?
   - `netstat -tuln` or `ss -tuln`

- Which Kubernetes resource can be used to set up a Pod with multiple containers that share the same network namespace
  - Pod

- Which field in a container's securityContext prevents processes from gaining elevated privileges?
  - `allowPrivilegeEscalation: false`

- Why is it recommended to use Kubernetes network policies?
  - To enforce network segmentation and limit pod communication

- Which command is used to generate a private key for a new Kubernetes user?
  - `openssl genrsa -out user.key 2048`

- Which STRIDE category is primarily concerned with availability? <<
  - `Denial of Service`

- Which folders on a client machine are sensitive when accessing Kubernetes clusters?
  - `~/.kube/config` and `~/.ssh/`

- How can you list all resources in a namespace?
  - `kubectl get all --namespace=<namespace>`

- Which command can you use to check the version of the kube-apiserver?
  - `kubectl version`

- Which of the following is a characteristic of hard multi-tenancy in Kubernetes?
   - Physical isolation of cluster control planes
 
- Which command lists all pods in all namespaces?
   - `kubectl get pods -A`

- Which of the following best describes the Kubernetes Ingress resource?
   - It manages external access to services, typically HTTP

- In managed Kubernetes services, who manages the etcd cluster?
   -  The cloud provider manages etcd
     
- Which Kubernetes object can be used to limit the number of concurrent requests to the API server?
   - There is no such object

- How can resources be isolated in a multi-tenancy Kubernetes setting?
   - Using separate clusters for each tenant, Implementing namespaces and RBAC, Applying network policies

- After generating a CSR and signing it with the cluster CA, how do you configure kubectl to use the new certificate for user 'alice'?
   - `kubectl config set-credentials alice --client-certificate=alice.crt --client-key=alice.key`

- Which flags should be set to 'false' to minimize the attack surface on the Kubernetes scheduler?
   - `--port` and `--address` and `--profiling=false`

- What is the purpose of the 'kubeadm' tool? 
   - To bootstrap Kubernetes clusters

- Why is setting resource limits and requests for Kubernetes pods important to prevent internal Denial of Service scenarios?
   - To prevent a single pod from consuming excessive resources, impacting overall cluster stability

- What is the primary security advantage of using client certificate authentication for Kubernetes API server?
   - To provide a secure method of authentication that minimizes the risk of credentials theft
 
- Which of the following is a key benefit of implementing a Service Mesh in a cloud-native application architecture from a security perspective?
   - Enhanced traffic encryption and fine-grained access control

- What is a key security measure for the Kubernetes Controller Manager to prevent unauthorized control ofcluster components?
   - Enabling Role-Based Access Control (RBAC) for the Controller Manager's operations

- Why is it important to enable and configure Kubelet client certificate rotation in a Kubernetes cluster?
   - To enhance security through regular updating of authentication credentialsCorrect Answer: D Explanation/Reference: 

- What is the role of a Certificate Authority (CA) in the PKI setup of a Kubernetes cluster?
   - To issue and manage digital certificates for secure communication within the cluster
 
- In Kubernetes, why is it important to configure Pod Security Admissions to audit mode?
   - To evaluate the impact of proposed security policies without enforcing them

- Why is pod isolation crucial in a multi-tenant Kubernetes environment?
   - To prevent a compromised or malicious pod in one tenant environment from affecting others

- Which security practice is most effective in preventing unauthorized or compromised container images frombeing deployed in a Kubernetes environment?
   - Enforcing image scanning and vulnerability assessment. Implementing CI/CD pipelines is a best practice for efficient software delivery but does not inherently include measures toprevent the deployment of compromised container images.
 
- Which component of the 4Cs of Cloud Native Security is directly responsible for implementing securitypolicies and controls within the application code to prevent vulnerabilities?
   - Code Security
 
=====

- runAsUser: 0 within kind: Pod is what OWASP top 10?
   - Insecure Workload Configuration

- What is the outcome of failing of pod kube-controller?

- How does two container within same pod comunicates outside?

- How do i restric elevation of privilages on namespace?

- Api server provides server certificate or root certificate to its clients?
   - The Kubernetes API server provides a server certificate to its clients to establish a secure connection (via TLS). This server certificate is signed by a Certificate Authority (CA), and the CA’s root certificate is distributed to the clients for verification.

- How does pod communicates with node? If hacker would want to observe all communication? What he would leverage on? hostNetwork or hostIPC?

- Isolation techniques in a multi-tenant Kubernetes environment?

- etcd can communicate with what other resources within kubernetes?
   - The API server is the only component that directly interacts with etcd.
 
- gVisor vs Firecracker
   - gVisor = Application-level sandbox = provides secure isolation for containerized applications by implementing a user-space kernel.
   - Firecracker = Virtual machine monitor (VMM)= Designed to run lightweight virtual machines (microVMs) for secure and isolated workloads.
 
- How to enable appArmor
   - Enable AppArmor on the Node
   - Create an AppArmor Profile
   - Apply AppArmor Profile to a Pod
   - Verify AppArmor is Applied

- Which framework describes self hosted and cloud hosted benchmarks?

- Securing each Kubernetes component 👈
   TODO via my app : defenseModeling : https://github.com/hexobandit/knowledge-db/blob/main/KCSA-study-guide.md#kubernetes-cluster-component-security-22-
