#!/bin/bash

INETD=/etc/inetd.conf
XINETD=/etc/xinetd.d/

echo "[!] U-19 Finger 서비스 비활성화 checking ..."

if test -f $INETD
then
	echo "[+] $INETD file found"
	INETD_CHECK=$(cat $INETD | egrep "^finger" | wc -l)
	if [ $INETD_CHECK -eq 0 ];then
		echo "[+] Not found finger service in $INETD, Result : Good"
	else
		echo "[-] finger service found in $INETD, Result : Bad"
	fi

elif test -f $XINETD
then
	echo "[+] $XINETD file found"
	XINETD_CHECK=$(cat $XINETD | egrep "^service.+finger$" | wc -l)
	if [ $XINETD_CHECK -eq 0 ];then
		echo "[+] Not found finger service in $XINETD, Result : Good"
	else
		XINETD_CHECK=$(cat $XINETD | grep -A 8 "service finger" | grep disable | awk 'NR<=1 {print}' | grep yes | wc -l)
		if [ $XINETD_CHECK -eq 1 ];then
			echo "[+] xinetd config is safe, Result : Good"
		else
			echo "[-] xinetd config is vulnerable, Result : Bad"
		fi
	fi
else
	echo "[-] Not found inetd, xinetd serivce, Result : Bad"
fi