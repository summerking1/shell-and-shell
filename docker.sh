#!/bin/bash
#Check docker environment and install
function ckinstall_docker_env() {
	echo "检查Docker......"
	docker -v &>/dev/null
	if [ $? -eq 0 ]; then
		echo "检查到Docker已安装!"
		# exit 0
	else
		echo "服务器未安装docker，现在为您安装docker环境...Please wait"
		pushd $src_dir/docker >/dev/null 2>&1
		echo "开始安装"
		rpm -ivhU *  --nodeps --force
		echo "安装docker环境...安装完成!"
		unzip update.zip -d $manager1000_soft &>/dev/null
		unzip databak.zip -d $manager1000_soft &>/dev/null
		popd >/dev/null 2>&1
	fi
	# 创建公用网络==bridge模式
	#docker network create share_network
}
ckinstall_docker_env

# 执行函数
set_docker() {
	#启动docker
	systemctl start docker.service &>/dev/null
	#设置开机自启动
	sudo systemctl enable docker &>/dev/null
}
set_docker

sleep 2
echo "--------------------本机安装docker成功--------------------"
