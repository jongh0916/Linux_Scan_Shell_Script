#!/bin/bash

CHECK_FILES=$(find / -user root -type f \( -perm -04000 -o -perm -02000 \) -xdev -ls 2>/dev/null)
FILES_COUNT=$(echo "$CHECK_FILES" | wc -l)

echo "[!] U-13 SUID, SGID, 설정 파일점검 Checking..."
if [ $FILES_COUNT -gt 0 ];then
	echo "================================================================================================"
	echo "$CHECK_FILES"
	echo "================================================================================================"
	echo "[-] $FILES_COUNT files found, result : Bad"
else
	echo "[+] No such SUID(SGID) file, result : Good"
fi