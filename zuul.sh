#!/bin/bash
function ck_zuuldocker_env() {
    echo "开始安装zuul......"
    docker -v &>/dev/null
    if [ $? -eq 0 ]; then
        echo "检查到Docker环境，开始装载zuul.....Please wait"

        pushd $src_dir >/dev/null 2>&1
        echo "正在解压文件.."
        unzip $zuul_zip -d $zuul_soft &>/dev/null
        tar -xvf $kjava_tar &>/dev/null
        docker load <kjava.tar &>/dev/null
        popd >/dev/null 2>&1

        docker run -v /home/$user/zuul/:/zuul/ \
            -v /etc/localtime:/etc/localtime:ro \
            --net=host -d --name zuul --privileged=true \
            --log-opt max-size=10m --log-opt max-file=3 kjava \
            /bin/sh -c "cd /zuul/;java -jar com.smartmining.zuul.jar "
        echo "zuul安装结束"
    else
        echo "您的服务器未安装docker，请先安装docker  ヾ(ToT)Bye~Bye~"
        exit 0
    fi

    # 创建公用网络==bridge模式
    #docker network create share_network
}
ck_zuuldocker_env

 
