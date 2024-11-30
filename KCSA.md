# Kubernetes and Cloud Native Security Associate (KCSA) Study Guide

https://training.linuxfoundation.org/certification/kubernetes-and-cloud-native-security-associate-kcsa/

## Domains

```
**Overview of Cloud Native Security 14%**

    The 4Cs of Cloud Native Security ✔️
    Cloud Provider and Infrastructure Security ✔️
    Controls and Frameworks ✔️
    Isolation Techniques ✔️
    Artifact Repository and Image Security ✔️
    Workload and Application Code Security ✔️

**Kubernetes Cluster Component Security 22%**

    API Server
    Controller Manager
    Scheduler
    Kubelet
    Container Runtime
    KubeProxy
    Pod
    Etcd
    Container Networking
    Client Security
    Storage

**Kubernetes Security Fundamentals 22%**

    Pod Security Standards
    Pod Security Admissions
    Authentication
    Authorization
    Secrets
    Isolation and Segmentation
    Audit Logging
    Network Policy

**Kubernetes Threat Model 16%**

    Kubernetes Trust Boundaries and Data Flow
    Persistence
    Denial of Service
    Malicious Code Execution and Compromised Applications in Containers
    Attacker on the Network
    Access to Sensitive Data
    Privilege Escalation

**Platform Security 16%**

    Supply Chain Security
    Image Repository
    Observability
    Service Mesh
    PKI
    Connectivity
    Admission Control

**Compliance and Security Frameworks 10%**

    Compliance Frameworks
    Threat Modelling Frameworks
    Supply Chain Compliance
    Automation and Tooling
```

![image](https://github.com/user-attachments/assets/7320bafd-636c-4113-be74-cf310485858c)


## Overview of Cloud Native Security 14% 🕵🏻‍♂️
### The 4Cs of Cloud Native Security
Cloud > Cluster > Container > Code

- **Cloud**
    - API server
      - Ensure internal-only traffic 
      - Use Network ACLs or NSGs to restrict access
      - Ensure internal-only traffic
        
    - Nodes
      - Restrict traffic to nodes from the control plane via specified ports using ACLs
      - Allow access only for NodePort and LoadBalancer services
      - No direct node exposure to the Internet
        
    - Cloud provider API (Allows AKS clusters to provision Azure Load Balancers, Disks, etc.)
      - Apply Least Privilege Principle for IAM roles, service principals, or credentials
      - Restrict access to the cloud provider API to necessary users and services
        
    - etcd
      - Access limited to the control plane only
      - Enforce TLS
      - Enforce Encryption at rest (CSI Drivers for external vaults)
        
- **Cluster**
    - **Securing Cluster Components**
        - Use private clusters 
        - Enforce (m)TLS
        - Apply Network Policies for pod-to-pod and pod-to-external traffic
        - Enforce API AuthN (e.g., OIDC) (Rotate and expire service account tokens)
        - **API AuthZ RBAC**
            - **RBAC Authorisation**
              - Roles and ClusterRoles
              - RoleBindings and ClusterRoleBindings
              - Principle of Least Privilege for all users, service accounts, and system components
                
            - **Node Authorisation**
              - Kubelets can only access their own Node object
              - Kubelets can only access Pods bound to their node
                
            - **Node Restrictions (Admission Controller)**
              - Enforces additional validation rules beyond authN and authZ (RBAC)
              - Second layer of validation applied after RBAC authorization (kube native)
              - E.g., Limits the scope of actions kubelets can perform to their own Node object or Pods bound to their node
                
    - **Securing Apps**
      - Limit the use of hostPath volumes
      - Use Pod Security Policies (PSP) or its replacement (e.g., Kyverno or OPA/Gatekeeper)
      - Configure resource requests and limits to avoid resource exhaustion
      - Scan for vulnerabilities within code
        
- **Container**
  - Use trusted container registries
  - Image signing and enforcment (e.g., via OPA Gatekeeper)
  - Scan container images for vulnerabilities
  - Minimal base images (e.g., distroless or Alpine)
  - Runtime - Detec anomalies e.g., via Falco
  - Runtime - Avoid running containers as root & non-privileged mode & read-only filesystem, etc.
  - Runtime - Limit container capabilities (e.g., avoid CAP_SYS_ADMIN)

- **Code**
  - Use Static Application Security Testing (SAST) tools
      - Use tools like Dependabot or Snyk to monitor vulnerabilities in dependencies
      - Store secrets securely using encrypted etcd or external vaults via CSI driver

### Cloud Provider and Infrastructure Security
- IAM & MFA & least privileges, vaults
- Private clusters, network segmentation
- Encryption TLS + at rest for sensitive data
- Compliance & governance & monitoring

### Controls and Frameworks
- NIST - Controls with the five pillars: Identify, Protect, Detect, Respond, and Recover
- CIS - Hardening guides
- HIPPA - Health Insurance Portability and Accountability Act
- PCI DSS - Payment Card Industry Data Security Standard
- GDPR - General Data Protection Regulation
- Tools to Implement and Validate Controls
- Infrastructure-as-Code (IaC) Scanning
- AWS Security Hub, Azure Defender
- Policy Enforcement: OPA (Open Policy Agent), Kyverno, or Gatekeeper

 ### Isolation Techniques

- **Namespace Isolation**
  - Use namespaces to logically separate workloads
  - Enforce RBAC rules scoped to namespaces
    
- **Network Isolation**
  - Use Network Policies to restrict pod-to-pod and pod-to-external communication
  - Isolate clusters with VPCs or subnets
  - Configure firewalls or Network Security Groups to restrict traffic
    
- **Node Isolation**
  - Schedule sensitive workloads on dedicated nodes.
  - Deploy system-critical pods (e.g., kube-system) separately from application workloads
  - Harden nodes by disabling unused ports and services & PSP & Kernal hardening tools
    
- **Storage Isolation**
  - Use volume policies to ensure data is mounted securely (e.g., read-only when possible)
  - Isolate Persistent Volume Claims (PVCs) Like Storage Account
  - Encrypt storage using cloud provider tools or Kubernetes CSI
    
- **Workload Isolation**
  - Use PSP (e.g., baseline, restricted).
  - Prevent privilege escalation (allowPrivilegeEscalation: false).
  - Run containers as non-root users.
    
- **API Access Isolation**
  - Restrict API server access using network controls
  - Configure RBAC to limit API access per user or service account
  - Disable anonymous and unauthenticated access
    
- **Multi-Tenancy**
  - Use unique namespaces, Network Policies, and quotas for tenants.
  - Use workload identity or separate IAM roles for each tenant.
  - Enforce pod-level security boundaries with sandboxing (e.g., gVisor, Kata).

### Artifact Repository and Image Security
- Artifact Repository
  - Use private repositories with access controls.
  - Enable image signing (e.g., Cosign).
  - Automate vulnerability scans for stored images.
  - Enforce retention policies and encrypt storage.
    
- Image Security
  - Use minimal, updated base images.
  - Avoid sensitive data in images.
  - Set USER non-root in Dockerfiles.
    
- CI/CD & Deployment
  - Scan images in CI/CD pipelines.
  - Enforce signed and trusted images in production.
  - Use admission controllers to validate image policies.

### Workload and Application Code Security
- Workload Security
  - Use Pod Security Standards (e.g., restricted profile).
  - Enforce resource limits (CPU and memory) for containers.
  - Set allowPrivilegeEscalation=false and runAsNonRoot=true.
  - Isolate sensitive workloads using namespaces and node taints.
    
- Application Code Security
  - Perform regular static and dynamic code analysis.
  - Avoid hardcoding secrets; use secret management tools like vaults
  - Validate all input and sanitize user data.
  - Use secure coding practices (e.g., OWASP Top 10).
    
- CI/CD & Deployment
  - Scan dependencies for vulnerabilities (e.g., Snyk, Dependabot).
  - Automate security tests in CI/CD pipelines.
  - Enforce only validated code and dependencies in production.
 
  
## Kubernetes Cluster Component Security 22% 🎳
### API Server
