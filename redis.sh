#!/bin/bash
# read -p "please input your server IP like 192.168.0.9: " redisip
# echo $redisip
echo -e " Please choose REDIS version:
		$WHITE 1)$WHITE $redis_version1;
		$WHITE 2)$WHITE $redis_version2;"
echo -e "$WHITE"

# 判断
while :; do
  echo
  read -p "Please input the number of your choose:" redis_version_select
  if [[ ! $redis_version_select =~ ^[1,2]$ ]]; then
    echo -e "\033[0mPlease input 1 or 2\033[33m"
  else
    break
  fi
done

case $redis_version_select in
1)
	echo "you choose $redis_version1"
	if [ -d "$redis_install_dir/redis-4.0.11" ]; then
		echo "本机redis存在..."
	else
		pushd $src_dir >/dev/null 2>&1
		echo "正在解压redis安装包请稍后.."
		unzip $redis_zip -d /home/$user &>/dev/null
		chmod a+x -R $redis_install_dir/$redis_version1
		rm -rf /$redis_install_dir/$redis_version1/redis_cluster/7000/data/*
		rm -rf /$redis_install_dir/$redis_version1/redis_cluster/7001/data/*
		cd $redis_install_dir/$redis_version1/src
		echo "开始启动服务器redis 27000"
		echo "bind $serverip" >>$redis_install_dir/$redis_version1/redis_cluster/7000/redis_7000.conf
		echo "bind $serverip" >>$redis_install_dir/$redis_version1/redis_cluster/7001/redis_7001.conf
		./redis-server ../redis_cluster/7000/redis_7000.conf
		echo "开始启动服务器redis 27001"
		./redis-server ../redis_cluster/7001/redis_7001.conf
		popd >/dev/null 2>&1
		echo "--------------------本机安装redis4.0.11成功--------------------"
	fi
	;;

2)
	echo "you choose $redis_version2"
	if [ -d "$redis_install_dir/redis-5.0.8" ]; then
		echo "本机redis存在..."
	else
		echo "正在解压redis安装包请稍后.."
		install_redis() {
			pushd $src_dir >/dev/null 2>&1
			unzip $redis_zip5 -d $redis_install_dir &>/dev/null
			popd >/dev/null 2>&1
		}
		install_redis

		echo "正在启动redis"
		config_redis() {
			pushd $src_dir >/dev/null 2>&1
            chmod a+x -R /home/$user/redis-5.0.8/
			cd /home/$user/redis-5.0.8/utils/create-cluster
            sed -i "/reids_pwd=smartdbm/ a\\ip=$serverip" create-cluster
			./create-cluster start
			echo "start redis success"
			popd >/dev/null 2>&1
		}
		config_redis

		sleep 2
		echo "--------------------本机安装redis5.0.8成功-----------------"
	fi
	;;
esac
