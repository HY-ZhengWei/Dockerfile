# 动态Hadoop版本环境

# 设置继承镜像
FROM hyzhengwei/sshd-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-25


# 方式1：从Hadoop官网直接下载Hadoop包
# ADD http://mirrors.hust.edu.cn/apache/hadoop/common/hadoop-2.6.5/hadoop-2.6.5.tar.gz /

# 方式2：宿主机的Hadoop包拷贝到镜像中
# ADD hadoop-2.6.5.tar.gz /

# 方式3：Hadoop版本可由最终用户来决定。通过-v动态挂载
#       部分命令为：-v 宿主机Hadoop目录:/hadoop -v 宿主机数据01目录:/hadoop_datas -v 宿主机JDK目录:/jdk:ro
# HADOOP_HOME  表示Hadoop软件的动态挂载目录 
# HADOOP_DATAS 表示数据保存的动态挂载目录。注:Hadoop集群时此目录对于每个容器应均不同
ENV HADOOP_HOME  /hadoop
ENV HADOOP_DATAS /hadoop_datas
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH


ENV HADOOP_PREFIX      $HADOOP_HOME
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_HDFS_HOME   $HADOOP_HOME
ENV HADOOP_MAPRED_HOME $HADOOP_HOME
ENV HADOOP_YARN_HOME   $HADOOP_HOME
ENV HADOOP_CONF_DIR    $HADOOP_HOME/etc/hadoop
ENV HADOOP_CONIFG_HY   /hadoop-config



ADD hadoop-config $HADOOP_CONIFG_HY
# 配合方式1和方式2的命令
# ADD hadoop-config  $HADOOP_HOME/etc/hadoop


# 辅助命令：设置HostName、设置免密码登录
ADD hadoop.init.all.sh     /usr/bin
ADD hadoop.init.hosts.sh   /usr/bin

# 辅助命令：用于同步hadoop集群情况下的配置
ADD hadoop.sync.config.sh  /usr/bin

RUN chmod 755 /usr/bin/hadoop.*.sh



# 添加 supervisord 的配置文件
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf



# 设置开放的端口
EXPOSE 22

# hadoop FS
EXPOSE 9000

# hadoop Mapred
EXPOSE 9001

# hadoop datanode
EXPOSE 50010 50020 50070

# hadoop secondary namenode
EXPOSE 50090

# hadoop yarn
EXPOSE 8088



# 设置自启动命令
# 执行supervisord来同时执行多个命令，使用 supervisord 的可执行路径启动服务。
CMD ["/usr/bin/supervisord"]



# 编译创建镜像
# docker build -t hyzhengwei/hadoop-ubuntu .

# 镜像创建成功后，启动Hadoop主容器
# docker run --name c_hadoop01 -h hadoop01 -p 22001:22 -p 9000:9000 -p 9001:9001 -p 8088:8088 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50090:50090 -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas01:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
# docker exec -it c_hadoop01 /bin/bash

# 启动Hadoop DataNode 01 容器
# docker run --name c_hadoop02 -h hadoop02 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas02:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
# docker exec -it c_hadoop02 /bin/bash

# 启动Hadoop DataNode 02 容器
# docker run --name c_hadoop03 -h hadoop03 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas03:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
# docker exec -it c_hadoop03 /bin/bash

# 启动Hadoop Secordary NameNode 容器
# docker run --name c_hadoop04 -h hadoop04 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas04:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
# docker exec -it c_hadoop04 /bin/bash



# 在所有容器均启动成功后，再在所有节点容器中均执行如下初始环境配置命令
# 执行前须确认IP地址的正确
# hadoop.init.all.sh

# 在主节点容器上执行Hadoop格式化命令
# hdfs namenode -format

# 在主节点容器上执行启动Hadoop命令
# start-all.sh

# 重启容器时hosts文件中的内容会丢失，所以要再次添加一次
# hadoop.init.hosts.sh