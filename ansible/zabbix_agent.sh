#!/bin/bash
yum -y install gcc pcre-devel curl-devel net-snmp-devel  libevent-devel
cd /usr/local/src
tar -xf zabbix-3.4.4.tar.gz
cd zabbix-3.4.4
./configure --enable-agent
#--with-net-snmp --with-libcurl --enable-agent
make install
sed -i 's/^Server/#Server/' /usr/local/etc/zabbix_agentd.conf
sed -i 's/# StartAgents=3/StartAgents=0/' /usr/local/etc/zabbix_agentd.conf
sed -i 's/# ServerActive=/ServerActive=192.168.1.40/' /usr/local/etc/zabbix_agentd.conf
sed -i 's/Hostname=Zabbix server/Hostname=db1/' /usr/local/etc/zabbix_agentd.conf
sed -i 's/# RefreshActiveChecks=120/RefreshActiveChecks=120/' /usr/local/etc/zabbix_agentd.conf

