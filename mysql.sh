#!/bin/bash
echo "--------------------------检查mysql-----------------------"

mysql -V &> /dev/null
if [ $? -eq 0 ]; then
  echo "检查到mysql已安装!"
else
  # yum install -y unzip zip &>/dev/null
  # echo "Checking  user :"
  if [ $(id -u) != "0" ]; then
    echo -e "${RED}Error: You must be root to run this script, please use root to install"
    exit 1
  else
    echo " "
  fi

  egrep "^$user" /etc/passwd >&/dev/null
  if [ $? -ne 0 ]; then
    groupadd $group
    useradd -g $user $group
    echo $PASWD | passwd $user --stdin &> /dev/null
    chage -M 99999 $user
  else
    echo ""
  fi
  echo "正在解压mysql安装包请稍后.."
  install_mysql5() {
    pushd $src_dir >/dev/null 2>&1
    unzip $mysql_zip -d /home/$user &> /dev/null
    popd >/dev/null 2>&1
  }
  install_mysql5

  #Execute to create a soft connection
  soft_connection() {
    mv /usr/local/mysql /usr/local/mysql.bk$(date '+%Y%m%d%H%M%S') &> /dev/null
    ln -s /home/$user/mysql/ /usr/local/mysql
    mv /usr/bin/mysql /usr/bin/mysql.bk$(date '+%Y%m%d%H%M%S') &> /dev/null
    ln -s /home/$user/mysql/bin/mysql /usr/bin/mysql
    mv /usr/bin/mysqladmin /usr/bin/mysqladmin.bk$(date '+%Y%m%d%H%M%S') &> /dev/null
    ln -s /home/$user/mysql/bin/mysqladmin /usr/bin/mysqladmin
    mv /usr/bin/mysqld /usr/bin/mysqld.bk$(date '+%Y%m%d%H%M%S') &> /dev/null
    ln -s /home/$user/mysql/support-files/mysql.server /usr/bin/mysqld
    mv /etc/my.cnf /etc/my.cnf.bk$(date '+%Y%m%d%H%M%S') &> /dev/null
    ln -s /home/$user/mysql/my.cnf /etc/my.cnf
    chown -R $user:$user /home/$user/
    mkdir /etc/my.cnf.
  }
  soft_connection

  Permissions() {
    # chown -R $user:$user /home/$user/
    chmod 777 -R /usr/local/mysql
    chmod a+wrx /usr/bin/mysqld
    chmod 777 /usr/bin/mysql
    chmod 644 /etc/my.cnf
  }
  Permissions

  mysqld start

#   echo "--------------------create db...wait...--------------------"
  create_db() {
    mysql -u${mysql_user} -p"${mysql_passwd}" -e "${create_db_sql0}" 2>/dev/null
    mysql -u${mysql_user} -p"${mysql_passwd}" -e "${create_db_sql1}" 2>/dev/null
    mysql -u${mysql_user} -p"${mysql_passwd}" -e "${create_db_sql2}" 2>/dev/null
  }
  create_db

#   echo "-------------------add port:23306..wait--------------------"
  firewall-cmd --zone=public --add-port=23306/tcp --permanent
  firewall-cmd --reload

#   echo "--------------------配置远程连接..wait----------------------"
  mysql -u${mysql_user} -p"${mysql_passwd}" < $conf_dir/mysql5.sql 2>/dev/null

  echo "--------------------本机安装mysql5成功----------------------"
fi
