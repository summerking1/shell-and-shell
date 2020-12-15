#!/bin/bash
if [ -d "/home/$uesr/manager1000" ]; then
    echo "${RED}本机manager1000存在..."
else
    # yum install -y unzip zip &>/dev/null
    pushd $src_dir >/dev/null 2>&1
    unzip $manager1000_zip -d $manager1000_soft &>/dev/null
    mv com.smartmining.manager.zip /home/smartmining/update/ 
    popd >/dev/null 2>&1
fi

rm -rf /home/$user/manager1000bk
mv /home/$user/manager1000 /home/$user/manager1000bk
mkdir -p /home/$user/manager1000
unzip /home/$user/update/com.smartmining.manager.zip -d /home/$user/manager1000 &> /dev/null
mv /home/$user/manager1000/com.smartmining.manager/* /home/$user/manager1000
rm -rf /home/$user/manager1000/com.smartmining.manager
rm -rf /home/$user/manager1000/config
cp -r /home/$user/manager1000bk/config /home/$user/manager1000/
docker run -v /home/$user/manager1000/:/manager1000/ \
    -v /etc/localtime:/etc/localtime:ro \
    --net=host -d --name manager1000 --privileged=true \
    --log-opt max-size=10m --log-opt max-file=3 kjava \
    /bin/sh -c "cd /manager1000/; \
    java -Duser.timezone=Asia/Shanghai -Djava.security.egd=file:/dev/./urandom \
    -jar com.smartmining.manager.jar "

echo "manager1000安装结束"
