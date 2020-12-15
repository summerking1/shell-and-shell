#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:~/bin

#当前本机ip按照实际情况更改(多网卡问题待解决)
serverip=20.55.224.65

#es集群ip按照实际情况更改
ip1='"20.55.224.70"'
ip2='"20.55.224.71"'
ip3='"20.55.224.72"'

#redis集群IP端口按照实际情况更改
redisgroup=20.55.224.70:27000,20.55.224.70:27001,20.55.224.71:27000,20.55.224.71:27001,20.55.224.72:27000,20.55.224.72:27001

#伪域名按照实际情况更改
in_ip1='20.55.224.65 elx.eureka1'
in_ip2='20.55.224.66 elx.eureka2'

in_ip3='20.55.224.65 elx.zuul1'
in_ip4='20.55.224.66 elx.zuul2'

in_ip5='20.55.224.65 elx.nginx1'
in_ip6='20.55.224.66 elx.nginx2'

in_ip7='20.55.224.73 elx.mysql1'
in_ip8='20.55.224.74 elx.mysql2'

in_ip9='20.55.224.67 elx.master1'
in_ip10='20.55.224.68 elx.proxy1'
in_ip11='20.55.224.70 elx.server1'

in_ip12='20.55.224.67 elx.compute1' 
in_ip13='20.55.224.68 elx.compute2'
in_ip14='20.55.224.70 elx.compute3'

in_ip15='20.55.224.70 elx.redis1'
in_ip16='20.55.224.71 elx.redis2'
in_ip17='20.55.224.72 elx.redis3'

in_ip18='20.55.224.70 elx.es1'
in_ip19='20.55.224.71 elx.es2'
in_ip20='20.55.224.72 elx.es3'

in_ip21='20.55.224.67 elx.hdfs1'

#ssh免密登录IP(MIningCompute集群)
# elx.compute1
# elx.compute2
# elx.compute3

#Config echo color
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
WHITE='\033[0;0m'
WARN='\033[41;37m'


#ssh
Ssh_Groups="elx.compute1 elx.compute2 elx.compute3"
group='smartmining'
user='smartmining'
PASSWD='SmArT@2019'


#Check root privileges
[ $(id -u) != 0 ] && {
  echo   -e "$RED You need root privileges to run it!"
  exit   1
}

run_dir=$(pwd)
#current dir
src_dir=$(pwd)/src

conf_dir=$(pwd)/conf

#Sysbit variable
sysbit=$(uname -a | grep 64 | wc -l)
[ $sysbit -eq 1 ] && sys_bit="x86_64" || sys_bit="i386"
#also can try `getconf LONG_BIT`

#Def db_bit
[ $sys_bit == "i386" ] && db_bit="i686" || db_bit="x86_64"

#Define nginx
ngx_dir='/home/smartmining/nginx'
ngx_start="/home/smartmining/nginx/sbin"
ngx_version="nginx-1.14.0"
ngx_zip="${src_dir}/nginx.zip"

#Define MYSQL
mysql_version1="mysql-5.7.21"
# mysql_version2="mysql-8.0.20"
mysql_zip="${src_dir}/mysql.zip"
mysql_user="root"
mysql_passwd="hadoop"
mysql_data="/data/mysql"
mysql_local="/usr/local/mysql"
mysql_chk_u=$(grep mysql /etc/passwd | wc -l)
create_db_sql0="CREATE DATABASE elxcloud_T1000 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
create_db_sql1="CREATE DATABASE elxcloud_T1001 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
#MiningCompute添加一个空库
create_db_sql2="CREATE DATABASE hive DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

#Redis
redis_version1="redis-4.0.11"
redis_version2="redis-5.0.8"
redis_zip="redis-4.0.11.zip"
redis_zip5="redis-5.0.8.zip"
redis_install_dir="/home/smartmining"
redis_conf_dir="/etc/redis"
reids_pwd="smartdbm"

#Elasticsearch-6.3.1
ES_version1="elasticsearch-6.3.1"
elasticsearch_tar="elasticsearch-7.6.0-linux-x86_64.tar.gz"
elasticsearch_zip="elasticsearch-6.3.1.zip"
elasticsearch_version="elasticsearch-6.3.1"
elasticsearch_install_dir="/home/smartmining/"
elasticsearch_conf_dir="/home/smartmining/elasticsearch-6.3.1/config"
elasticsearch_data="/home/smartmining/data"
es_ch="/home/smartmining/elasticsearch-6.3.1"
pathdata='/home/smartmining/elasticsearch-6.3.1/data'
pathlogs='/home/smartmining/elasticsearch-6.3.1/logs'
httpport='29200'
transporttcpport='29300'
es_start_dir='/home/smartmining/elasticsearch-6.3.1/bin/elasticsearch'
unicasthosts="$ip1,$ip2,$ip3"

#Elasticsearch-7.6.0
ES_version2="elasticsearch-7.6.0"
elasticsearch_conf_dir2="/home/smartmining/elasticsearch-7.6.0/config"
es_ch2="/home/smartmining/elasticsearch-7.6.0"
pathdata2='/home/smartmining/elasticsearch-7.6.0/data'
pathlogs2='/home/smartmining/elasticsearch-7.6.0/logs'
es_start_dir2='/home/smartmining/elasticsearch-7.6.0/bin/elasticsearch'

#zuul
zuul_zip="${src_dir}/zuul.zip"
zuul_soft='/home/smartmining/'
kjava_tar="kjava.tar.gz"

#eureka
eureka_zip="${src_dir}/eureka.zip"
eureka_soft='/home/smartmining/'

#MiningCompute
yu1='elx.compute1'
yu2='elx.compute2'
yu3='elx.compute3'
MiningCompute_zip="${src_dir}/MiningCompute.zip"
MiningCompute_soft='/home/smartmining/'

#MiningProxy
MSProxy_zip="${src_dir}/MSProxy.zip"
MSProxy_soft='/home/smartmining/'
agent_conf='/home/smartmining/MSProxy/MiningProxy/com.smartmining.agent/config/application.properties'

#manager1000
manager1000_zip="${src_dir}/manager1000.zip"
manager1000_soft='/home/smartmining/'

#manager1001
manager1001_zip="${src_dir}/manager1001.zip"
manager1001_soft='/home/smartmining/'


