#!/bin/sh
PASSWD=/etc/passwd
SHADOW=/etc/shadow
passwd_sec=$(cat $PASSWD | awk 'match($0, /:x:/)' | wc -l)
passwd_line=$(cat $PASSWD | wc -l)
shadow_sec=$(cat $SHADOW | awk 'match($0, /:\$[0-9]+\$/)' | wc -l)

echo "[!] U-04 패스워드 파일 보호 Checking ..."
if [ $passwd_sec -eq $passwd_line ];then
	echo "[+] $PASSWD config is very well, Result : Good"
else
	echo "[-] $PASSWD config is Vulnerable, Result : Bad"
fi

if [ $shadow_sec -gt 0 ];then
	echo "[+] $SHADOW config is very well, Result : Good"
else
	echo "[-] $SHADOW config is Vulnerable, Result : Bad"
fi
