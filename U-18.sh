#!/bin/bash

echo "[!] U-18 접속 IP 및 포트 제한 Checking ..."
IPTABLES_CHECK=$(iptables -L | wc -l)
safe=0
if [ $IPTABLES_CHECK -gt 8 ];then
	echo
	echo "[+] iptables service is working"
	echo "================================================================================================"
	echo "$(iptables -L)"
	echo "================================================================================================"	
	IPTABLES_CHECK=$(expr $IPTABLES_CHECK - 8)
	echo "[+] $IPTABLES_CHECK rules found"
else
	echo "[-] iptables service not found"
	safe=$(expr $safe + 1)
fi

if [ $(ls -al /etc/hosts.* | egrep "allow|deny" | wc -l) -eq 2 ];then
	echo "[+] TCP Wrapper service found"
	echo
	echo "================================================================================================" 
	echo "[!] /etc/hosts.allow"
	RESULT=$(cat /etc/hosts.allow | egrep "^[^#]+")
	echo "$RESULT"
	echo "================================================================================================"
	echo "[+] $(cat /etc/hosts.allow | egrep "^[^#]+" | wc -l) rules found"
	echo
	echo "================================================================================================"
	echo "[!] /etc/hosts.deny"
	RESULT=$(cat /etc/hosts.deny | egrep "^[^#]+")
	echo "$RESULT"
	echo "================================================================================================"
	COUNT_RULE=$(cat /etc/hosts.deny | egrep "^[^#]+" | wc -l)
	if [ $COUNT_RULE -eq 0 ];then
		safe=$(expr $safe + 1)
	fi
	echo "[+] $COUNT_RULE rules found"
	echo 
else
	echo "[-] TCP Wrapper service not found"
	safe=$(expr $safe + 1)
fi

if [ $safe -eq 2 ];then
	echo "[-] System is not using filtering service, Result : Bad"
else
	echo "[+] System is safe, Result : Good"
fi