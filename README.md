# lev-parser
## Low Encryption Vulnerability Parser 

### lev-parser aims to parse SSL/TLS ciphers to corresponding targets. It aims to automate and output the affected areas (host:port) for the several LOW to INFO encryption vulnerabilities listed below:

SSL/TLS Version and Encryption Vulnerabilities (7):
- SSL Version 3 Enabled (Low)
- SSL Version 2 Enabled (Low)
- TLS Version 1.0 Protocol Enabled (Low)
- TLS Version 1.1 Protocol Enabled (Low)
- TLS Version Protocol 1.3 Disabled (Low)
- Insufficient Diffie-Hellman Key Signature (Low)
- Weak SSL Ciphers (Low)

Certificate Information Vulnerabilities (3):
- SSL Certificate Weak Hashing Algorithm (Low)
- Wildcard SSL Certificate (Low)
- Use of Self-Signing Certificate (Info)

It also aims to list the following:
- TLS Version 1.2

### Objective:
- To aid testers when compiling low-hanging encryption vulnerabilities especially when targets consist of numerous targets and subnets.
- To save time during report writing of the mentioned vulnerabilities

### Implementation:
Bash script to be run and/or stored inside:
- VC-RAP
- Personal Kali VM

### Where to Use:
- Web Application VAPT
- Internal Network VAPT
- External Network VAPT

### Hosted In:
Github

### Input:
./lev-parser -f <nmap_ssl_script_output_file> -o <parsed.txt>


### Sample Output (as .txt and or echoed in terminal):
A. TLS v1.1 Enabled
10.0.0.1:443
10.20.25.45:1702
  ...
  ...
  ...
<host>:<port>
  
B. SSLv3 Enabled
10.0.0.1:443
10.20.25.45:1702
  ...
  ...
  ...
<host>:<port>

C. SSL Weak Hashing Algorithm
- MD5
10.0.0.1:443
10.20.25.45:1702
  ...
  ...
  ...
<host>:<port>
- <weak certificate hash>
10.0.0.1:443
10.20.25.45:1702
  ...
  ...
  ...
<host>:<port>

D. Use of Self-Signed Certificates:
none
  

  
