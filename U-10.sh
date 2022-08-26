#!/bin/bash

INET=$(ls -al /etc/inetd.conf 2>/dev/null | wc -l)
XINETD=$(ls -al /etc/xinetd.conf 2>/dev/null | wc -l)
XINETD_DIR=$(ls -al /etc/xinetd.d/ 2>/dev/null | wc -l)

echo "[!] U-10 /etc/(x)inetd.conf 파일 소유자 및 권한 설정 Checking ..."
if test -f /etc/inetd.conf
then
	if [ $(ls -al /etc/inetd.conf 2>/dev/null | awk '{print $1}') != "-rw-------" ];then
		echo "[-] inetd.conf permission is vulnerable, Result : Bad"
	fi
else
	echo "[-] /etc/inetd.conf file can't found, Result : Not Search"
fi

if test -d /etc/xinetd.d 
then
	if [ $(ls -al /etc/xinetd.d | awk '/^[rwx-]+/{print}' | wc -l) -eq $(ls -al /etc/xinetd.d | awk '/^[rwx-]+/{print}' | grep "-rw-------" | wc -l) ];then
		echo "[+] /etc/xinetd.d/ files are safe, Result : Good"
	else 
		"[-] /etc/xinetd.d/ files are vulnerable, Result : Bad"
	fi
else
	echo "[-] /etc/xinetd.d/ files can't found, Result : Not Search"
fi

if test -f /etc/xinetd.conf
then
	if [ $(ls -al /etc/xinetd.conf | awk '{print $1}') = "-rw-------" ];then
		echo "[+] /etc/xinetd.conf file is safe, Result : Good"
	else
		echo "[-] /etc/xinetd.conf file is vulnerable, Result : Bad"
	fi
else
	echo "[-] /etc/xinetd.conf file can't found, Result : Not Search"
fi
