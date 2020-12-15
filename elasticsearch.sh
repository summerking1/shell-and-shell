#!/bin/bash

# read -p "please input your server IP like 192.168.0.9: " serverip
# echo $serverip
# read -p 'please input your server group IP like "192.168.0.9","192.168.0.8","192.168.0.7": ' servergpip
# echo $servergpip

echo -e " Please choose ES version:
		$WHITE 1)$WHITE $ES_version1;
		$WHITE 2)$WHITE $ES_version2;"
echo -e "$WHITE"

# 判断
while :; do
  echo
  read -p "Please input the number of your choose:" ES_version_select
  if [[ ! $ES_version_select =~ ^[1,2]$ ]]; then
    echo -e "\033[0mPlease input 1 or 2\033[33m"
  else
    break
  fi
done

case $ES_version_select in
  1)
    echo "you choose $ES_version1"
    if [ -d "$elasticsearch_conf_dir" ]; then
      echo "本机es已存在..."
    else
    
      pushd $src_dir >/dev/null 2>&1
      unzip $elasticsearch_zip -d $elasticsearch_install_dir &> /dev/null
      # mkdir $elasticsearch_data
      popd >/dev/null 2>&1

      #方案一：写死
      echo "node.name: es0" >> $elasticsearch_conf_dir/elasticsearch.yml
      echo "path.data: $pathdata" >> $elasticsearch_conf_dir/elasticsearch.yml
      echo "path.logs: $pathlogs" >> $elasticsearch_conf_dir/elasticsearch.yml
      echo "network.host: $serverip" >> $elasticsearch_conf_dir/elasticsearch.yml
      echo "http.port: $httpport" >> $elasticsearch_conf_dir/elasticsearch.yml
      echo "transport.tcp.port: $transporttcpport" >> $elasticsearch_conf_dir/elasticsearch.yml
      echo "discovery.zen.ping.unicast.hosts: [$unicasthosts]" >> $elasticsearch_conf_dir/elasticsearch.yml
      echo "xpack.ml.enabled: false" >> $elasticsearch_conf_dir/elasticsearch.yml

      #配置操作系统文件访问设置
      mv -f /etc/security/limits.conf /etc/security/limits.confbak
      cp $conf_dir/limits.conf /etc/security
      echo "正在配置操作系统文件访问设置.."
      mv -f /etc/sysctl.conf /etc/sysctl.confbak
      cp $conf_dir/sysctl.conf /etc
      #使系统配置生效
      sysctl -p &> /dev/null
      chown -R $user:$user $es_ch
      echo "es安装成功正在使用非root用户启动.."
      echo "启动执行./home/非root用户/elasticsearch-6.3.1/bin/elasticsearch -d"
      su - $user << EOF
cd /;
./home/smartmining/elasticsearch-6.3.1/bin/elasticsearch -d;
exit;
EOF
      systemctl stop firewalld.service &> /dev/null
      sleep 2
      echo "--------------------本机安装es6.....成功-------------------"
    fi
    ;;

 2)
    echo "you choose $ES_version2"
    if [ -d "$elasticsearch_conf_dir" ]; then
      echo "本机es已存在..."
    else
      systemctl stop firewalld.service &> /dev/null
      pushd $src_dir >/dev/null 2>&1
      tar -zxvf $elasticsearch_tar -C $elasticsearch_install_dir &> /dev/null
      mkdir $elasticsearch_data
      popd >/dev/null 2>&1

      echo "node.name: es0" >> $elasticsearch_conf_dir2/elasticsearch.yml
      echo "path.data: $pathdata2" >> $elasticsearch_conf_dir2/elasticsearch.yml
      echo "path.logs: $pathlogs2" >> $elasticsearch_conf_dir2/elasticsearch.yml
      echo "network.host: $serverip" >> $elasticsearch_conf_dir2/elasticsearch.yml
      echo "http.port: $httpport" >> $elasticsearch_conf_dir2/elasticsearch.yml
      echo "transport.tcp.port: $transporttcpport" >> $elasticsearch_conf_dir2/elasticsearch.yml
      #echo "discovery.zen.ping.unicast.hosts: [$servergpip]" >> $elasticsearch_conf_dir2/elasticsearch.yml
      echo "discovery.zen.ping.unicast.hosts: [$unicasthosts]" >> $elasticsearch_conf_dir2/elasticsearch.yml
      echo "xpack.ml.enabled: false" >> $elasticsearch_conf_dir2/elasticsearch.yml
      # 通过为 cluster.initial_master_nodes 参数设置符合主节点条件的节点的 IP 地址来引导启动集群
      echo "cluster.initial_master_nodes: ["es0"]" >> $elasticsearch_conf_dir2/elasticsearch.yml
      # 开启跨域访问支持，默认为false
      echo "http.cors.enabled: true" >> $elasticsearch_conf_dir2/elasticsearch.yml
      # 跨域访问允许的域名地址
      echo 'http.cors.allow-origin: "*"' >> $elasticsearch_conf_dir2/elasticsearch.yml

      mv $es_start_dir2 /home/$user/elasticsearch-7.6.0/bin/elasticsearchbak
      cp $conf_dir/elasticsearch /home/$user/elasticsearch-7.6.0/bin

      #配置操作系统文件访问设置
      mv -f /etc/security/limits.conf /etc/security/limits.confbak
      cp $conf_dir/limits.conf /etc/security

      echo "正在配置操作系统文件访问设置.."
      mv -f /etc/sysctl.conf /etc/sysctl.confbak
      cp $conf_dir/sysctl.conf /etc

      #使系统配置生效
      sysctl -p &> /dev/null
      chown -R $user:$user $es_ch2
      echo "es安装成功正在使用非root用户启动.."
      echo "启动执行./home/非root用户/elasticsearch-7.6.0/bin/elasticsearch -d"
      su - $user << EOF
 cd /;
 ./home/smartmining/elasticsearch-7.6.0/bin/elasticsearch -d;
 exit;
EOF

      sleep 2
      echo "--------------------本机安装es7.....成功-------------------"
    fi
    ;;

esac
