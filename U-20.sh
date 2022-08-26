#!/bin/bash

ID_CHECK=$(cat /etc/passwd | egrep "ftp|anonymous" | wc -l)
CONFIG_CHECK=$(cat /etc/vsftpd/vsftpd.conf 2>/dev/null | awk 'match($0,/anonymous_enable=[A-Za-z]{2}/) {print substr($0,RSTART+17,RLENGTH-17)}')
CONFIG_CHECKK=$(cat /etc/vsftpd.conf 2>/dev/null | awk 'match($0,/anonymous_enable=[A-Za-z]{2}/) {print substr($0,RSTART+17,RLENGTH-17)}')
count=0
echo "[!] U-20 Anonymous FTP 비활성화 Checking..."
if [ $ID_CHECK -eq 0 ];then
	echo "[+] No vulnerable accounts found"
else
	echo "[-] vulnerable accounts found"
	echo "================================================================================================"
	echo "$(cat /etc/passwd | egrep "ftp|anonymous")"
	echo "================================================================================================"
	count=$(expr $count + 1)
fi

if [ $(echo $CONFIG_CHECK | egrep "no|NO" | wc -l) -gt 0 -o $(echo $CONFIG_CHECKK | egrep "no|NO" | wc -l) -gt 0 ];then
	echo "[+] vsftpd.conf file config is very well"
else
	echo "[-] vsftpd.conf config is vulnerable"
	count=$(expr $count + 1)
fi

if [ $count -eq 2 ];then
	echo "[-] ftp service is vulnerable, Result : Bad"
else
	echo "[+] ftp service is safe, Result : Good"
fi