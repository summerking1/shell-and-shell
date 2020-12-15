#!/bin/bash
#check run status
echo -e "${YELLOW}+---------------------------------------------------------+"
echo ">>>>>>>>>>>>>Here are some states you can see<<<<<<<<<<<<<"

ck_java_v() {
	jps &>/dev/null
	if [ $? -eq 0 ]; then
		echo -e "${YELLOW}Your jdk version is as follows: "
		java -version 2>&1 | sed '1!d' | sed -e 's/"//g' | awk '{print $3}'
	else
		echo ""
	fi
}
ck_java_v

ck_docker_v() {
	docker version &>/dev/null
	if [ $? -eq 0 ]; then
		echo -e "${YELLOW}Your docker version is as follows: "
		docker -v 2>&1 | sed '1!d' | sed -e 's/"//g' | awk '{print $3}'
	else
		echo ""
	fi
}
ck_docker_v

ck_mysql_v() {
	mysql -V &>/dev/null
	if [ $? -eq 0 ]; then
		echo -e "${YELLOW}Your mysql version is as follows: "
		mysql -V
		# mysql -V 2>&1 | sed '1!d' | sed -e 's/"//g' | awk '{print $5}'
	else
		echo ""
	fi
}
ck_mysql_v

ck_es_v() {
	if [ $install_elasticsearch_yn == "y" -o $install_elasticsearch_yn == "Y" ]; then
		echo -e "${YELLOW}After starting es with a non-root user"
		echo -e "${YELLOW}You can perform: curl -XGET 'http://$serverip:$httpport/_cat/nodes?pretty' "
	fi
}
ck_es_v

ck_es_v() {
	if [ $install_redis_yn == "y" -o $install_redis_yn == "Y" ]; then
		echo -e "${YELLOW}After starting redis and then:"
		echo -e "${YELLOW}You can perform: ps -ef | grep redis "
	fi
}
ck_es_v

ck_ngx_v() {
	/$ngx_start/nginx -v &>/dev/null
	if [ $? -eq 0 ]; then
		echo -e "${YELLOW}Your nginx version is as follows: "
		/$ngx_start/nginx -v 2>&1 | sed '1!d' | sed -e 's/"//g' | awk '{print $3}'
		echo -e "You can perform: curl -XGET 'http://$serverip' "
	else
		echo ""
	fi
}
ck_ngx_v

ck_zuul() {
	if [ $install_zuul_yn == "y" -o $install_zuul_yn == "Y" ]; then
		echo -e "${YELLOW}After starting zuul ，You can perform: docker ps -a "
	fi
}
ck_zuul

ck_eureka() {
	if [ $install_eureka_yn == "y" -o $install_eureka_yn == "Y" ]; then
		echo -e "${YELLOW}After starting eureka ，You can perform: docker ps -a"
	fi
}
ck_eureka

#Calculate script runtime
echo "+----------------------------------------------------------+"
echo -e "${BLUE}------------------Calculate script runtime------------------"
if [[ $Configure_host_yn =~ ^[y,Y]$ ]] || [[ $install_java_yn =~ ^[y,Y]$ ]] || [[ $install_mysql_yn =~ ^[y,Y]$ ]] || [[ $install_zuul_yn =~ ^[y,Y]$ ]] || [[ $install_eureka_yn =~ ^[y,Y]$ ]]|| [[ $install_elasticsearch_yn =~ ^[y,Y]$ ]] || [[ $install_redis_yn =~ ^[y,Y]$ ]] || [[ $install_ngx_yn =~ ^[y,Y]$ ]] || [[ $install_MiningCompute_yn =~ ^[y,Y]$ ]] || [[ $install_MiningProxy_yn =~ ^[y,Y]$ ]] || [[ $install_mangerT1001_yn =~ ^[y,Y]$ ]]|| [[ $install_mangerT1000_yn =~ ^[y,Y]$ ]] || [[ $install_Docker_yn =~ ^[y,Y]$ ]]; then
	time_end=$(date +%s)
	((time_use = ${time_end} - ${time_begin}))
	((time_use_m = ${time_use} / 60))
	((time_use_s = ${time_use} % 60))
	echo "Install use ${time_use_m}Min ${time_use_s}Sec "
fi

#Close firewall?
stop_firewall() {
	if [ $os == "centos" ]; then
		if [[ $(awk -F. '{ print $1 }' /etc/redhat-release | grep 7 | wc -l) -eq 1 ]]; then
			systemctl stop firewalld.service &>/dev/null
			systemctl disable firewalld.service &>/dev/null
		fi
	fi
}
# stop_firewall

#Don't use selinux
close_selinux() {
	if [ "$os" == "centos" ]; then
		[ -f /etc/selinux/config ] && sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/selinux/config
		setenforce 0
	fi
}
close_selinux

chown -R smartmining:smartmining /home/$user
chmod a+x -R /home/$user/update
chmod a+x -R /home/$user/databak
# chmod a+x -R /home/$user/MSProxy

echo "+-------------------------Bye-bye--------------------------+"

exit 0
