#!/bin/bash
# 自动重启docker
# 由于docker等命令是属于root用户下的
# 在smartmining用户下执行如docker ps -a 等命令会报权限问题
# 添加docker用户组，将smartmining用户添加至docker组
# gpasswd -a smartmining docker
# 注意重启参数按顺序填写
# ./Autodkrestart.sh eureka manager1000 zuul manager1001
seqLog=/home/smartmining/dkstart.log
TF1=$(docker inspect --format '{{.State.Running}}' $*)
TF2=`echo $TF1 | sed s/[[:space:]]//g`
correct="truetruetruetrue"

if [ $correct == $TF2 ];then
  echo "$(date +"%Y-%m-%d %H:%M:%S") docker各容器正常">> $seqLog
else
  # 停止所有docker容器
  docker stop $(docker ps -aq)
  until [ $# -eq 0 ]; do
    echo "开始启动: $1"
    echo "$(date +"%Y-%m-%d %H:%M:%S") $1开始启动">> $seqLog
    docker start $1
    if_exist=$(docker inspect --format '{{.State.Running}}' $1)
    until [ "${if_exist}" = "true" ]; do
      if_exist=$(docker inspect --format '{{.State.Running}}' $1)
    done
    echo "$(date +"%Y-%m-%d %H:%M:%S") $1启动成功">> $seqLog
    echo "等待60s--------------------------">> $seqLog
    sleep 60
    shift
  done
  echo "$(date +"%Y-%m-%d %H:%M:%S")===startAll success===" >> $seqLog
fi
