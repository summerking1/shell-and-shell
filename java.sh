#!/bin/bash
echo "----------------------------------------------------------"

install_java() {
    echo "检查java......"
    java -version &>/dev/null
    if [ $? -eq 0 ]; then
        echo "检查到java已安装!"
    else
        # 安装jdk
        pushd $src_dir >/dev/null 2>&1
        rpm -ivh jdk-8u171-linux-x64.rpm &>/dev/null
        pid="sed -i '/export CLASSPATH/d' /etc/profile"
        eval $pid #删除已经存在的CLASSPATH环境变量
        cat >>/etc/profile <<EOF
export JAVA_HOME=/usr/java/latest
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
EOF
        source /etc/profile #刷新环境变量
        popd >/dev/null 2>&1
        echo "java环境安装完成......"
    fi
}
install_java
