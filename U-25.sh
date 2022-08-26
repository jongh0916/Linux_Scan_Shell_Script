#!/bin/bash

FILE=/etc/export

echo "[!] U-25 NFS 접근 통제 Checking..."
if test -f $FILE
then
	echo "[+] $FILE file found"
	CONFIG_CHECK=$(cat $FILE | egrep "^[^#]+" | wc -l)
	if [ $CONFIG_CHECK -gt 0 ];then
		echo "[+] NFS filtering is working, Result : Good"
	else
		echo "[-] NFS filtering is not working, Result : Bad"
	fi
else
	echo "[-] $FILE file not found, Result : Bad"
fi