#!/bin/bash
hostname=`ifconfig eth0 | awk  '/inet/ {print $2}' |awk -F. 'END{print $4}'`
ip=`ifconfig eth0 | awk  '/inet/ {print $2}'`
sed -i '/cluster-node-timeout/ s/^#//' /etc/redis/6379.conf
sed -i '/cluster-enabled yes/ s/^#//' /etc/redis/6379.conf
sed -i '/cluster-config-file/ s/^#//' /etc/redis/6379.conf
echo "###########停止进程#####################################"
netstat -antup|grep redis &&  redis-cli -h $ip -p 63$hostname shutdown && echo "stop success"
sleep 2
echo "###########启动进程#####################################"
/etc/init.d/redis_6379 start  && netstat -antup|grep redis |wc -l
redis-cli -h $ip -p 63$hostname cluster info
