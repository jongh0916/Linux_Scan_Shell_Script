#!/bin/bash

FILE_CHECK=($(find ./ -type f -perm -2 -ls 2>/dev/null | awk '{print $11}'))
FILE_COUNT=$(echo "$FILE_CHECK" | wc -l)
count=0

echo "[!] U-15 world writable 파일 점검 Checking ..."
if [ $FILE_COUNT -gt 0 ];then
	for file in "${FILE_CHECK[@]}";
	do
		echo "   [-] $file file is vulnerable"
		count=$(expr $count + 1)
	done
fi

if [ $count -eq 0 ];then
	echo "[+] No such world writable file, Result : Good"
else
	echo "[-] $count world writable files are found, Result : Bad"
fi