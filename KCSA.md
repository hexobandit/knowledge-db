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

## Overview of Cloud Native Security 14%
### The 4Cs of Cloud Native Security
- Cloud
    - Network access to API server (Control Plane) needs to be only internal. Controlled by network access control list restricted to set of IPs that need administer the cluster
    - Network access to Nodes should be configured to only accept connections via network access control list from the control plane on specified ports and accept connections for services in k8s of type NodePort and LoadBalancer. No node should be exposed to internet.
    - K8s access to cloud provider API. Provide the cloud provider access based on least privilege principle.
    - Access to etcd needs to be limited to the control plane only + TLS + encryption at rest.
- Cluster
    - Components
        - TLS
        - API AuthN
        - API AuthZ RBAC combines verbs (get, create, delete, list) with resources (pods, services, nodes) can be namespace scoped.
            - Node Authorisation
            - RBAC Authorisation
            - Node Restrictions (Admission Controller)
    - Apps
- Container
- Code
