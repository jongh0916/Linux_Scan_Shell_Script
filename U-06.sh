#!/bin/sh

NOUSER=$(find / -nouser 2>/dev/null | wc -l)
NOGROUP=$(find / -nogroup 2>/dev/null | wc -l)
echo "[!] U-06 파일 및 디렉터리 소유자 설정 Checking ..."
if [ $NOUSER -eq 0 -a $NOGROUP -eq 0 ]; then
	echo "[+] System files all safe, Result : Good"
else
	echo "================================================================================================"
	echo `find / -nouser -o -nogroup 2>/dev/null`
	echo "================================================================================================"
	echo "[-] Vulnerable Files are detected, Result : Bad"
fi