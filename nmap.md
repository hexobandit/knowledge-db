# NMAP Cheat Sheet

```nmap 10.10.X.X```

```sudo nmap -O -sV -p1-999 --script=vuln --script=discovery 78.156.158.75```

## Flags
- ```O```   OS
- ```sV``` 	services
- ```A``` 	aggressive 
- ```oG grappableFormat.txt```
- ```sU```	udp
- ```sC-``` tcp 
- ```sU --top-ports 20```
- ```p1-999``` scansXXXPorts
- ```sS``` 	halfScan 
- ```sn```  pingScan

## FW Escape
- ```pN```  doNotPing (essential for FW bypass)
- ```f```   splitIntoFragments
- ```sN```  null
- ```sF```  fin
- ```sX```  xmass
- ```data-length 25```  addsArbitraryData
- ```scan-delay 10ms``` 

Do UDP+NULL+FIN+XMASS If the port is open then there is no response to the malformed packet.

## Scripts
- ```script=vuln```
- ```script=safe```
- ```script=exploit```
- ```script=auth```
- ```script=default```
- ```script=discovery```

Check for SSL/TLS downgrade attacks: 

    nmap --script ssl-enum-ciphers -p 443 emphonic.com

### Download more goodies
- https://nmap.org/nsedoc/scripts/

### Find your local scripts
```
cd /opt/homebrew/share/nmap/scripts
ls -alt | grep ftp
```
