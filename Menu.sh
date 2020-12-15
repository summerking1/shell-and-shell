#!/bin/bash

# echo -e "$GREEN"
# echo "                   Please check your follow Version:"
# echo "+----------------------------------------------------------------------+ "
# echo "|      NGINX          |        nginx-1.14.0                           |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      MiningCompute  |        MiningCompute                          |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      ELASTICSEARCH  |        elasticsearch-7.6.0                    |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      EUREKA         |        eureka                                 |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      MANGER T1000   |        manger t1000                           |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      MANGER T1001   |        manger t1001                           |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      ZUUL           |        ZUUL                                   |"
# echo " ----------------------------------------------------------------------- "
# echo "|      REDIS          |        redis-5.0.8                            |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      MYSQL          |        mysql5.7                               |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      DOCKER         |        docker-18.06.0                         |"
# echo " --------------------- ------------------------------------------------- "
# echo "|      JAVA           |        jdk-8u171-linux-x64                    |"
# echo "+----------------------------------------------------------------------+ "

######################################  Menu Start    ########################################
#Display menu and choose  install or not, then run it
Menu() {
  echo -e "$YELLOW"

  while :; do
    echo
    read -p "Do you want Configure host and Add user group?(y/n)" Configure_host_yn
    if [[ ! $Configure_host_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install Java?(y/n)" install_java_yn
    if [[ ! $install_java_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install Mysql?(y/n)" install_mysql_yn
    if [[ ! $install_mysql_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install Elasticsearch?(y/n)" install_elasticsearch_yn
    if [[ ! $install_elasticsearch_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install Redis?(y/n)" install_redis_yn
    if [[ ! $install_redis_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install Docker?(y/n)" install_Docker_yn
    if [[ ! $install_Docker_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install Nginx?(y/n)" install_ngx_yn
    if [[ ! $install_ngx_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install eureka?(y/n)" install_eureka_yn
    if [[ ! $install_eureka_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install MiningCompute?(y/n)" install_MiningCompute_yn
    if [[ ! $install_MiningCompute_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install MiningProxy?(y/n)" install_MiningProxy_yn
    if [[ ! $install_MiningProxy_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install managerT1000?(y/n)" install_managerT1000_yn
    if [[ ! $install_managerT1000_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

   while :; do
    echo
    read -p "Do you want Install zuul?(y/n)" install_zuul_yn
    if [[ ! $install_zuul_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

  while :; do
    echo
    read -p "Do you want Install managerT1001?(y/n)" install_managerT1001_yn
    if [[ ! $install_managerT1001_yn =~ ^[y,Y,n,N]$ ]]; then
      echo -e "\033[0mPlease input y or n\033[33m"
    else
      break
    fi
  done

#     while :; do
#     echo
#     read -p "Run a backup program?(y/n)" install_backup_yn
#     if [[ ! $install_backup_yn =~ ^[y,Y,n,N]$ ]]; then
#       echo -e "\033[0mPlease input y or n\033[33m"
#     else
#       break
#     fi
#   done

#       while :; do
#     echo
#     read -p "Perform the update The program?(y/n)" install_update_yn
#     if [[ ! $install_update_yn =~ ^[y,Y,n,N]$ ]]; then
#       echo -e "\033[0mPlease input y or n\033[33m"
#     else
#       break
#     fi
#   done


  ###################################### Menu End    ########################################
}
Menu

#Configure host
if [ $Configure_host_yn == "y" -o $Configure_host_yn == "Y" ]; then
  . ./include/vhost.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Configure host!"
  echo ""
fi

#install java
if [ $install_java_yn == "y" -o $install_java_yn == "Y" ]; then
  . ./include/java.sh
else
  # echo -e "${BLUE}Not install or input wrong value for java!"
  echo ""
fi

#install mysql
if [ $install_mysql_yn == "y" -o $install_mysql_yn == "Y" ]; then
  . ./include/mysql.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Mysql!"
  echo ""
fi

#install elasticsearch
if [ $install_elasticsearch_yn == "y" -o $install_elasticsearch_yn == "Y" ]; then
  echo "You select install elasticsearch"
  . ./include/elasticsearch.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Elasticsearch!"
  echo ""
fi

#install redis
if [ $install_redis_yn == "y" -o $install_redis_yn == "Y" ]; then
  echo "You select install Redis."
  . ./include/redis.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Redis!"
  echo ""
fi

#install docker
if [ $install_Docker_yn == "y" -o $install_Docker_yn == "Y" ]; then
  . ./include/docker.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Docker!"
  echo ""
fi

#install nginx
if [ $install_ngx_yn == "y" -o $install_ngx_yn == "Y" ]; then
  echo "You select install Nginx."
  . ./include/nginx.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Nginx!"
  echo ""
fi

#install zuul
if [ $install_zuul_yn == "y" -o $install_zuul_yn == "Y" ]; then
  echo "You select install Zuul."
  . ./include/zuul.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Zuul!"
  echo ""
fi

#install eureka
if [ $install_eureka_yn == "y" -o $install_eureka_yn == "Y" ]; then
  echo "You select install Eureka."
  . ./include/eureka.sh
else
  # echo -e "${BLUE}Not install or input wrong value for Eureka!"
  echo ""
fi

#install MiningCompute
if [ $install_MiningCompute_yn == "y" -o $install_MiningCompute_yn == "Y" ]; then
  echo "You select install MiningCompute."
  . ./include/MiningCompute.sh
else
  # echo -e "${BLUE}Not install or input wrong value for MiningCompute!"
  echo ""
fi

#install MiningProxy
if [ $install_MiningProxy_yn == "y" -o $install_MiningProxy_yn == "Y" ]; then
  echo "You select install MiningProxy."
  . ./include/MiningProxy.sh
else
  # echo -e "${BLUE}Not install or input wrong value for MiningCompute!"
  echo ""
fi

#install managerT1000
if [ $install_managerT1000_yn == "y" -o $install_managerT1000_yn == "Y" ]; then
  echo "You select install ManagerT1000."
  . ./include/managerT1000.sh
else
  # echo -e "${BLUE}Not install or input wrong value for ManagerT1000!"
  echo ""
fi

#install managerT1001
if [ $install_managerT1001_yn == "y" -o $install_managerT1001_yn == "Y" ]; then
  echo "You select install ManagerT1001."
  . ./include/managerT1001.sh
else
  # echo -e "${BLUE}Not install or input wrong value for ManagerT1001!"
  echo ""
fi

#install datebak
# if [ $install_backup_yn == "y" -o $install_backup_yn == "Y" ]; then
#   echo "You select backup"
#   . ./include/backup.sh
# else
#   # echo -e "${BLUE}Not install or input wrong value for ManagerT1001!"
#   echo ""
# fi

# #install updata
# if [ $install_update_yn == "y" -o $install_update_yn == "Y" ]; then
#   echo "You select update"
#   . ./include/update.sh
# else
#   # echo -e "${BLUE}Not install or input wrong value for ManagerT1001!"
#   echo ""
# fi