#!/bin/bash

if [ -d "/home/$uesr/MSProxy" ]; then
    echo "${RED}本机MSProxy存在..."
else
    echo "正在解压文件"
    pushd $src_dir >/dev/null 2>&1
    unzip $MSProxy_zip -d $MSProxy_soft &>/dev/null
    popd >/dev/null 2>&1

    sed -i "3,3s/^/#/" $agent_conf
    echo "spring.redis.cluster.nodes=$redisgroup" >> $agent_conf
    echo "spring.redis.password=$reids_pwd" $agent_conf
    # echo "正在配置MiningMaster设置...."
    # #配置master.properties
    # echo "mining.master.ip = $serverip" >>$MSProxy_soft/MSProxy/MiningMaster/config/master/master.properties
    # echo "mining.master.port = 10100" >>$MSProxy_soft/MSProxy/MiningMaster/config/master/master.properties
    # echo "mining.master.timeout = 30000" >>$MSProxy_soft/MSProxy/MiningMaster/config/master/master.properties
    # echo "mining.master.mode = 0" >>$MSProxy_soft/MSProxy/MiningMaster/config/master/master.properties
    # #配置cluster.properties
    # echo "cluster[0] = $serverip:10090" >>$MSProxy_soft/MSProxy/MiningMaster/config/master/cluster.properties
    # echo "MiningMaster配置完成...."
    # echo "正在配置MiningServer设置...."
    # #配置server.properties
    # echo "spark.cacheURL = hdfs://elx.hdfs1:28020/smartmining/" >>$MSProxy_soft/MSProxy/MiningServer/config/server.properties
    # echo "spark.cacheDir = dbm/cache/ " >>$MSProxy_soft/MSProxy/MiningServer/config/server.properties
    # echo "server.port = 28200" >>$MSProxy_soft/MSProxy/MiningServer/config/server.properties
    # echo "MiningServer配置完成...."
    # echo "正在配置MiningProxy设置...."  proxy.properties environment.properties
fi

sleep 2
echo "------------------本机安装MSProxy成功------------------"
