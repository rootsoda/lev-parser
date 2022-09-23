LEV-parser
============

Description
-----------
A simple python script to parse Low Encryption Vulnerability nmap script results

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
Python script to be run and/or stored inside:
- VC-RAP
- Personal Kali VM

Where to Use
------
- Web Application VAPT
- Internal Network VAPT
- External Network VAPT

Usage
-----
Pass the Nmap output via stdin or from a specified file (`-i`).  
The processed dump can be collected at stdout or to a specified file (`-o`).

### Options
python3 lev-parser.py -i <nmap_ssl_script_output_file> -o <parsed.txt>

```
usage: lev-parser [-i] [-i INPUT] [-o OUTPUT]

optional arguments:
  -h, --help            show this help message and exit

Mandatory parameters:
  -i INPUT, --input INPUT
                        Nmap scan output file in normal (-oN)

Output parameters:
  -o OUTPUT, --output OUTPUT
                        Plaintext output filename (stdout if not specified)
```

### Nmap Normal format (default output format -oN)
```
$ python lev-parser.py -i script-results.txt -o results-filename.txt
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
```

Dependencies and installation
-----------------------------
* A Python interpreter with version 2.7 or 3.X

Changelog
---------
* version 1.0 - updated implementation from bash script to python script

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