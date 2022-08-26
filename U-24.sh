#!/bin/bash

NFS_CHECK=$(ps -ef | egrep "\[nfsd\]|\[lockd\]|\[statd\]" | wc -l)
echo "[!] U-24 NFS 서비스 비활성화 Checking..."
echo
if [ $NFS_CHECK -eq 0 ];then
	echo "[+] NFS service not found, Result : Good"
else
	echo "================================================================================================"
	echo "$(ps -ef | egrep "\[nfsd\]|\[lockd\]|\[statd\]")"
	echo "================================================================================================"
	echo "$NFS_CHECK found NFS service, Result : Bad"
fi