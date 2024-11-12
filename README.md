# knowledge-db
Various commands, scripts and how-to documents

### Bash Ping Sweep
    subnet="192.168.1"; for ip in {1..254}; do ping -c 1 -W 1 "${subnet}.${ip}" > /dev/null 2>&1 && echo "Host ${subnet}.${ip} is up" || echo "Host ${subnet}.${ip} is down"; done

### Python Virtual Environment
Go to your project folder and run:

    python3 -m venv venv
    source ./venv/bin/activate
