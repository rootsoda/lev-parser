#!/bin/bash
#
# https://github.com/rootsoda/lev-parser
#
# Copyright (c) 2022 rootsoda

# Current Notes (as of October 24, 2022)
# Assume text file is in same directory as of the parser

################## PRELIMINARY CHECKS #######################
# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo 'This installer needs to be run with "bash", not "sh".'
	exit
fi

# Discard stdin. Needed when running from an one-liner which includes a newline
read -N 999999 -t 0.001

clear

# Detect if the following packages are installed. (sslscan)
echo 'Checking for pre-requisites...'
sleep 0.5
REQUIRED_PKG="sslscan"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
sleep 0.5
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi
# From https://stackoverflow.com/questions/1298066/how-can-i-check-if-a-package-is-installed-and-install-it-if-not

####################### SHOW MENU ###########################
selection=1
while [ "$selection" -ne 0 ]; do
	echo 'OK. Loading parser...'
	sleep 1
	echo '
	█░░ █▀▀ █░█ ▄▄ █▀█ ▄▀█ █▀█ █▀ █▀▀ █▀█
	█▄▄ ██▄ ▀▄▀ ░░ █▀▀ █▀█ █▀▄ ▄█ ██▄ █▀▄'
	echo '(Low Encryption Vulnerability Parser) by rootsoda'
	echo
	echo 'Welcome to lev-parser! Choose from the options below:'

	echo "[1] SSL Version 3 Enabled (Low)				WORKING"
	echo "[2] SSL Version 2 Enabled (Low)				WORKING"
	echo "[3] TLS Version 1.0 Protocol Enabled (Low)		WORKING"
	echo "[4] TLS Version 1.1 Protocol Enabled (Low)		WORKING"
	echo "[5] TLS Version 1.2					WORKING"
	echo "[6] TLS Version Protocol 1.3 Disabled (Low)		WORKING"
	echo
	echo "--------------------------- To follow------------------------------"
	echo "[7] Insufficient Diffie-Hellman Key Signature (Low)	N/A"
	echo "[8] Weak SSL Ciphers (Low)				N/A"
	echo "[9] SSL Certificate Weak Hashing Algorithm (Low)	N/A"
	echo "[10] Wildcard SSL Certificate (Low)			N/A"
	echo "[11] Use of Self-Signing Certificate (Info)		N/A"
	echo
	echo "[0] EXIT"
	read -p "-------------------------------------------- Selection: " selection

	if [ "$selection" -eq 0 ]; then echo "Bye!" && exit 1; else echo;fi

	#READ FILE containing the list of target IPs
	read -p "Enter file containing targets/IPs: " target_file
	targets=()
	for ip in $(cat $target_file)
		do
			echo 'Scanning' $ip'...'
			sleep 0.25
			case "$selection" in
				1)
						sslscan --ssl3 --no-ciphersuites --no-fallback --no-renegotiation --no-compression --no-heartbleed --no-groups --no-check-certificate --no-cipher-details $ip >> out.txt
				;;
				2)
						sslscan --ssl2 --no-ciphersuites --no-fallback --no-renegotiation --no-compression --no-heartbleed --no-groups --no-check-certificate --no-cipher-details $ip >> out.txt
				;;
				3)
						sslscan --tls10 --no-ciphersuites --no-fallback --no-renegotiation --no-compression --no-heartbleed --no-groups --no-check-certificate --no-cipher-details $ip >> out.txt
				;;
				4)
						sslscan --tls11 --no-ciphersuites --no-fallback --no-renegotiation --no-compression --no-heartbleed --no-groups --no-check-certificate --no-cipher-details $ip >> out.txt
				;;
				5)
						sslscan --tls12 --no-ciphersuites --no-fallback --no-renegotiation --no-compression --no-heartbleed --no-groups --no-check-certificate --no-cipher-details $ip >> out.txt
				;;
				6)
						sslscan --tls13 --no-ciphersuites --no-fallback --no-renegotiation --no-compression --no-heartbleed --no-groups --no-check-certificate --no-cipher-details $ip >> out.txt
				;;
				# 9)
				# 		nmap --script ssl-cert $ip >> out-cert.txt
				# ;;
			esac
			targets+=($ip)
		done
	#-----------------------------------------------------
	# For Certificate Information
	# cat out-cert.txt | grep "Signature Algorithm" | cut -d ' ' -f 4 >> enc.txt # encryption result
	# grep "report" | cut -d ' ' -f 5 >> ip-c.txt # get IP



	#-----------------------------------------------------
	# For TLS/SSL Protocols
	cat out.txt | grep -o "enabled\|disabled" >> f.txt #get result if 'enabled' or 'disabled'
	grep "port" out.txt | cut -d ' ' -f 7 >> p.txt #get port
	grep "Connected" out.txt | cut -d ' ' -f 3 >> ip.txt #get IP

	ips=()
	for ip in $(cat ip.txt); do ips+=($ip);done

	# Displaying results
	echo '-------------------------------------------------'
	sleep 0.5
	echo 'Processing results...'
	sleep 0.5
	echo
	echo 'Results for Enabled:'
	i=0
	disabled=()
	if [ ! -s f.txt ]; then echo "lev-parser ERROR: Cannot connect to the targets (Connection refused).";
	else
		while IFS= read -r res && IFS= read -r port<&3;
		do
			if [ "$res" == "enabled" ]; then 
				echo "${ips[i]}:$port - $res"
			else #store in array containing the disabled values, then print
				val=${ips[i]}
				disabled+=($val)
			fi
			i=$(($i+1))
		done < f.txt 3<p.txt
	fi


	# PRINTING
	echo
	echo 'Results for Disabled:'
	if [ -z "$disabled" ]; then echo "None."
	else
		for ip in ${disabled[@]}; do echo $ip':443';done
	fi

	#Delete TEMP FILES
	rm out.txt f.txt p.txt ip.txt out-cert.txt

	#Unset variables
	unset targets
	unset ips
	unset disabled
	unset val

	echo
	read -p "---------------------------- Continue? [1 (y) / 0 (n)]: " choice
	if [ "$choice" -eq 0 ]; then echo "Bye!" && exit 1; else echo;fi
done