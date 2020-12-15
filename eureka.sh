#!/bin/bash
function ck_eureka_docker_env() {
    echo "开始安装eureka......"
    docker -v &>/dev/null
    if [ $? -eq 0 ]; then
        echo "检查到Docker环境，开始装载eureka.....Please wait"

        pushd $src_dir >/dev/null 2>&1
        echo "正在解压文件.."
        unzip $eureka_zip -d $eureka_soft &>/dev/null
        tar -xvf $kjava_tar &>/dev/null
        docker load <kjava.tar &>/dev/null
        popd >/dev/null 2>&1

        docker run -v /home/$user/eureka/:/eureka/ \
            -v /etc/localtime:/etc/localtime:ro \
            --net=host -d --name eureka --privileged=true \
            --log-opt max-size=10m --log-opt max-file=3 kjava \
            /bin/sh -c "cd /eureka/;java -jar com.smartmining.eureka.jar "
        echo "eureka安装结束"
    else
        echo "您的服务器未安装docker，请先安装docker  ヾ(ToT)Bye~Bye~"
        exit 0
    fi

    # 创建公用网络==bridge模式
    #docker network create share_network
}
ck_eureka_docker_env


