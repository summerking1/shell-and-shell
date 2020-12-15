#!/bin/bash

    echo "Start updateing up html"
    rm -rf /home/$user/nginx/htmlbk
    mv /home/$user/nginx/html /home/$user/nginx/htmlbk
    unzip /home/$user/update/html.zip -d /home/$user/nginx/
   
  
    echo   "manager1000 will be update "
    rm -rf /home/$user/manager1000bk
    mv /home/$user/manager1000 /home/$user/manager1000bk
    mkdir -p /home/$user/manager1000
    unzip /home/$user/update/com.smartmining.manager.zip -d /home/$user/manager1000
    mv /home/$user/manager1000/com.smartmining.manager/* /home/$user/manager1000
    rm -rf /home/$user/manager1000/com.smartmining.manager
    rm -rf /home/$user/manager1000/config
    cp -r /home/$user/manager1000bk/config /home/$user/manager1000/
    docker run -v /home/$user/manager1000/:/manager1000/ \
      --net=host -d --name manager1000 --privileged=true \
      --log-opt max-size=10m --log-opt max-file=3 kjava \
      /bin/sh -c "cd /manager1000/;java -jar com.smartmining.manager.jar "
    ;;
  3)
    echo "manager1001 will be update "
    docker stop manager1001
    docker rm manager1001
    rm -rf /home/$user/manager1001bk
    mv /home/$user/manager1001 /home/$user/manager1001bk
    mkdir -p /home/$user/manager1001
    unzip /home/$user/update/com.smartmining.manager.zip -d /home/$user/manager1001
    mv /home/$user/manager1001/com.smartmining.manager/* /home/$user/manager1001
    rm -rf /home/$user/manager1001/com.smartmining.manager
    rm -rf /home/$user/manager1001/config
    cp -r /home/$user/manager1000bk/config /home/$user/manager1001/
    docker run -v /home/$user/manager1001/:/manager1001/ \
      --net=host -d --name manager1001 --privileged=true \
      --log-opt max-size=10m --log-opt max-file=3 kjava \
      /bin/sh -c "cd /manager1001/;java -jar com.smartmining.manager.jar "
    ;;
esac
