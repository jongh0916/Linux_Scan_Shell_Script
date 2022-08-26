#!/bin/bash

SHADOW_OWN=$(ls -al /etc/shadow | awk '{print $3}')
SHADOW_MOD=$(ls -al /etc/shadow | awk '{print $1}')

echo "[!] U-08 /etc/shadow 파일 소유자 및 권한 설정 Checking ..."
if [ $SHADOW_OWN = "root" -a $SHADOW_MOD = "-r--------" ];then
	echo "[+] /etc/shadow files is safe, Result : Good"
else   
        echo "[-] /etc/shadow files is vulnerable, Result : Bad"
fi