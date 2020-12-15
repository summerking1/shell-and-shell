#!/bin/sh 
# chmod +x dk_log_clean.sh
# ./dk_log_clean.sh
echo -e "\033[44;37m 本机docker容器日志大小如下 \033[0m"

logs=$(find /var/lib/docker/containers/ -name *-json.log*)

for log in $logs
        do
            ls -sh $log
        done

echo -e "\033[44;37m 开始清理docker容器日志 \033[0m"

for log in $logs
        do
                cat /dev/null > $log
        done

echo -e "\033[44;37m 清理完毕 \033[0m"  

for log in $logs
        do
            ls -sh $log
        done

