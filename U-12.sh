#!/bin/bash

echo "[!] U-12 /etc/services 파일 소유자 및 권한 설정 Checking ..."
if test -f /etc/services
then
	echo "[+] /etc/services file is found"
	SERVICES=$(ls -al /etc/services | awk '{print $1}')
	if [ $SERVICES = "-rw-r--r--" ];then
		echo "[+] /etc/services file is safe, Result : Good"
	else
		echo "[-] /etc/services files is vulnerable, Result : Bad"
	fi
else
	echo "[-] /etc/services file can't found"
fi