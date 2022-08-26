#!/bin/bash

CHECKLIST=(".profile" ".kshrc" ".cshrc" ".bashrc" ".bash_profile" ".login" ".exrc" ".netrc")
USER=($(ls -l /home | grep d | awk '{print $9}'))
count=0
countp=0

echo "[!] U-14 사용자, 시스템 시작파일 및 환경파일 소유자 및 권한 설정 Checking ..."

echo "[+] Checking root account ..."
ROOT_FILE=($(ls -al /root | awk '{print $9}' | egrep "^[.]{1}.+"))
for file in "${ROOT_FILE[@]}";
do
	for i in "${CHECKLIST[@]}";
	do
		if [ $file = $i ];then
			if [ $(ls -al /root/$file | awk '{print $3}') = "root" ];then
				continue
			else
				echo "   [-] /root/$file file is vulnerable"
				count=$(expr $count + 1)
			fi
			GROUP_PERMIT=$(ls -al /root/$file | awk 'match($1,/[-rwxs]{10}/){print substr($0,RSTART+5,RLENGTH-9)}')
			OTHER_PERMIT=$(ls -al /root/$file | awk 'match($1,/[-rwxs]{10}/){print substr($0,RSTART+8,RLENGTH-9)}')
			if [ $GROUP_PERMIT = "-" -a $OTHER_PERMIT = "-" ];then
				continue
			else
				echo "   [-] /root/$file permission is vulnerable"
				countp=$(expr $countp + 1)
			fi

		fi
	done
done

echo "[+] Checking other account ..."
for user in "${USER[@]}";
do
	USER_FILE=($(ls -al /home/$user | awk '{print $9}' | egrep "^[.]{1}.+"))
	for file in "${USER_FILE[@]}";
	do
		for i in "${CHECKLIST[@]}";
		do
			if [ $file = $i ];then
				if [ $(ls -al /home/$user/$file | awk '{print $3}') = $user ];then
					continue
				else
					echo "   [-] /home/$user/$file file is vulnerable"
					count=$(expr $count + 1)
				fi
				GROUP_PERMIT=$(ls -al /home/$user/$file | awk 'match($1,/[-rwxs]{10}/){print substr($0,RSTART+5,RLENGTH-9)}')
				OTHER_PERMIT=$(ls -al /home/$user/$file | awk 'match($1,/[-rwxs]{10}/){print substr($0,RSTART+8,RLENGTH-9)}')
				if [ $GROUP_PERMIT = "-" -a $OTHER_PERMIT = "-" ];then
					continue
				else
					echo "   [-] /home/$user/$file permission is vulnerable"
					countp=$(expr $countp + 1)
				fi
			fi
		done
	done
done	
if [ $count -gt 0 ];then
	echo "[-] $count files's owner vulnerable, Result : Bad"
fi
if [ $countp -gt 0 ];then
	echo "[-] $countp files permission are vulnerable, Result : Bad"
fi
if [ $count -eq 0 -a $countp -eq 0 ];then
	echo "[+] System account is safe, Result : Good"
fi