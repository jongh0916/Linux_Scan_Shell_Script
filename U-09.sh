#!/bin/sh

HOSTS_OWN=$(ls -al /etc/hosts | awk '{print $3}')
HOSTS_MOD=$(ls -al /etc/hosts | awk '{print $1}')

echo "[!] U-09 /etc/hosts 파일 소유자 및 권한 설정 Checking ..."

if [ $HOSTS_OWN = "root" -a $HOSTS_MOD = "-rw-------" ];then
        echo "[+] /etc/hosts file is safe, Result : Good"
else
        echo "[-] /etc/hosts file is vulnerable, Result : Bad"
fi