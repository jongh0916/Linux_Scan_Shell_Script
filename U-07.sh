#!/bin/bash

PASSWD_OWN=$(ls -al /etc/passwd | awk '{print $3}')
PASSWD_MOD=$(ls -al /etc/passwd | awk '{print $1}')

echo "[!] U-07 /etc/passwd 파일 소유자 및 권한 설정 Checking ..."
if [ $PASSWD_OWN = "root" -a $PASSWD_MOD = "-rw-r--r--" ];then
	echo "[+] /etc/passwd files is safe, Result : Good"
else
	echo "[-] /etc/passwd files is not safe, Result : Bad"
fi