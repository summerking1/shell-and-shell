#!/bin/bash
#backup variable
RED='\033[0;31m'
XWEEK=$(date "+%w")
XTIME=$(date "+%Y-%m-%d,%H:%m:%s")
XDATANAME=data_${XWEEK}.tar.gz
XLOGNAME=excute_${XWEEK}.log
XPATH=/home/smartmining/elasticsearch-6.3.1/databak
XDATABASE0='elxcloud_T1000'
XLOGNAME0=export1000_${XWEEK}.log
XDATABASE1='elxcloud_T1001'
XLOGNAME1=export1001_${XWEEK}.log
user=smartmining

echo -e " Please select the program that needs to be backed:
		$RED 1)$RED ES;
		$RED 2)$RED mysqlT1000;
        $RED 3)$RED mysqlT1001;"
echo -e "$RED"
read -p "Please input the number of your choose:" backup_version_select
case $backup_version_select in
  1)
    echo "Start backing up es data"
    mkdir -p ${XPATH}
    cd ${XPATH}
    echo " ${XTIME}: start delete last version" > ${XLOGNAME}
    rm -rf ${XDATANAME}
    echo " ${XTIME}: end delete last version,start bak data" >> ${XLOGNAME}
    tar -cvzf ${XPATH}/${XDATANAME} ../data >&/dev/null
    echo " ${XTIME}: end bak data" >> ${XLOGNAME}
    ;;

  2)
    echo  "Start backing up elxcloud_T1000 data"
    mkdir -p /home/$user/databak/
    cd /home/$user/databak/
    echo " ${XTIME}: start delete last version" > ${XLOGNAME0}
    rm -rf ${XDATABASE0}_${XWEEK}.sql
    echo " ${XTIME}: end delete last version,start export data" >> ${XLOGNAME0}
    cd /home/$user/mysql/bin
    ./mysqldump -uroot -phadoop -P23306 ${XDATABASE0} > /home/$user/databak/${XDATABASE0}_${XWEEK}.sql
    echo " ${XTIME}: end export data" >> /home/$user/databak/${XLOGNAME0}
    ;;

  3)
    echo "Start backing up elxcloud_T1001 data"
    mkdir -p /home/$user/databak/
    cd /home/$user/databak/
    echo " ${XTIME}: start delete last version" > ${XLOGNAME1}
    rm -rf ${XDATABASE1}_${XWEEK}.sql
    echo " ${XTIME}: end delete last version,start export data" >> ${XLOGNAME1}
    cd /home/$user/mysql/bin
    ./mysqldump -uroot -phadoop -P23306 ${XDATABASE1} > /home/$user/databak/${XDATABASE1}_${XWEEK}.sql
    echo " ${XTIME}: end export data" >> /home/$user/databak/${XLOGNAME1}
    ;;
esac
