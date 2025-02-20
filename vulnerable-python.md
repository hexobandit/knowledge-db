# Vulnerable Python Code
## Purposefully vulnerable python code for testing SAST tooling. 

Vulnerabilities Included
	1.	Hardcoded Secret → API_KEY is exposed.
	2.	Insecure Dependency → requests.get() with verify=False (potential MITM attack).
	3.	Command Injection → os.system(f"cat {user_input}") allows arbitrary shell execution.
	4.	SQL Injection → Direct string formatting in cursor.execute(query).
	5.	Insecure File Handling → User input allows arbitrary file writes.
	6.	Weak Hashing Algorithm → Uses md5, which is cryptographically broken.
	7.	Unvalidated Redirect → requests.get(target_url) accepts unverified user input.

How to Use This for SAST Testing
	•	Run your Static Analysis Tool (SAST) on this file.
	•	It should flag multiple vulnerabilities.
	•	If your tool does not detect them, it may need better rule sets.

⚠️ Warning: This code is intentionally insecure! Do not use in production.

```
import os
import subprocess
import sqlite3
import requests

# 🚨 1. Hardcoded Secret (SAST should flag this)
API_KEY = "12345-VERY-INSECURE-SECRET"

# 🚨 2. Insecure Dependency (requests <2.20.0 has known vulnerabilities)
response = requests.get("https://example.com", verify=False)  # Disable SSL verification

# 🚨 3. Command Injection
user_input = input("Enter a filename: ")
os.system(f"cat {user_input}")  # 🚨 Unvalidated user input in shell command

# 🚨 4. SQL Injection
conn = sqlite3.connect("users.db")
cursor = conn.cursor()
username = input("Enter username: ")
query = f"SELECT * FROM users WHERE username = '{username}'"  # 🚨 Unsanitized input in SQL query
cursor.execute(query)
print(cursor.fetchall())

# 🚨 5. Insecure File Handling (Arbitrary File Write)
filename = input("Enter filename to write: ")
with open(filename, "w") as f:
    f.write("This is a test.")  # 🚨 Allows writing to any file path

# 🚨 6. Use of Insecure Hashing Algorithm
import hashlib
password = input("Enter password: ")
hashed_password = hashlib.md5(password.encode()).hexdigest()  # 🚨 MD5 is weak and should not be used

# 🚨 7. Unvalidated Redirect
target_url = input("Enter URL to visit: ")
requests.get(target_url)  # 🚨 No validation on user-supplied URL

conn.close()
```
