#!/bin/bash
hostname=`ifconfig eth0 | awk  '/inet/ {print $2}' |awk -F. 'END{print $4}'`
ip=`ifconfig eth0 | awk  '/inet/ {print $2}'`
sed -i    's/cluster-enabled yes/#&/'    /etc/redis/6379.conf
sed -i    's/cluster-config-file nodes-6379.conf/#&/'     /etc/redis/6379.conf
sed -i    's/cluster-node-timeout 5000/#&/'   /etc/redis/6379.conf
echo "###########停止进程#####################################"
netstat -antup|grep redis &&  redis-cli -h $ip -p 63$hostname shutdown && echo "stop success"
sleep 2
echo "###########启动进程#####################################"
/etc/init.d/redis_6379 start  && netstat -antup|grep redis |wc -l
redis-cli -h $ip -p 63$hostname cluster info

