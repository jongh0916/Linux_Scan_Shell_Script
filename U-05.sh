#!/bin/sh

HOME_PROFILE=$(cat $HOME/.profile 2>/dev/null | egrep "\.:|::|:.:" | wc -l)
ETC_PROFILE=$(cat /etc/profile 2>/dev/null | egrep "\.:|::|:.:" | wc -l)

echo "[!] U-05 root홈, 패스 디렉터리 권한 및 패스 설정 Checking ..."
if [ $HOME_PROFILE -ne 0 -o $ETC_PROFILE -ne 0 ];then
	echo "[+] profile config is very well, Result : Good"
else
	echo "[-] profile config is vulnerable, Result : Bad"
fi