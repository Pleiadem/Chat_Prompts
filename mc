	1. 买服务器，将端口的25565放行（ip 0.0.0.0）
		# 添加 firewall-cmd --zone=public --add-port=25565/tcp --permanent （--permanent永久生效，没有此参数重启后失效） # 重新载入 firewall-cmd --reload
		
		来自 <https://cloud.tencent.com/developer/article/1752707> 
	2. 重置实例密码，通过Bitvise SSH Client连接服务器
	3. 进入服务器后台，配置服务器
		a. 安装java17    yum list Java*     然后找版本    （ |神谕 (oracle.com)）
		b. 找到后  yum install -y java-1.8.0-openjdk.x86_64  安装java
		
		wget https://download.oracle.com/java/19/archive/jdk-19_linux-x64_bin.tar.gz
		手动安装
		java环境变量配置
		
		vim /etc/profile
		# CentOs的java环境变量配置
		在文件尾部加入以下
		export JAVA_HOME=/usr/jdk1.8.0_144（jdk解压文件路径）
		export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
		export PATH=$PATH:$JAVA_HOME/bin
		# 环境变量生效
		source /etc/profile
		
		c. 安装多任务后台运行  yum install screen -y
			===== 后台运行 ===== 
			screen -RU sth 新建一个 screen 名为 sth 
			screen -xU sth 访问名为 sth 的 screen 
			screen -ls 查看当前所有的 screen
			 [Ctrl] + [A] : d 后台运行当前 screen（按住 ctrl+A 后输入 d）
 [Ctrl] + [A] : k : y 关闭当前 screen（按住 Ctrl+A 后输入 k 再输入 y 回车
