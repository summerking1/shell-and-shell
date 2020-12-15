#!/bin/bash
if [ -d "/home/$uesr/manager1001" ]; then
    echo "${RED}本机manager1001存在..."
else
    # yum install -y unzip zip &>/dev/null
    pushd $src_dir >/dev/null 2>&1
    unzip $manager1001_zip -d $manager1001_soft &>/dev/null
    popd >/dev/null 2>&1
fi

rm -rf /home/$user/manager1001bk
mv /home/$user/manager1001 /home/$user/manager1001bk
mkdir -p /home/$user/manager1001
unzip /home/$user/update/com.smartmining.manager.zip -d /home/$user/manager1001 &> /dev/null
mv /home/$user/manager1001/com.smartmining.manager/* /home/$user/manager1001
rm -rf /home/$user/manager1001/com.smartmining.manager
rm -rf /home/$user/manager1001/config
cp -r /home/$user/manager1001bk/config /home/$user/manager1001/
docker run -v /home/$user/manager1001/:/manager1001/ \
    -v /etc/localtime:/etc/localtime:ro \
    --net=host -d --name manager1001 --privileged=true \
    --log-opt max-size=10m --log-opt max-file=3 kjava \
    /bin/sh -c "cd /manager1001/; \
    java -Duser.timezone=Asia/Shanghai -Djava.security.egd=file:/dev/./urandom \
    -jar com.smartmining.manager.jar "

echo "manager1001安装结束"