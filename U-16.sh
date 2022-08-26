#!/bin/bash
  
FILE_CHECK=($(find /dev -type f -ls 2>/dev/null | awk '{print $11}'))
FILE_COUNT=$(echo "$FILE_CHECK" | wc -l)
count=0

echo "[!] U-16 /dev에 존재하지 않는 device 파일 점검 Checking ..."
if [ $FILE_COUNT -gt 0 ];then
        for file in "${FILE_CHECK[@]}";
        do      
                echo "   [-] $file file is vulnerable"
                count=$(expr $count + 1)
        done    
fi      

if [ $count -eq 0 ];then
        echo "[+] No such device file, Result : Good"
else    
        echo "[-] $count device files are found, Result : Bad"
fi