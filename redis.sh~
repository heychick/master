#!/bin/bash
hostname=`ifconfig eth0 | awk  '/inet/ {print $2}' |awk -F. 'END{print $4}'`
ip=`ifconfig eth0 | awk  '/inet/ {print $2}'`
ifconfig eth0 | awk  '/inet/ {print $2}'
tar -zxf redis-4.0.8.tar.gz && cd redis-4.0.8/
yum -y install gcc php php-fpm >/dev/null  && echo "安装软件完成"

make &&  make install 
 ./utils/install_server.sh<<EOF






EOF 
sed -i "93s/6379/63$hostname/" /etc/redis/6379.conf && echo "修改端口"
sed -i "70s/127.0.0.1/$ip/" /etc/redis/6379.conf   && echo "修改ip"

/etc/init.d/redis_6379 stop  && echo "stop"
sleep 3
/etc/init.d/redis_6379 start  && echo "start"

netstat -antup | grep redis 
