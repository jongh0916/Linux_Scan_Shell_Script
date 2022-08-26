#!/bin/bash

CRON_CHECK=$(ls -al /etc/crontab)
CRON_PER=($(ls -ld /etc/cron* | egrep "^d" | awk '{print $1 $9}'))
CRON_OWN=($(ls -ld /etc/cron* | awk '{print $3 $9}'))
COUNT=0
RESULT=0

echo "[!] U-22 crond 파일 소유자 및 권한 설정 Checking..."
echo
echo "[!] Checking /etc/crontab ..."
if [ $(echo $CRON_CHECK | awk '{print $1}') != "-rw-r--r--" ];then
	echo "[-] /etc/crontab Permission is vulneralbe"
	$COUNT=$(expr $COUNT + 1)
else
	echo "[+] /etc/crontab Permission is safe"
fi

if [ $(echo $CRON_CHECK | awk '{print $3}') != "root" ];then
	echo "[-] /etc/crontab Owner is vulnerable"
	$COUNT=$(expr $COUNT + 1)
else
	echo "[+] /etc/crontab Owner is safe"
fi

RESULT=$(expr $RESULT + $COUNT)
COUNT=0
echo
echo "[!] Checking crontab subfiles Permission ..."
echo "================================================================================================"
for permit in "${CRON_PER[@]}"
do
	FILE_PER=$(echo "$permit" | awk 'match($0,/^.{10}/) {print substr($0, RSTART, RLENGTH)}')
	FILE_NAME=$(echo "$permit" | awk 'match($0,/\/[/.A-Za-z]+/) {print substr($0, RSTART, RLENGTH)}')
	if [ $FILE_PER != "-rw-r-----" -o $FILE_PER != "drw-r-----" ];then
		SEARCH=$(ls -ld $FILE_NAME)
		echo "$SEARCH"
		COUNT=$(expr $COUNT + 1)
	fi
done
echo "================================================================================================"
echo "[-] $COUNT files vulnerable"
echo
RESULT=$(expr $RESULT + $COUNT)
COUNT=0
echo "[!] Checking crontab subfiles Owner ..."
echo "================================================================================================"
for owner in "${CRON_OWN[@]}"
do
        FILE_OWN=$(echo "$owner" | awk 'match($0,/^root/) {print substr($0, RSTART, RLENGTH)}')
        FILE_NAME=$(echo "$owner" | awk 'match($0,/\/[/.A-Za-z]+/) {print substr($0, RSTART, RLENGTH)}')
	if [ $FILE_OWN != "root" ];then
                echo "$(ls -ld $FILE_NAME)"
                COUNT=$(expr $COUNT + 1)
        fi      
done    
echo "================================================================================================"
echo "[-] $COUNT files vulnerable"
echo
RESULT=$(expr $RESULT + $COUNT)

if [ $RESULT -eq 0 ];then
	echo "[+] crontab service is safe, Result : Good"
else
	echo "[-] crontab service is vulnerable, Result : Bad"
fi