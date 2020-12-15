#!/bin/bash
#此脚本文件配置/etc/hosts ,实现伪域名
echo "----------------------------------------------------------"

sed -ri '$a'"$in_ip1" /etc/hosts
sed -ri '$a'"$in_ip2" /etc/hosts
sed -ri '$a'"$in_ip3" /etc/hosts
sed -ri '$a'"$in_ip4" /etc/hosts
sed -ri '$a'"$in_ip5" /etc/hosts
sed -ri '$a'"$in_ip6" /etc/hosts
sed -ri '$a'"$in_ip7" /etc/hosts
sed -ri '$a'"$in_ip8" /etc/hosts
sed -ri '$a'"$in_ip9" /etc/hosts
sed -ri '$a'"$in_ip10" /etc/hosts
sed -ri '$a'"$in_ip11" /etc/hosts
sed -ri '$a'"$in_ip12" /etc/hosts
sed -ri '$a'"$in_ip13" /etc/hosts
sed -ri '$a'"$in_ip14" /etc/hosts
sed -ri '$a'"$in_ip15" /etc/hosts
sed -ri '$a'"$in_ip16" /etc/hosts
sed -ri '$a'"$in_ip17" /etc/hosts
sed -ri '$a'"$in_ip18" /etc/hosts
sed -ri '$a'"$in_ip19" /etc/hosts
sed -ri '$a'"$in_ip20" /etc/hosts
sed -ri '$a'"$in_ip21" /etc/hosts

echo "Restarting network. Please wait a moment..."
service network restart &>/dev/null
if [ $? -eq 0 ]; then
    echo ""
else
    echo -e "${RED}wow host name configured failed"
fi

egrep "^$user" /etc/passwd >&/dev/null
if [ $? -ne 0 ]; then
    echo -e "${GREEN}正在创建用户与用户组.."
    groupadd $group
    useradd -g $user $group
    echo $PASWD | passwd $user --stdin &>/dev/null
    chage -M 99999 $user
    echo -e "${GREEN}创建用户与用户组成功.."
    else
    echo -e "${RED}用户已存在.."
fi
