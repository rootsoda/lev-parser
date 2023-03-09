LEV-parser
============
![Menu](https://raw.githubusercontent.com/rootsoda/lev-parser/main/menu1.png?token=GHSAT0AAAAAAB7DJHZ4YKYQCTQKUNOT6L3UZAJV5WA)
-----------
A simple bash script to parse Low Encryption Vulnerability nmap script results

Features
--------
* parse SSL/TLS ciphers to corresponding targets
* aims to automate and output the affected areas (host:port) for the several LOW to INFO encryption vulnerabilities listed below:

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

Objectives
-----
* To aid testers when compiling low-hanging encryption vulnerabilities especially when targets consist of numerous targets and subnets.
* To save time during report writing of the mentioned vulnerabilities

Implementation
-----
Bash script to be run and/or cloned inside:
- VC-RAP
- Personal Kali VM

Where to Use
------
- Web Application VAPT
- Internal Network VAPT
- External Network VAPT

Usage
-----
Switch to root user and run the script.

### Options
```
usage: 
./lev-parser

```

Changelog
---------
* version 1.0 - updated implementation from bash script to python script
* 10/24/22 - included SSL/TLS Protocol parsing (using sslscan only) 

Copyright and License
---------------------
LEV-parser is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

LEV-parser is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with LEV-parser. 
If not, see http://www.gnu.org/licenses/.

Contact
-------
* Claire Era < claireera9 at gm@il d0t com >
