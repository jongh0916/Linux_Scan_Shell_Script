#!/bin/sh

echo "[!] U-01 root 계정 원격접속 제한 Checking ..."
if [ `service telnet status 2>/dev/null | grep active | wc -l` -eq 1 ]; then
	echo "[-] telnet service is running ..."
	if [ `cat /etc/xinetd.d | grep root | wec -l` -eq 1 ]; then
		echo "[-] telnet service config vulnerable, Result : Bad"
	else
		echo "[+] telnet service config is very well, Result : Good"
	fi
else
	echo "[+] telnet service is not runnning. Result : Good"
fi

if [ `service ssh status | grep active | wc -l` -eq 1 ]; then
	echo "[-] ssh service is running ..."
	if [ `cat /etc/ssh/sshd_config | grep PermitRootLogin | grep yes | wc -l` -eq 1 ]; then
		echo "[-] ssh service config vulnerable, Result : Bad"
	else
		echo "[+] ssh service config is very well, Result : Good"
	fi
else
	echo "[+] ssh service is not running. Result : Good"
fi