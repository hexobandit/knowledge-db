# Google Dorking
## Hacking Without Writing a Single Line of Code

You might have already heard of "Google dorking" or "Google hacking" before as it is a popular way to use profound Google search engine to the maximum. 
Whether you search for specific document (let's say all PDF documents published by official European Commission web page with GDPR key word withing) 
```site: ec.europa.eu filetype:pdf GDPR``` or wherher you search for some inspiration for your new password ```"login: *" "password= *" filetype:xls.```
Google dorking is truly an amazing tool available at the end of your fingertips. 
There are of course other search engines as DuckDuckGo (for example) where you can play around, 
just be ware that the queries might be different. As there are thousands of possibilities what to search for, 
be sure to go visit one and the only source of truth: [www.exploit-db.com](www.exploit-db.com)

### DOCS

```
site:*.xyz.com intitle:confidential
site:*.xyz.com filetype:txt
site:*.xyz.com filetype:csv
site:*.xyz.com filetype:ini
site:*.xyz.com filetype:pdf GDPR
site:*.xyz.com filetype:txt password
```

### PWDs

```
filetype:xls "login: *" "password= *"
filetype:reg reg HKEY_CURRENT_USER intext:password
filetype:sql password
filetype:env "MAIL_PASSWORD" 
inurl:"/password.log" "END_FILE" 
intitle:index.of "keys.txt"
intitle:index.of "creds.txt"
```

### SQL

```
intext:connectionString & inurl:web & ext:config\
```

### FTP

```
intitle:"FTP root at"
intitle:"index of" inurl:ftp
```

### VAR

```
intitle: index of mp3
intitle:index.of "Desktop" parent 
inurl:/proc/self/cwd
filetype:xls inurl:"email.xls"
filetype:log username putty
```

### CAMS

```
"powered by webcamXP" "Pro|Broadcast"
camera linksys inurl:main.cgi
```

### BONUS
```
intext:YOU ARE ACCESSING A GOVERNMENT INFORMATION SYSTEM inurl:login.aspx
intitle:"Welcome to nginx!" intext:"Welcome to nginx on Debian!"
```
