#!/bin/bash
ip = `ifconfig ens3|awk '/netmask/ {print $2}'`
hostnamectl set-hostname oracle
hostname oracle
echo  $ip oracle >> /etc/hosts

echo "#####安装包及yum源#####"
yum -y install zip unzip wget ftp xhost gcc glibc sysstat elfutils-libelf-devel compat-libstdc++-33 gcc-c++ libaio-devel unixODBC unixODBC-devel compat-libcap1.x86_64  ksh
wget -O /etc/yum.repos.d/CentOS7-Base-163.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo  &>/dev/null && echo "#####安装完成#####"
sleep 2
yum clean all && yum repolist

echo "1.创建Oracle用户和用户组"
groupadd dba
groupadd oinstall
useradd -g oinstall -G dba oracle
echo 123456 | passwd --stdin oracle && echo "修改密码成功" 

echo "2.创建安装目录"
mkdir -p /opt/Oracle12c
chown -R oracle:oinstall /opt/Oracle12c
chmod -R 775 /opt/Oracle12c
mkdir /opt/oraInventory
chown -R oracle:oinstall /opt/oraInventory
chmod 777 /opt/oraInventory

echo "3.修改系统内核参数"
echo  kernel.shmmax = 68719476736	  >>/etc/sysctl.conf
echo  kernel.shmall = 6029312	  >>/etc/sysctl.conf
echo  kernel.shmmni = 4096	  >>/etc/sysctl.conf
echo  kernel.sem =250 32000 100 128  >>/etc/sysctl.conf
echo  net.core.rmem_default = 262144  >>/etc/sysctl.conf
echo  net.core.rmem_max = 4194304  >>/etc/sysctl.conf
echo  net.core.wmem_default = 262144  >>/etc/sysctl.conf
echo  net.core.wmem_max = 262144  >>/etc/sysctl.conf
echo  net.ipv4.ip_local_port_range =9000 65500  >>/etc/sysctl.conf
echo  fs.file-max=65536  >>/etc/sysctl.conf
echo  fs.aio-max-nr=1048576  >>/etc/sysctl.conf
sysctl -p

echo "4.设置用户限制"
echo oracle soft nproc 2047 >> /etc/security/limits.conf
echo oracle hard nproc 16384 >> /etc/security/limits.conf
echo oracle soft nofile 1024 >> /etc/security/limits.conf
echo oracle hard nofile 65536 >> /etc/security/limits.conf
echo oracle soft stack 10240 >> /etc/security/limits.conf
echo oracle hard stack 10240 >> /etc/security/limits.conf

echo "4.配置环境变量"
echo "ORACLE_BASE=/opt/Oracle12c; export ORACLE_BASE"      >> /home/oracle/.bash_profile
echo "ORACLE_HOME=\$ORACLE_BASE/product/12.1.0/db_1; export ORACLE_HOME"   >> /home/oracle/.bash_profile
echo "ORACLE_SID=orcl; export ORACLE_SID"   >> /home/oracle/.bash_profile
echo "ORACLE_TERM=xterm; export ORACLE_TERM"   >> /home/oracle/.bash_profile
echo "PATH=/usr/sbin:\$PATH; export PATH"   >> /home/oracle/.bash_profile
echo "PATH=\$ORACLE_HOME/bin:\$PATH; export PATH"   >> /home/oracle/.bash_profile
echo "LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH"   >> /home/oracle/.bash_profile
echo "CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib; export CLASSPATH"   >> /home/oracle/.bash_profile
echo "if [ \$USER = \"oracle\" ]; then"   >> /home/oracle/.bash_profile
echo "if [ \$SHELL = \"/bin/ksh\" ]; then"   >> /home/oracle/.bash_profile
echo ulimit -p 16384   >> /home/oracle/.bash_profile
echo ulimit -n 65536   >> /home/oracle/.bash_profile
echo else   >> /home/oracle/.bash_profile
echo ulimit -u 16384 -n 65536   >> /home/oracle/.bash_profile
echo fi   >> /home/oracle/.bash_profile
echo fi   >> /home/oracle/.bash_profile

source /home/oracle/.bash_profile

echo "#####6.ftp取软件包#####"
ftp -n <<EOF
open 192.168.1.254
user ftp \n 
cd share/
prompt
bin
mget linuxamd64_12102_database_1of2.zip linuxamd64_12102_database_2of2.zip pdksh-5.2.14-1.i386.rpm   
bye
EOF
echo "ftp下载包完成"

unzip linuxamd64_12102_database_1of2.zip -d /opt/  &>/dev/null
unzip linuxamd64_12102_database_2of2.zip -d /opt/  &>/dev/null
echo "解压完成"




