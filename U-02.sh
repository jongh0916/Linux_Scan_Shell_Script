#!/bin/bash
FILENAME=/etc/pam.d/common-password
MINLEN=$(cat $FILENAME | awk 'match($0, /minlen=[0-9]*/) {print substr($0, RSTART+7, RLENGTH-7)}')
CREDIT=( "lcredit=-1" "ucredit=-1" "dcredit=-1" "ocredit=-1" "difok=N" )
COUNT=0

echo "[!] U-02 패스워드 복잡성 설정 Checking ..."
if [ $MINLEN -ge 8 ];then
	CHECK=$(cat $FILENAME | grep password | grep credit | tr " " "\n" )

	for i in $CHECK
	do
		for j in "${CREDIT[@]}"
		do
			if [ $i == $j ];then
				COUNT=`expr $COUNT + 1`
			fi
		done
	done
	if [ $COUNT -ne 5 ]; then
		echo "[-] Password policy config is vulnerable, Result : Bad"
	else
		echo "[+] Password policy config is very well, Result : Good"
	fi
else
	echo "[-] Password length config is vulnerable, Result : Bad"
fi