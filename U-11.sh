#!/bin/bash

echo "[!] U-11 /etc/syslog.conf 파일 소유자 및 권한 설정 Checking ..."
if test -f /etc/syslog.conf
then
	echo "[+] /etc/syslog.conf file is found"
	syslog=$(ls -al /etc/syslog.conf | awk '{print $1}')
	if [ $syslog = "-rw-r-----" ];then
		echo "[+] /etc/syslog.conf file is safe, Result : Good"
	else
		echo "[-] /etc/syslog.conf file is vulnerable, Result : Bad"
	fi
elif test -f /etc/rsyslog.conf
	then
		echo "[+] /etc/rsyslog.conf file is found"
		rsyslog=$(ls -al /etc/rsyslog.conf | awk '{print $1}')
		if [ $rsyslog = "-rw-r-----" ];then
			echo "[+] /etc/rsyslog.conf file is safe, Result : Good"
		else
			echo "[-] /etc/rsyslog.conf file is vulnerable, Result : Bad"
		fi
else

	echo "[-] No such syslog(rsyslog) file, Result : Bad"
fi