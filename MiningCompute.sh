#!/bin/bash
if [ -d "/home/$uesr/MiningCompute" ]; then
  echo   "${RED}本机MiningCompute存在..."
else
  # yum install -y unzip zip &>/dev/null
  pushd  $src_dir >/dev/null 2>&1
  unzip  $MiningCompute_zip -d $MiningCompute_soft &> /dev/null
  popd >/dev/null 2>&1

  #配置slaves文件,添加所有worker节点
  #     sed -ri '$a'"$yu1" /home/$user/MiningCompute/conf/slaves
  #     sed -ri '$a'"$yu2" /home/$user/MiningCompute/conf/slaves
  #     sed -ri '$a'"$yu3" /home/$user/MiningCompute/conf/slaves

  #     cat >>/home/$user/MiningCompute/conf/spark-env.sh <<EOF
  # export SPARK_SSH_OPTS="-p 10022"
  # export SPARK_MASTER_IP=$yu1
  # export SPARK_MASTER_HOST=$yu1
  # export SPARK_MASTER_WEBUI_PORT=28080
  # export SPARK_MASTER_PORT=27077
  # export SPARK_WORKER_CORES=8
  # export SPARK_WORKER_INSTANCES=1
  # export SPARK_WORKER_MEMORY=16g
  # export SPARK_LOCAL_DIRS=/home/$user/MiningCompute/tmp
  # export SPARK_CLASSPATH=/home/$user/MiningCompute/libs/*
  # export SPARK_PID_DIR=/home/$user/MiningCompute/pids
  # EOF
  # fi

  #启动 这里的$path有问题待解决…………………………
  su - $user << EOF
echo "export SPARK_HOME=/home/smartmining/MiningCompute" >>~/.bashrc
echo "export PATH=\$PATH:\$SPARK_HOME/bin" >>~/.bashrc
EOF

fi

# 在主节点执行：
# cd /home/smartmining/MiningCompute/sbin/ && ./start-all.sh

sleep 2
echo "------------------本机安装MiningCompute成功------------------"
