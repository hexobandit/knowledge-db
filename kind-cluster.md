# Local Kubernetes Kind Cluster 💠
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

Excected results.. this means YAY! 🔆

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

Deploy simple pod

    kubectl run nginx1 -n open --image=nginx:latest

Deploy simple pod via YAML

    kubectl apply -f pod-config.yaml

Exec into the container

    kubectl exec --stdin --tty nginx1 -n open -- /bin/sh 
    kubectl exec --stdin --tty nginx1 -n open -- /bin/bash

And things to do inside the container

    id && uname -a && pwd && env
    cat /etc/shadow

Checks Unix system for simple privilege escalations - Cron

    curl https://raw.githubusercontent.com/hexobandit/knowledge-db/refs/heads/main/check_cron_access.sh | sh

Checks Unix system for simple privilege escalations - Pentest Monkey 

    curl https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/refs/heads/1_x/unix-privesc-check > unix-privesc-check.sh
    chmod +x unix-privesc-check.sh
    ./unix-privesc-check.sh

## More Than One Cluster?
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
