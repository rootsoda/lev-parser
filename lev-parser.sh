#!/bin/bash
#
# https://github.com/rootsoda/lev-parser
#
# Copyright (c) 2022 rootsoda

# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo 'This installer needs to be run with "bash", not "sh".'
	exit
fi

# Discard stdin. Needed when running from an one-liner which includes a newline
read -N 999999 -t 0.001

# Show menu 
# Assume merong sslscan 
# Assume nasa same directory yung targets textfile
#


clear


echo 'Welcome to lev-parser! Choose from the options below'

echo "[1] SSL Version 3 Enabled (Low)"
echo "[2] SSL Version 2 Enabled (Low)"
echo "[3] TLS Version 1.0 Protocol Enabled (Low)"
echo "[4] TLS Version 1.1 Protocol Enabled (Low)"
echo "[5] TLS Version Protocol 1.3 Disabled (Low)"
echo "[6] Insufficient Diffie-Hellman Key Signature (Low)"
echo "[7] Weak SSL Ciphers (Low)"
echo
echo "Certificate Information Vulnerabilities (3):"
echo "[8] SSL Certificate Weak Hashing Algorithm (Low)"
echo "[9] Wildcard SSL Certificate (Low)"
echo "[10] Use of Self-Signing Certificate (Info)"
echo
echo "[11] TLS Version 1.2"
echo
echo "[0] Exit"
read -p "Type the number of your selection here: " selection

case "$selection" in
	1)
			echo "sslv3"
			exit
	;;
	2)
			echo "sslv2"
			exit
	;;
	3)
			echo "tlsv10"
			exit
	;;
	4)
			echo "tlsv11"
			exit
	;;
	5)
			echo "tlsv13"
			exit
	;;
	6)
			echo "weakdh"
			exit
	;;
	7)
			echo "weakssl"
			exit
	;;
	8)
			echo "weakcerth"
			exit
	;;
	9)
			echo "wildcard"
			exit
	;;
	10)
			echo "selfsign"
			exit
	;;
	11)
			echo "tlsv12 - works for 443 only"
			echo "Enter target filename: "
			read -p "Enter file containing targets/IPs: " target_file
			targets=()
			for ip in $(cat $t_file)
				do
					sslscan --tls12 --nociphersuites --no-fallback --no-renegotiation --no-compression --no-heartbleed --no-groups --no-check-certificate --no-cipher-details $ip >> out.txt
					targets+=($ip)
				done
			cat out.txt | grep -o "enabled" >> f.txt
			grep "port" out.txt | cut -d ' ' -f 7 >> p.txt

			i=0
			if [ -z $(cat f.txt)]; then echo "NULL";
			else
				while IFS= read -r res && IFS= read -r port <&3;
				do
					echo "$res, ${targets[i]}, $port"
					i=$(($i+1))
				done < f.txt 3< p.txt
			fi

			rm out.txt f.txt p.txt
			exit
	;;
	12)
			echo "sslv2"
			exit
	;;
	0)
			exit
	;;
esac
