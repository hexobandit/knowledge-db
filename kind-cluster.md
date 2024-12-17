# Local Kubernetes Kind Cluster
## Installation

1. Install Docker
2. Install Kubectl
3. Install Kind
  - On Win `choco install kind`
  - On Mac `brew install kind`
4. Verify kind installation `kind version`


## First Steps

Create your first cluster

    kind create cluster --name <name>

See what`s in there

    kubectl get pods -A

Excected results.. this means YAY!

    kube-system             coredns-7db6d8ff4d-c4tsh                              1/1     Running            9 (19m ago)    154d
    kube-system             coredns-7db6d8ff4d-rjvkx                              1/1     Running            9 (19m ago)    154d
    kube-system             etcd-kind-control-plane                               1/1     Running            0              19m
    kube-system             kindnet-tsxw2                                         1/1     Running            9 (19m ago)    154d
    kube-system             kube-apiserver-kind-control-plane                     1/1     Running            0              19m
    kube-system             kube-controller-manager-kind-control-plane            1/1     Running            12 (19m ago)   154d
    kube-system             kube-proxy-ss7nx                                      1/1     Running            9 (19m ago)    154d
    kube-system             kube-scheduler-kind-control-plane                     1/1     Running            14 (19m ago)   154d
    local-path-storage      local-path-provisioner-988d74bc-dw2sd                 1/1     Running            17 (18m ago)   154d

## Playing Around
See all existting clusters

    kind get clusters

Listing all available contexts

    kubectl config get-contexts
    
Switch context from one to another 

    kubectl cluster-info --context <name>

See what`s in there

    kubectl get pods -A


## Destroying Stuff

    kind delete cluster --name <nme>
