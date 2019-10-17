panglj@tedu.cn

###Day01    
>>
		配置文件		/etc/my.cnf
		数据存放路径	/var/lib/mysql 
		默认端口 		3306
		进程名		mysqld
		传输协议  	TCP
		进程所有者 	mysql
		进程所属者 	mysql
		错误日志文件	/var/log/mysqld.log
	扩展:
		/var/lib/mysql/库名/表名
		user.frm  表头信息
		user.ibd  表中数据和索引
>>
>>
>>首次登录密码在安装软件时随机生产   
随机密码存在日志文件/var/log/mysql.log   
查看随机密码 grep 'password' /var/log/mysqld.log
>>>
>>
>>mysql -h 数据库地址 -u用户 -p密码
>>>
>###修改root密码
>>>
		alter user root@"localhost" identified by "密码";   
		mysql -hlocalhost -uroot -p密码
>>>
>>>#####修改密码策略
	0 or LOW 			长度
	1 or MEDIUM(默认) 	长度,数字,小写/大写,和特殊字符
	2 or STRONG  		长度,数字,小写/大写和特殊字符;字典文件
	show variables like "%password%"; //查看变量
	set global validate_password_policy=0;//修改密码策略
	set global validate_password_length=6;//修改密码长度
	##永久配置
	vim /etc/my.cnf
		validate_password_policy=0
		validate_password_length=6
>>>
>>####sql分类
		DDL(定义) create alter frop	
		DML(操作) insert update delete
		DCL(控制) grant  revoke
		DTL(事物) commit rollback savepoint
>>>
>>库管理命令
>>>
		show databases;			//显示已有的库
		select user();			//显示连接用户
		select database();		//显示当前所在的库
		use 库名;				//切换库
		show tables;			//显示已有的表	
		create database 库名;	//创建新库
		drop database 库名;		//删除库
>>>
>>表管理命令
>>>
		create table 库名.表名 (
		字段名1 类型,
		字段名2 类型)
		default charset=utf8;
		//指定中文字符集
		##永久配置
		vim /etc/my.cnf
		character_set_server=utf8
		show variables like 'charac%';
>>>
>>>
>>字符类型
>>>
		定长char
			最大字符数255
		变长varchar
			按数据实际大小分配存储空间
		varvhar 1--65532
		大文本类型:text/blob
		字符数大于65535存储时使用
>>
>>数值类型
>>>
		#整数型
类型	 |		名称	|	有符号范围	|    无符号范围|   
---		 |    :--:	|:---:			|  :---:  
tinyint| 	微小整数|    -128~127	 |   0~255|   
smalint|	小整数	|	-32768~32767 | 0~65535
mediumint| 	中整型
int		  |   大整型
bigint	|	极大整型
unsigned|	使用无符号存储范围
		#浮点型|
		float |  单精度
		double	|	双精度

>>>
![blockchain](http://tts.tmooc.cn/ttsPage/LINUX/NSDTN201904/RDBMS1/DAY01/COURSE/LINUXNSD_V01RDBMS1DAY01_045)
>>日期类型
>>>
		datetime  未给字段赋值时该值为null
		1000-01-01 00:00:00~9999-12-31 23:59:59	
		timestamp  未给字段赋值时该值为系统当前时间
		1970-01-01 00:00:00~2038-01-19 00:00:00
		日期 date 		yyyymmdd
		年 	year		yyyy
		时间	time		HH:MM:SS
		
>>>
>>时间函数
>>>
		curtime()			获取当前的系统时间
		curdate()			获取当前的系统日期
		now()				获取当前系统日期和时间
		year()				获取年
		month()			获取月
		day()				获取日 
		date()				获取日期
		time()				获取时间
>>>
>>枚举类型
>>>
		enum 单选
		set  多选
>>>
>>>
---
###*Day02*
>>>
>>约束条件
>>>
		空null not null 非空
		键值key
		默认值default 
		额外设置        extra
>>>
>>修改表结构
>>>
>>>
		添加新字段	
			alter table 表名 add 字段名 类型 约束条件 [after|firsh]
		修改字段类型
			alter table 表名 modify 字段名 类型 约束条件 [after|firsh]
		修改字段名
			alter table 表名 change 源字段 新字段 类型 约束条件;
			alter table t1 change id stu_id  int ;
			可以修改字段类型
			alter table t1 change school xuexiao varchar(30) default "tedua";
		删除字段
			alter table 表名 drop 字段名
			删除多个字段
			alter table 表名 drop 字段名,drop 字段名.
		修改表名
			alter table 表名 rename 新表名;
>>>
>>INDEX普通索引
>>>
		索引类型包括:Btree B+tree hash
		优点:
			通过创建唯一性索引,可以保证数据库表中每一行数据的唯一性
			可以加快数据的查询速度
		缺点:
			当对表中的数据进行增删改的时候,索引也要动态的调整,降低了数据的维护速度
			索引需要占用物理空间
>>>	
>>>
		index使用规则
		一个表中可以有多个inxdex字段
		字段的值允许重复,且可以赋null值
		通常把做为查询条件的字段设置为index字段
		index字段标志是MUL
>>>
		#已有表创建索引
		create index 索引名 on 表名(字段名);
		#删除索引
		drop index 索引名 on 表名;
		#查询索引信息
		show index from 表名
				index_type:BTREE 使用二叉树木算法
		#创表时创建索引
		create table t1 (name char(10), index(name));
>>>
>>primary key主键
>>>
>>>
		使用规则
			字段值不允许重复,且不允许赋值NULL值
			一个表中只能有一个primary key字段
			多个字段都可以做为主键,称为复合主键,必须一起创建.
			主键字段的标志是PRI
			主键通常与auto_increment连用
			通常把表中唯一标识记录的字段设置为主键
>>>
		在已有表中添加主键
		alter table 表名 add primary key(字段名);
		创建表时创建主键
		#所有字段定义完，最后指定
		mysql> create table t9 (name char(10), name varchar(8),primary key(name));
		#直接在字段定义时约束
		mysql> create table t8 (name char(10) primary key);
		#复合主键
		mysql> create table payy(name varchar(22),class varchar(22),pay enum("1","2") ,primary key (name,class,pay));
		#删除主键,复合主键----删除后字段仍未非空
		alter table t8 drop primary key; 
		#自增长auto_increment
		mysql> create table a(id int unsigned primary key auto_increment);
		#有自增长需要先删除自增长.
		alter table t3 modify id int not null;
		alter table t3 drop primary key; 
		
>>>
>>foreign key 外键
>>>
>>>
		创建表时要指导引擎engine=innodb
		create table 表名 (  ......
			foreign key(字段名) references 表名(字段名)
			on update cascade
			on delete cascade
			)engine=innodb;
		CREATE TABLE gz(
		gz_id  int,
		gz float(7,2) ,
		foreign KEY(gz_id) references yg(yg_id)  //创建外键
		ON UPDATE cascade ON DELETE cascade //同步更新、同步删除
		)engine=innodb;	
		删除外键
		alter table gz drop foreign key gz_ibfk_1;	
>>>
>>>
>>>
>>>
----------------------------
###*Day03*
>>搜索路径
>>>
			查看检索目录
				show variables like "secure_file_priv";
				/var/lib/mysql-files/
			修改检索目录	
				mkdir /myload
				chown mysql /myload
				vim /etc/my.cnf
					[mysqld]
					secure_file_priv="/myload"	
				systemctl restart mysqld
>>>
>>数据导入与导出
>>>
			数据导入与导出	
				命令格式  mysql > load data infile  "目录/文件名"
							into table 库名 表名
							fields terminated by "分隔符"
							lines  terminated by "\n";
			数据导入步骤
					1.把系统文件拷贝到检索目录下
					2.创建存储数据库和表
					3.导入数据
					4.查看数据
			create table user ( name varchar(50),passwd char(1),uid int ,gid int,comment varchar(150),homedir varchar(150),shell varchar(50) );
			mysql> load data infile "/myload/passwd" into table db3.user fields terminated by ":" lines terminated by "\n";
			
>>>			
>>数据导出
>>>
		命令格式
	select id,name,uid from user where id<=10 into outfile  '/myload/user3.txt' ;
	select id,name,uid from user where id<=10 into outfile  '/myload/user3.txt' fields terminated by "###" ;
	select id,name,uid from user where id<=10 into outfile  '/myload/user3.txt' fields terminated by "###" lines terminated by "!!!";
		
>>>
----------------------------
###Day04
>>####授权
>>>
		grant 权限列表 on 库名 to 用户名@"客户地址" identified by "密码"
		with grant option;
		//with grant option 有授权权限,可选项
>>>
		
		连接方式:
		1.mysql -h192.168.4.50 -uyaya -p'1qaz@WSX'
		
		2.select user(); 登录用户及客户端端地址
		3.show grants; 用户显示自身访问权限	
				--权限列表
				all 所有权限
				usage 无权限
				select,update,insert 个别权限
				select,update(字段1,...字段N)指定字段
				--库名
				*.*  所有库所有表
				库名.* 一个表
				库名.表名 一张表	
				客户端地址
				% 所有主机
				192.168.4.% 网段内的所有主机
				192.168.4.1 1台主机
				localhost 数据库服务器本机			
		4.show grants for 用户名@"客户端地址";管理员查看已有授权用户权限
		5.set password=password(密码)  ;授权用户连接后修改连接密码
		6.set password for 用户名@"客户端地址"=password("密码"); 管理员重置授权用户连接密码
			set password for yaya@'%'=password("7ujm*IK<");
		7.drop user 用户名@"客户端地址"	 删除授权用户(必须有管理员权限)
>>>
>>授权库
>>>
>>>
		mysql库记录授权信息,主要表如下:
		user表 记录已有的授权(用户)及权限
		db表  记录已有授权用户对(数据库)的访问权限
		tables_priv表 记录已有授权用户对(表)的访问权限
		columns_priv表 记录已有授权用户对(字段)的访问权限
		#手动修改
		update mysql.tables_priv set table_priv= 'select,insert,update,delete' where user='admin';
		flush privileges;	
>>>
>>撤销权限
>>>
		命令格式:
		revoke 权限列表 on 库名.表 from 用户名@"客户端地址";
>>>
>>>
>>root密码(操作系统管理员root用户有权限配置)
>>>
		修改数据库管理员root用户本机登录密码
		mysqladmin -hlocalhost -uroot -p123qqq...A password "1qaz@WSX"
		恢复数据库管理员root用户本机登录密码
		1.停止mysql服务器程序
			systemctl stop mysqld
			vim /etc/my.cnf
				skip-grant-tables
				PS:密码策略要注释掉
		2.跳过授权表启动mysql服务程序
		3.修改root密码
			update mysql.user set authentication_string=password("7ujm*IK<") where user="root";
			flush privileges;
		4.以正常方式重启mysql服务程序
>>>
>>物理备份及恢复
>>>
		物理备份 cp、tar
		逻辑备份mysqldump(备份)，mysql(恢复)
		备份操作
		#!/bin/bash
		ssh root@192.168.4.51 systemctl stop mysqld
		ssh root@192.168.4.51 rm -rf /var/lib/mysql
		scp -r /var/lib/mysql root@192.168.4.51:/var/lib/mysql
		ssh root@192.168.4.51 chown -R mysql:mysql /var/lib/mysql/
		ssh root@192.168.4.51 systemctl restart mysqld
>>数据备份策略
>>>
		完全备份:备份所有数据
		增量备份：备份上次备份后，所产生的数据
		差异备份:备份完全备份后,所有新产生的数据
>>>
		完全备份及恢复
		mysqldump -uroot -p密码 库名>/目录
		完全恢复
		mysql -u -p 库名<目录
>>>
>>>
------------------------
###Day05
>>>
		什么是binlog日志？
		也称作二进制日志
		mysql服务日志的一种
		记录查询之外的所有sql命令
>>>
		vim /etc/my.cnf
		log_bin					#启用binlog日志	
		server_id=50           #指定值1~255
		#查看日志
		show master status;
		show master logs;
		#启用日志
		ll /var/lib/mysql/主机名-bin*
		/var/lib/mysql/mysql1-bin.index   
		#分析日志
		show varialbes like 'binlog_format';
		三种记录方式：
			1.statement 报表模式
			2.row 行模式
			3.mixed 混合模式
		
>>>
>>>
>>>
>>>		
		#索引文件
		1.修改日志文件路径
		vim /etc/my.cnf
		log_bin=/log/zhj
		server_id=50	
		max_binlog_size=数值m ---指定日志文件容量,默认1G	
		mkdir /log
		chown mysql /log
		2.手动生成新的日志文件
		mysqldump -uroot -p1qaz@WSX --flush-logs db5 >/root/db5.sql
		flush logs;  或  mysql -uroot -p1qaz@WSX -e "flush logs"
		systemcrl restart nysqld 重启进程也会重新创建日志
		3.删除已有的日志文件
		purge master logs to "zhj.000004";  删除指定编号之前的binlog日志文件
		reset master; 重置日志文件
>>###恢复数据	
>>>
		使用日志恢复数据
		#mysqlbinlog 日志文件 | mysql -uroot -p1qaz@WSX
>>>		
		mysqldump -uroot -p1qaz@WSX db3 > /root/db3.sql
		mysql -uroot -p2wsx#EDC  db3 < /root/db3.sql
		mysqlbinlog zhj.000007 |mysql -uroot -p2wsx#EDC
>>>分析日志
>>>      
		show variables like "binlog_format";
		/etc/my.cnf"
>>>		
		mysqlbinlog 选项 binlog日志文件名 | mysql -uroot -p密码
		|选项|用户|
		|--|--|
		|start-datetime="yyyy-mm-dd hh:mm:ss"|起始时间
		|stop-datetime="yyyy-mm-dd hh:mm:ss"|结束时间		
		|start-position=数字|起始偏移量
		|stop-position=数字|结束偏移量	
		PS:偏移量	
		mysqlbinlog --start-position=296  --stop-position=1121 /root/zhj.000008 |mysql -uroot -p2wsx#EDC
		mysql -uroot -p2wsx#EDC -e "select * from db3.ceshi;"
		PS:时间
		mysqlbinlog --start-datetime='2019-10-14  11:50:57' --stop-datetime='2019-10-14 11:53:55' zhj.000008 |mysql -uroot -p2wsx#EDC
>>>
------
>>>innobackupex	
>>>
		1.安装percona软件
		2.完全备份与恢复
		3.在完全备份恢复单张表数据
		4.增量备份与恢复 
>>>
		2-1完全备份
		常用选项 |含义
		--		|--
		--host|主机名
		--user|用户名
		--port|端口号
		--password|密码
		--databases|数据名
		--no-timestamp|不用日期命名备份文件存储的子目录名
		ps:
			databases="库名"
			databases="库名1 库名2"
			databases="库名.表"
>>>
>>>			
		###完全备份操作	
		innobackupex --user root --password 1qaz@WSX /allbak  --no-timestamp
		###完全恢复操作
		system stop mysqld 
		rm -rf /var/lib/mysql/*
		innobackupex --apply-log /root/allbak/ #准备恢复数据
		innobackupex --copy-back /root/allbak/ #恢复数据
		chown -R mysql:mysql /var/lib/mysql/
		systemctl restart mysqld
		mysql -uroot -p1qaz@WSX
		PS:可以查询准备恢复数据-->恢复数据状态
		cat /root/allbak/xtrabackup_checkpoints 
		backup_type = full-prepared
								full-backuped  完全备份
								incremental		增量备份
>>>
>>>
>>###恢复单张表信息
		1.删除表空间
			mysql>alter table db5.discard b tablespace;
		2.导出表信息
			innobackupex --apply-log --export /root/allbak/
		3.拷贝表信息文件到数据库目录下
			cp /root/allbak/db5/b.{cfg,ibd,exp} /var/lib/mysql/db5/
		4.修改表信息文件的所有者及组用户
			chown mysql:mysql /var/lib/mysql/db5/b.*
		5.导入表空间
			mysql>alter table db5.b import tablespace;
		6.删除数据库目录下的表信息文件
			rm -rf /var/lib/mysql/db5/b.{cfg,exp}
>>>	
>>###增量备份与恢复(不会锁表)
>>>
		完全备份
		innobackupex --user root --password 1qaz@WSX /fullbak --no-timestamp
		增量备份(当前数据与上次数据对比)
		innobackupex --user --password --incremental 备份目录 --incremental-basedir=/上次备份文件
		innobackupex --user root --password 1qaz@WSX --incremental /new1dir --incremental-basedir=/fullbak --no-timestamp
		innobackupex --user root --password 1qaz@WSX --incremental /new2dir --incremental-basedir=/new1dir --no-timestamp
>>>
		##增量恢复
		systemctl stop mysqld
		rm -rf /var/lib/mysql/*
		innobackupex --apply-log --redo-only /root/fullbak/ --incremental-dir=/root/new1dir
		innobackupex --apply-log --redo-only /root/fullbak/ --incremental-dir=/root/new2dir
		innobackupex --copy-back /root/fullbak/
		chown -R mysql:mysql /var/lib/mysql
		systemctl start mysqld
>>>
>>>
>>>
>>>
----------------------------------
>>MYSQL主从同步	
>>>
		1.主从介绍
			1实现数据自动同步的服务结构
			主服务器:接受客户端访问连接
			从服务器:自动同步主服务器数据
		2.主从同步原理	
			主必须启用binlog日志
			slave_IO:复制master主机binlog日志文件里的sql命令到本机的relay-log文件里
			slave_sql:执行本机relay-log文件里的sql语句,实现与master数据一致				
		2.配置
		主:
			vim /etc/my.cnf
				log_bin=master51
				server_id=51   ##不允许与主库server_id相同
			systemctl restart mysqld	
			grant replication slave on *.* to repluser@"%" identified by "1qaz@WSX";
			ps:
					replication slave 复制命令权限
		从:
			mysqldump -uroot -p1qaz@WSX --master-data db5 >/root/db5.sql
			scp /root/db5.sql root@192.168.4.52:/root/
			grep master51 /root/db5.sql 
>>>			
			change master to 	master_host="192.168.4.51",
			master_user="repluser",master_password="1qaz@WSX" ,
			master_log_file="master51.000001",master_log_pos=441;
>>>			
			master信息会自动保存到/var/lib/mysql/master.info文件
			若更改主库信息时, 应先执行stop slave 修改后在执行start slave
			start slave;
			show slave status;
				Slave_IO_Running: Yes       #IQ线程
				Slave_SQL_Running: Yes	     #SQL线程		
>>>
>>>
>>>
相关配置文件
>>>
文件名	 |		说明	|	
---		 |    :--:	
master.info| 	主库信息|
relay-log.info| 	中继日志信息|
主机名-relay-bin.xxx|中继日志|
主机名-relay-bin.index|索引文件|		   
>>>
>>####主从同步结构	
>>>
		配置一主多从结构
		1.修改vim /etc/my.cnf	
		2.mysqldump -uroot -p1qaz@WSX --master-data -B ceshi db1 db5 >/root/two.sql
		scp /root/two.sql root@192.168.4.53:/root   
>>>[master-data]记录当前备份数据对应的日志信息
>>>
		3.mysql -uroot -p1qaz@WSX < two.sql;    grep master two.sql
		4.mysql> change master to master_host='192.168.4.51',master_user="repluser",master_password="1qaz@WSX",master_log_file="master51.000002",master_log_pos=1793;
		5.mysql> start slave;
		6.show slave status;
>>>
		配置主从从结构
		删除53之前的数据
		rm -rf relay-log.info master.info 
		rm -rf  mysql4*	
		vim /etc/my.cnf
			log_bin=master53
			server_id=53
		grant replication slave on *.* to repluser@"%" identified by '1qaz@WSX';
		54为主从   53主--> 54从(主)-->>55-->从
		54操作
		vim /etc/my.cnf
			log_bin=master54
			server_id=54
			log_slave_updates //允许级联复制
		grant replication slave on *.* to repluser@"%" identified by '1qaz@WSX';			
		change master to master_host='192.168.4.53',master_user="repluser",master_password="1qaz@WSX",master_log_file='master53.000001',master_log_pos=441;	
		指定端口Master_Port=端口
		start slave;
		show slave status;
		55操作
		vim /etc/my.cnf
		server_id=55	
		mysql> change master to master_host="192.168.4.54",master_user='repluser',master_password='1qaz@WSX',master_log_file="master54.000001",master_log_pos=441;
>>>
>>>
>>>####复制模式	
>>>
		查看是否允许动态加载模块(YES)
		show variables like 'have%loading';
		加载模块
		#主模块
		install plugin rpl_semi_sync_master SONAME "semisync_master.so";
		#从模块
		install plugin rpl_semi_sync_slave SONAME "semisync_slave.so";
		#查看模块是否加载成功(ACTIVE)
		select PLUGIN_NAME,PLUGIN_STATUS from information_schema.plugins where plugin_name like '%semi%';
		#启用半同步复制,临时生效
		#设置全局主服务器
		set global rpl_semi_sync_master_enabled=1;
		#设置全局从服务器
		set global rpl_semi_sync_slave_enabled=1;
		#查询是否开启(ON)
		show variables like '%rpl_semi_sync%enabled%';
		#设置永久配置
		vim /etc/my.cnf
		plugin-load=rpl_semi_sync_master=semisync_master.so
		rpl_semi_sync_master_enabled=1
>>>
		plugin-load=rpl_semi_sync_slave=semisync_slave.so
		rpl_semi_sync_slave_enabled=1

>>>
>>>####安装maxscale服务
>>>
		maxscale代理软件	
>>>
		maxscale.cnf  配置文件
		maxscale.cnf.template模板  
		maxscale.modules.d/ 模块	
		ls /var/log/maxscale/  日志	
>>>>			
			10 threads=1 改为auto 线程运行数量,自动获取
			18 [server1] [server12 指定IP,端口  
			[MySql Monitor] 定义要监听的数据库节点
			[Read-Write Service] 定义读写分离的数据库节点  
			[Read-Write-Listener] 定义读写分离服务端口
			port=4006
			[MaxAdmin Listener] 定义管理服务端口号
			添加port=4016
>>>
		//创建监控用户
		grant replication slave ,replication client on *.* to maxscalemon@'%' identified by '1qaz@WSX';
		//创建路由用户
		grant select on mysql.* to maxscalrou@'%' identified by '1qaz@WSX';
		//启动进程  查看端口   停止服务
		maxscale -f /etc/maxscale.cnf
		netstat -untup|grep maxscale
		kill -9 pid号
>>>
>>>##测试连接
		57
		maxadmin -uadmin -pmariadb -P4016
		MaxScale> list servers	
		客户端
		mysql -h192.168.4.57 -P4006 -uyaya888 -p1qaz@WSX
		在从插入数据,用主查询(没数据),用客户端查询(有数据).此时说明数据库读的是从服务器
>>>
>>>
>>>####多实例服务		
>>>
		为什么要使用多实例?
		节约成本,提高硬件利用率
>>>	
>>>
		配置多实例.
		安装软件包libaio,解压源码包mysql-5.7.20-linux-glibc2.12-x86_64.tar.gz
		mv mysql-5.7.20-linux-glibc2.12-x86_64 /usr/local/mysql
		useradd mysql
		echo $PATH
		PATH=/usr/local/mysql/bin/:$PATH
		vim /etc/profile
			export PATH=/usr/local/mysql/bin:$PATH
>>>
>>>
		套接字文件sock
		vim /etc/my.cnf
		[mysqld_multi] 				#启用多实例
		mysqld = /usr/local/mysql/bin/mysqld_safe  #指定进场文件路径
		mysqladmin = /usr/local/mysql/bin/mysqladmin #指定管理命令路径
		user = root			#指定进场用户
>>>
		[mysqld1]				#实例进程名称
		port = 3307			#端口号
		datadir = /dir1	#数据库目录,需要手动创建
		socket = /dir1/mysql1.sock 		#指定sock文件的路径和名称
		pid-file = /dir1/mysqld.pid		#进场pid号文件位置
		log-error = /dir1/mysqld.err	#错误日志位置
>>>
		[mysqld2]
		port = 3308
		datadir = /dir2
		socket = /dir2/mysql2.sock
		pid-file = /dir2/mysqld.pid
		log-error = /dir2/mysqld.err
>>>
>>>
		mkdir /dir{1,2}
		mysqld_multi start 1		#启动服务
		#修改密码
		mysql -uroot -p'vxBssOy:C1f?' -S /dir1/mysql1.sock
		mysql -uroot -p'y0jD-NW>M=i/' -S /dir2/mysql2.sock
		alter user root@"localhost" identified by '123456';
		mysqld_multi --user=root --password=密码 stop 实例编号  #停止服务
>>>
>>>	
		grant all on *.* to ceshi@"%" identified by '1qaz@WSX';
		客户端访问
		mysql -h192.168.4.60 -P3307 -uroot -p123456 
		mysql -h192.168.4.60 -P3308 -uceshi2 -p1qaz@WSX
>>>
>>>
-----------------------------------
###Day
>>>
>>>####数据分片
>>>
		环境:
>>>>
		1台客户端 1台分布式  3台服务端
>>> 工作流程      
        当mycat收到一个SQL命令时
        1.解析SQL命令涉及到的表
        2.然后看对表的配置,如有分片规则,则获取SQL命令里分片字段的值,并匹配分片函数,获取分片列表
        3.然后将SQL命令发往对应的分片服务器去执行
        4.最后收集和处理所有分片结果数据,并返回到客户端		
>>>安装软件
		java-1.8.0-openjdk
		mycat
>>>     		
		usr/local/mycat/
		bin		//mycat命令 
		catlet	//扩展功能
		conf		//配置文件
		lib		//mycat使用的jar包
		logs		//mycat启动日志和运行日志
		(wrapper.log //mycat服务启动日志 
		mycat.log //记录SQL脚本执行后的报错内容)
		mycat服务配置文件
		rule.xml   分片规则
		server.xml 设置连接账号及逻辑库
		schema.xml 配置数据分片
>>>部署mycat
		vim /usl/local/mycat/conf/server.xml  #里面包含远程登录用户名密码
		配置/usl/local/mycat/conf/schema.xml服务
>>>		
		配置数据分片的表
		<schema>  //定义分片信息
		<table>   //定义表
		name      //逻辑库名或逻辑表名
		dataNode  //指定数据节点名
		rule   	//指定使用的分片规则
		type=global  //数据不分存储
>>>
		<dataNode 选项=值> //定义数据节点
		name //数据节点名
		datahost 数据库服务器主机名
		database 数据库名
>>>定义数据库服务器IP地址及端口
		<datahost 选择=值>   //服务器主机名
		name		//主机名(与datahost对应的主机名)
		host		//主机名(与IP地址对应的主机名)
		url	  //数据库服务器IP地址及端口号
		user  //数据库服务器授权用户
		password //授权用户密码
>>>配置数据库服务器    
		添加授权用户
		创建存储数据 数据库db1 db2 db3
>>>	启动服务
		/usr/local/mycat/bin/mycat --help
		Usage: /usr/local/mycat/bin/mycat { console | start | stop | restart | status | dump }
		netstat -antup|grep 8066
>>>客户端连接
>>>
		mysql -h192.168.4.56 -P8066 -uroot -p123456
>>>
>>>####分片规则
>>>枚举法(sharding-by-intfile)  字段值必须在列举范围内选择
>>>
	1.	/usr/local/mycat/conf/rule.xml
		  <table name="employee" primaryKey="ID" dataNode="dn1,dn2,dn3"
             rule="sharding-by-intfile" />

	2.	usr/local/mycat/conf/rule.xml
      <tableRule name="sharding-by-intfile">
              <rule>
                      <columns>sharding_id</columns>
                      <algorithm>hash-int</algorithm>
               </rule>
       </tableRule>	


		  <function name="hash-int"
                class="io.mycat.route.function.PartitionByFileMap">
                <property name="mapFile">partition-hash-int.txt</property>
       </function>
	3. vim conf/partition-hash-int.txt
			10000=0
			10010=1
			10020=2  添加,由于配置dns1,dns2,dns3需要添加
>>>创建表
>>>
		create table employee (id int primary key auto_increment , sharding_id int , name varchar(10),sex enum ("m","w"));
		##插入数据验证
		
>>>	
>>>求模法(mod-long) 根据字段值与设定的数字求模结果存储数据
>>>
			1.	/usr/local/mycat/conf/rule.xml
		  <table name="hotnews"  dataNode="dn1,dn2,dn3" rule="mod-long" />
			2.	usr/local/mycat/conf/rule.xml
       <tableRule name="mod-long">
                <rule>
                        <columns>id</columns>
                        <algorithm>mod-long</algorithm>
                </rule>
       </tableRule>
       <function name="mod-long" class="io.mycat.route.function.PartitionByMod">
                <!-- how many data nodes -->
                <property name="count">3</property>
       </function>
       
	create table hotnews(id int ,title char(20),worker char (15), comment varchar(50),fb_time timestamp);
	
		mysql> insert into hotnews (id,title,worker,comment,fb_time)   values (3,'aa',"bb",'sdfasdf',now());
>>>
>>>全局
		 <table name="company" primaryKey="ID" type="global" dataNode="dn1,dn2,dn3" />

		create table company (id int primary key auto_increment,gname char(10),money int ,peploe char(10),gaddr char(50));
		inse company (gname,money,peploe,gaddr) values ('tedu',10000,'aa','beijing');
		3台服务器均匀数据
>>>
>>>添加新库新表
>>>
>>>
		server.xml
			 <user name="root">
                <property name="password">123456</property>
                <property name="schemas">TESTDB,BBSDB</property>
			 </user>
		schema.xml
       <schema name="BBSDB" checkSQLschema="false" sqlMaxLimit="100">
               <table name="enmployee2" primaryKey="ID" dataNode="dn1,dn2,dn3" rule="sharding-by-intfile"  />
               <table name="company2" primaryKey="ID" type="global"
                       dataNode="dn1,dn2,dn3" />
       </schema>
			
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>	
>>>
>>>
>>>	
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>	
>>>
>>>
>>>	
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>	
>>>
>>>
