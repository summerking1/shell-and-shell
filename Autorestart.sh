#!/bin/bash
#脚本用到lsof命令注意yum一下   yum install -y lsof

#log文件
MonitorLog=/home/smartmining/autostart.log 
user=smartmining 

#检测nginx（注意修改端口）
curtime=$(date "+%Y-%m-%d %H:%M:%S")
checkNginx=`echo "SmArT@2019" | sudo -S lsof -i:80 |grep 'nginx' |grep -v grep |grep -v agent|sort | tail -1 | cut -f 1 -d ' '`
if [[ $checkNginx != 'nginx' ]]; then
    echo "$curtime 系统检测到nginx,已挂掉,启动中...." >> $MonitorLog;
    /home/$user/nginx/sbin/nginx 
    if [ $? -eq 0 ]; then
        echo "$curtime nginx启动完成" >> $MonitorLog;
    else
        echo "$curtime nginx启动失败" >> $MonitorLog;
    fi
else
    echo "$curtime 系统检测到nginx运行正常" >> $MonitorLog;
fi

#检测Redis
#checkRedis=`echo "SmArT@2019" | sudo -S lsof -i:6379 |grep 'redis-ser' |grep -v grep |grep -v agent|sort | tail -1 | cut -f 1 -d ' '`
checkRedis=`lsof -i:27000 |grep 'redis-ser' |grep -v grep |grep -v agent|sort | tail -1 | cut -f 1 -d ' '`
if [[ $checkRedis != 'redis-ser' ]]; then
    echo "$curtime 系统检测到Redis已挂掉,启动中...." >> $MonitorLog;
    #单节点6379（注意改lsof端口）
    #/home/$user/redis-5.0.8/src/redis-server /etc/redis.conf
    #多节点2700（注意改lsof端口）
    /home/smartmining/redis-5.0.8/utils/create-cluster/create-cluster start
    if [ $? -eq 0 ]; then
        echo "$curtime Redis启动完成" >> $MonitorLog;
    else
        echo "$curtime Redis启动失败" >> $MonitorLog;
    fi
else
    echo "$curtime 系统检测到Redis运行正常" >> $MonitorLog;
fi

#检测mysql
checkMysql=`echo "SmArT@2019" | sudo -S lsof -i:23306 |grep 'mysql' |grep -v grep |grep -v agent|sort | tail -1 | cut -f 1 -d ' '`
if [[ $checkMysql != 'mysqld' ]]; then
    echo "$curtime 系统检测到Mysql已挂掉,启动中...." >> $MonitorLog;
    mysqld start 
    if [ $? -eq 0 ]; then
        echo "$curtime Mysql启动完成" >> $MonitorLog;
    else
        echo "$curtime Mysql启动失败" >> $MonitorLog;
    fi
else
    echo "$curtime 系统检测到Mysql运行正常" >> $MonitorLog;
fi

#检测elasticsearch
ESPID=`ps -ef | grep elasticsearch | grep -w 'elasticsearch' | grep -v 'grep' | awk '{print $2}' | head -n 1` &>/dev/null
if [[ $ESPID ]] ; then
    echo "$curtime 系统检测到Elasticsearch运行正常" >> $MonitorLog
else
    echo "$curtime 系统检测到Elasticsearch已挂掉,启动中...." >> $MonitorLog
    # /home/smartmining/elasticsearch-7.6.0/bin/elasticsearch -d 
    /home/$user/elasticsearch-6.3.1/bin/elasticsearch -d
    if [ $? -eq 0 ]; then
        echo "$curtime Elasticsearch启动完成" >> $MonitorLog;
    else
        echo "$curtime Elasticsearch启动失败" >> $MonitorLog;
    fi
fi
