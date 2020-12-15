#!/bin/bash
# ssh-keygen -t rsa
# ssh-copy-id 192.168.0.186
# ssh 192.168.0.186

HOST_IPS=`sed -n '16,18p' $(pwd)/include/common.sh`
PASSWD='SmArT@2019'

#EOF的特殊性，将免密操作写了一个函数，循环时调用
function newauto(){
expect <<-EOF
  set timeout 10
  spawn ssh-copy-id  smartmining@${ip}
  expect {
  "yes/no" { send "yes\n";exp_continue }
  "password:" { send "${PASSWD}\n" }
  }
interact
expect eof
EOF
}
i=1

for ip in $HOST_IPS 
do
    num=$i
    ip=$(awk 'NR=='$num' {print $1}' $HOST_IPS)
#这里做了一下判断，IP为空时跳出循环，不然就一直循环下去了
  if [ -z $ip ]
  then
  	break
  else
      newauto
      sleep 1s
      : $((i++))
  fi
done