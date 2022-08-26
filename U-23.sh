#!/bin/bash

FILE=/etc/xinetd.d/xinetd.conf
CHECK_LIST=( "echo" "discard" "daytime" "chargen" )
COUNT=0

echo "[!] U-23 DoS 공격에 취약한 서비스 비활성화 Checking..."
echo
for check in "${CHECK_LIST[@]}"
do
	XINETD=$(cat $FILE | grep "$check" | wc -l)
	XINETD_CHECK=$(cat $FILE | grep -A 8 "$check" | grep disable | awk 'NR<=1 {print}' | grep yes | wc -l)
	if [ $XINETD -eq 1 ];then
		if [ $XINETD_CHECK -eq 1 ];then
			echo "[+] $check service is already disable"
		else
			echo "[-] $check service config is vulnerable"
			COUNT=$(expr $COUNT + 1)
		fi
	else
		echo "[-] $check service not found"
	fi
done

if [ $COUNT -eq 0 ];then
	echo "[+] System is safe, Result : Good"
else
	echo "[-] System is vulnerable, Result : Bad"
fi