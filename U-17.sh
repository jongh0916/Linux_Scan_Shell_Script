#!/bin/bash

HOSTS=/etc/hosts.equiv
RHOSTS=/etc/.rhosts

echo "[!] U-17 $HOME/.rhosts, hosts.equiv 사용 금지 Checking ..."
if [ $(service login status 2>/dev/null | wc -l) -eq 0 -a $(service shell status 2>/dev/null | wc -l) -eq 0 -a $(service exec status 2>/dev/null | wc -l) -eq 0 ];then
	if test -f $HOSTS
	then
		echo "[+] $HOSTS file is found"
		FILE_OWN=$(ls -al $HOSTS | awk '{print $3}')
		if [ $FILE_OWN = "root" -o $FILE_OWN = $(who | grep tty | awk '{print $1}') ];then
			echo "[+] $HOSTS file owner is safe"
			if [ $(ls -al $HOSTS | awk '{print $1}') = "-rw-------" ];then
				echo "[+} $HOSTS file permission is safe"		
				if [ $(cat $HOSTS | grep + | wc -l) -eq 0 ];then
					echo "[+] $HOSTS file config is safe, Result : Good"
				else    
					echo "[-] $HOSTS file config is vulnerable, Result : Bad"
				fi
			else
				echo "[-] $HOSTS file permission is not safe, Result : Bad"
			fi
		else
			echo "[-] $HOSTS file owner is not safe, Result : Bad"
		fi
	else    
		echo "[+] $HOSTS file can't found, Result : Good"
	fi      

	if test -f $RHOSTS
	then
                echo "[+] $RHOSTS file is found"
                FILE_OWN=$(ls -al $RHOSTS | awk '{print $3}')
                if [ $FILE_OWN = "root" -o $FILE_OWN = $(who | grep tty | awk '{print $1}') ];then
                        echo "[+] $RHOSTS file owner is safe"
                        if [ $(ls -al $RHOSTS | awk '{print $1}') = "-rw-------" ];then
                                echo "[+} $RHOSTS file permission is safe"               
                                if [ $(cat $RHOSTS | grep + | wc -l) -eq 0 ];then
                                        echo "[+] $RHOSTS file config is safe, Result : Good"
                                else    
                                        echo "[-] $RHOSTS file config is vulnerable, Result : Bad"
                                fi      
                        else    
                                echo "[-] $RHOSTS file permission is not safe, Result : Bad"
                        fi      
                else    
                        echo "[-] $RHOSTS file owner is not safe, Result : Bad"
                fi      
        else    
                echo "[+] $RHOSTS file can't found, Result : Good"
        fi
else
	if [ $(service login status | wc -l) -ne 0 ];then
		echo "[-] login service is found, Result : Bad"
	fi
	if [ $(service shell status | wc -l) -eq 0 ];then
		echo "[-] shell service is found, Result : Bad"
	fi
	if [ $(service exec status | wc -l) -eq 0 ];then
		echo "[-] exec service is found, Result : Bad"
	fi
fi