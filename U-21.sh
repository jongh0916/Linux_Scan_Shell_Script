#!/bin/bash

FILE=/etc/xinetd.d/xinetd.conf
XINETD=$(cat $FILE | egrep "rsh|rlogin|rexec" | wc -l)

echo "[!] U-21 r 계열 서비스 비활성화 Checking..."

if [ $XINETD -eq 0 ];then
	echo "[+] No r-command service found, Result : Good"
else
	echo "================================================================================================"
	echo "$(cat $FILE | egrep "rsh|rlogin|rexec")"
	echo "================================================================================================"
	echo "[-] Vulnerable services found"
	XINETD_CHECK=$(cat $FILE | egrep -A 8 "rlogin|rsh|rexec" | grep disable | wc -l)
	XINETD_CHECKK=$(cat $FILE | egrep -A 8 "rlogin|rsh|rexec" | grep disable | grep yes | wc -l)

	if [ $XINETD_CHECK -eq $XINETD_CHECKK ];then
		echo "[+] /etc/xinetd.d/xinetd.conf config is very good, Result : Good"
	else
		echo "[-] /etc/xinetd.d/xinetd.conf config is vulnerable, Result : Bad"
	fi
fi