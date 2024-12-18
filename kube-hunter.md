# Kube Hunter Installation 🏹
## Set Python virtual environment

    mkdir /python-projects && cd /python-projects

    python3 -m venv /kube-hunter

    source /kube-hunter/bin/activate

You should get result similar to this:

    (kube-hunter) username@debian-gnu-linux-12

## Install Kube-Hunter into kube-hunter virtual environment

    pip install kube-hunter

# Run The Kube Hunter 🔎
## Enumerate AWS EKS API Endpoint 
Get the URL for the API Sever Endpoint from AWS EKS console, however lose the ```https://```

    kube-hunter --remote B6E3EF7XXXXXXXXXXXX.sk1.eu-central-1.eks.amazonaws.com

## Expected results:

```
Nodes
+-------------+----------------------+
| TYPE        | LOCATION             |
+-------------+----------------------+
| Node/Master | B6E3XXXXXXXXXXXXX06C |
|             | B724D312CEBF.sk1.eu- |
|             | central-             |
|             | 1.eks.amazonaws.com  |
+-------------+----------------------+

Detected Services
+------------+----------------------+----------------------+
| SERVICE    | LOCATION             | DESCRIPTION          |
+------------+----------------------+----------------------+
| API Server | B6E3XXXXXXXXXXXXXX6C | The API server is in |
|            | B724D312CEBF.sk1.eu- | charge of all        |
|            | central-             | operations on the    |
|            | 1.eks.amazonaws.com: | cluster.             |
|            | 443                  |                      |
+------------+----------------------+----------------------+

Vulnerabilities
For further information about a vulnerability, search its ID in: 
https://avd.aquasec.com/
+--------+----------------------+----------------------+----------------------+----------------------+---------------------+
| ID     | LOCATION             | MITRE CATEGORY       | VULNERABILITY        | DESCRIPTION          | EVIDENCE            |
+--------+----------------------+----------------------+----------------------+----------------------+---------------------+
| KHV002 | B6E3EF71XXXXXXXXXX6C | Initial Access //    | K8s Version          | The kubernetes       | v1.30.2-eks-db838b0 |
|        | B724D312CEBF.sk1.eu- | Exposed sensitive    | Disclosure           | version could be     |                     |
|        | central-             | interfaces           |                      | obtained from the    |                     |
|        | 1.eks.amazonaws.com: |                      |                      | /version endpoint    |                     |
|        | 443                  |                      |                      |                      |                     |
+--------+----------------------+----------------------+----------------------+----------------------+---------------------+
```
