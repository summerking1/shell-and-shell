#!/bin/bash
echo "检查nginx......"
if [ -d "$ngx_dir" ]; then
  echo   "本机nginx存在..."
else
  pushd $src_dir >/dev/null 2>&1
  echo "正在解压nginx安装包请稍后.."
  unzip $ngx_zip -d /home/$user &> /dev/null
  chmod a+x -R $ngx_dir
  mv html.zip /home/smartmining/update/
  popd >/dev/null 2>&1
fi

rm -rf /home/$user/nginx/htmlbk
mv /home/$user/nginx/html /home/$user/nginx/htmlbk
unzip /home/$user/update/html.zip -d /home/$user/nginx/ &> /dev/null
/home/$user/nginx/sbin/nginx

echo "安装nginx完成......"

# pids="$( ps -ef | grep 'nginx: master' | grep -v grep | awk '{print $2}')"
# for j in $pids; do
#   kill -9 $j
# done

# sleep 2
# echo "开始启动 nginx"
# su - $user << EOF
#  cd /;
#  /home/$user/nginx/sbin/nginx;
#  exit;
# EOF
# echo "结束启动 nginx"
