#!/bin/bash
ip = `ifconfig ens3|awk '/netmask/ {print $2}'`
hostnamectl set-hostname oracle
hostname oracle
echo  $ip oracle >> /etc/hosts

echo "#####安装包及yum源#####"
yum -y install zip unzip wget ftp xhost gcc glibc sysstat elfutils-libelf-devel compat-libstdc++-33 gcc-c++ libaio-devel unixODBC unixODBC-devel
wget -O /etc/yum.repos.d/CentOS7-Base-163.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo  &>/dev/null && echo "#####安装完成#####"
sleep 2
yum clean all && yum repolist

echo "#####1.添加用户组和用户，并给用户设置密码#######"
groupadd dba
groupadd oinstall
useradd -g oinstall -G dba oracle
echo 123456 | passwd --stdin oracle && echo "修改密码成功" 

echo "#####2.创建安装目录，分配用户组与权限#######"
mkdir -p /u01/app/oracle/product
mkdir /u01/app/oradata
chown -R oracle:oinstall /u01
chmod -R 755 /u01

echo "#####3.解压软件包#####"
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

unzip linux.x64_11gR2_database_1of2.zip -d /u01/  &>/dev/null
unzip linux.x64_11gR2_database_2of2.zip -d /u01/  &>/dev/null

echo "#####4.在/etc目录下创建一个名为oraInst.loc的文件并修改权限#####"
echo "inventory_loc=/u01/app/oracle/oraInventory"> /etc/oraInst.loc
echo "inst_group=oinstall">> /etc/oraInst.loc
chown oracle:oinstall /etc/oraInst.loc
chmod 664 /etc/oraInst.loc

echo "#####5.修改系统参数#####"
echo  fs.file-max = 6815744  >>/etc/sysctl.conf
echo  fs.aio-max-nr = 1048576 >>/etc/sysctl.conf
echo  kernel.shmall = 2097152 >>/etc/sysctl.conf
echo  kernel.shmmax = 2147483648 >>/etc/sysctl.conf
echo  kernel.shmmni = 4096  >>/etc/sysctl.conf
echo  kernel.sem = 250 32000 100 128 >>/etc/sysctl.conf
echo  net.ipv4.ip_local_port_range = 9000 65500 >>/etc/sysctl.conf
echo  net.core.rmem_default = 4194304 >>/etc/sysctl.conf
echo  net.core.rmem_max = 4194304 >>/etc/sysctl.conf
echo  net.core.wmem_default = 262144 >>/etc/sysctl.conf
echo  net.core.wmem_max = 1048576 >>/etc/sysctl.conf
sysctl -p

echo oracle soft nproc 2047 >> /etc/security/limits.conf
echo oracle hard nproc 16384 >> /etc/security/limits.conf
echo oracle soft nofile 1024 >> /etc/security/limits.conf
echo oracle hard nofile 65536 >> /etc/security/limits.conf

echo session required /lib/security/pam_limits.so >>/etc/pam.d/login
echo session required pam_limits.so >>/etc/pam.d/login

echo  "if [ \$USER = \"oracle\" ]; then"  >>/etc/profile
echo  "if [ \$SHELL = \"/bin/ksh\" ]; then"  >>/etc/profile
echo  ulimit -p 16384   >>/etc/profile
echo  ulimit -n 65536   >>/etc/profile
echo  else      >>/etc/profile
echo  ulimit -u 16384 -n 65536  >>/etc/profile
echo  fi                        >>/etc/profile
echo  umask 022         >>/etc/profile
echo  fi                >>/etc/profile
source /etc/profile


echo  export ORACLE_BASE=/u01/app/oracle  >> /home/oracle/.bash_profile
echo  "export ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/db_1"    >> /home/oracle/.bash_profile
echo  export ORACLE_SID=bpas            >> /home/oracle/.bash_profile
echo  "export PATH=\$ORACLE_HOME/bin:\$PATH"    >> /home/oracle/.bash_profile
echo  export LANG=en_US.UTF-8           >> /home/oracle/.bash_profile
echo  "export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib"          >> /home/oracle/.bash_profile
echo  "export CLASSPATH=\$ORACLE_HOME/jre:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib"          >> /home/oracle/.bash_profile

source /home/oracle/.bash_profile

#export DISPLAY=$ip:0.0
#强制安装
#rpm -ivh --force --nodeps pdksh-5.2.14-1.i386.rpm

