#!/bin/sh
FILE_NAME=/etc/pam.d/common-auth
NO_MAGIC_ROOT=$(cat $FILE_NAME | awk 'match($0, /^no_magic_root/)'| wc -l)
DENY=$(cat $FILE_NAME | awk 'match($0, /deny=[0-9]{1}/) {print substr($0, RSTART+5, RLENGTH-5)}')
UNLOCK_TIME=$(cat $FILE_NAME | awk 'match($0, /unlock_time=[0-9]*/) {print substr($0, RSTART+12, RLENGTH-12)}' | wc -l)
RESET=$(cat $FILE_NAME | grep no_magic_root | grep reset | wc -l)

echo "[!] U-03 계정 잠금 임계값 설정 Checking ..."
if [ $NO_MAGIC_ROOT -eq 1 -a $DENY -le 10 -a $UNLOCK_TIME -eq 1 -a $RESET -eq 1 ];then
	echo "[+] $FILE_NAME config is very well, Result : Good"
else
	echo "[-] $FILE_NAME config is vulnerable, Result : Bad"
fi