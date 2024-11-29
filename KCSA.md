# Kubernetes and Cloud Native Security Associate (KCSA) Study Guide

https://training.linuxfoundation.org/certification/kubernetes-and-cloud-native-security-associate-kcsa/

## Domains

```
**Overview of Cloud Native Security 14%**

    The 4Cs of Cloud Native Security
    Cloud Provider and Infrastructure Security
    Controls and Frameworks
    Isolation Techniques
    Artifact Repository and Image Security
    Workload and Application Code Security

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

## Overview of Cloud Native Security 14% 🕵🏻‍♂️
### The 4Cs of Cloud Native Security
- **Cloud**
    - API server
      - Internal only traffic
      - Controlled by network access control list (ACLs)
    - Nodes
      - Traffic via ACLs only from the control plane on specified ports
      - Accept connections for services in k8s of type NodePort and LoadBalancer
      - No node should be exposed to internet
    - Cloud provider API (Allows AKS clusters to provision Azure Load Balancers, Disks, etc.)
      - Least privilege principle.
    - etcd
      - Access limited to the control plane only
      - Enforce TLS
      - Enforce Encryption at rest (CSI Drivers for external vaults)
- **Cluster**
    - Securing Cluster Components
        - Enforce TLS
        - Enforce API AuthN (e.g., OIDC)
        - API AuthZ RBAC (verbs (get, create, delete, list) with resources (pods, services, nodes) and can be namespace scoped)
            - Node Authorisation
              - kubelets are only allowed to read their own Node objects
              - kubeletes are only allowed to read pods bound to their node
            - RBAC Authorisation 
              - Roles and ClusterRoles
              - RoleBindings and ClusterRoleBindings
              - Principle of Least Privilege
            - Node Restrictions (Admission Controller)
              - Enforces additional validation rules beyond authN and authZ (RBAC)
              - Second layer of validation applied after RBAC authorization (kube native)
              - E.g., Limits the scope of actions kubelets can perform to their own Node object or Pods bound to their node
    - Securing Apps
- **Container**
- **Code**
