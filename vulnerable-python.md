# Vulnerable Python Code
## Purposefully vulnerable python code for testing SAST tooling. 

Vulnerabilities Included
1. Hardcoded Secret
2. Insecure Dependencies
3. Command Injection
4. SQL Injection
5. Insecure File Handling
6. Use of Weak Hashing Algorithm
7. Unvalidated Redirect
8. Insecure Deserialization (Pickle)
9. Insecure YAML Parsing 
10. Insecure JWT Handling

How to Use This for SAST Testing
- Run your Static Analysis Tool (SAST) on this file.
- It should flag multiple vulnerabilities.
- If your tool does not detect them, it may need better rule sets.

⚠️ Warning: This code is intentionally insecure! Do not use in production.


### Vulnerable Libraries
Add them into ```requirements.txt```

```
requests==2.19.1  # 🚨 CVE-2018-18074: Cookie leak vulnerability
pyyaml==5.1  # 🚨 CVE-2020-1747: Arbitrary code execution via yaml.load()
pyjwt==1.6.4  # 🚨 CVE-2022-29217: No signature validation
```

### Vulnerable Code:

```
import os
import subprocess
import sqlite3
import requests  # 🚨 Insecure version will be specified in requirements.txt
import hashlib
import yaml  # 🚨 PyYAML unsafe loading
import jwt  # 🚨 PyJWT missing verification
import pickle  # 🚨 Insecure deserialization

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
password = input("Enter password: ")
hashed_password = hashlib.md5(password.encode()).hexdigest()  # 🚨 MD5 is weak and should not be used

# 🚨 7. Unvalidated Redirect
target_url = input("Enter URL to visit: ")
requests.get(target_url)  # 🚨 No validation on user-supplied URL

# 🚨 8. Insecure Deserialization (Pickle)
payload = input("Enter serialized object: ")
data = pickle.loads(payload.encode())  # 🚨 Untrusted input leads to RCE

# 🚨 9. Insecure YAML Parsing
yaml_data = input("Enter YAML data: ")
parsed_data = yaml.load(yaml_data, Loader=yaml.FullLoader)  # 🚨 Can execute arbitrary Python code

# 🚨 10. Insecure JWT Handling (No Verification)
token = input("Enter JWT: ")
decoded = jwt.decode(token, options={"verify_signature": False})  # 🚨 No signature verification
print(decoded)

conn.close()
```
