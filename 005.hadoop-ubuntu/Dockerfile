# 安装Hadoop

# 设置继承镜像
FROM hyzhengwei/sshd-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-25



ENV HADOOP_HOME /hadoop-2.6.5
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH


# 设置免密码登录，生成私钥和公钥
RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub>> /root/.ssh/authorized_keys
# 在hadoop首次启动时，不用再输入yes(参见ssh的参数StrictHostKeyChecking说明)
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config


# ADD http://mirrors.hust.edu.cn/apache/hadoop/common/hadoop-2.6.5/hadoop-2.6.5.tar.gz /
ADD hadoop-2.6.5.tar.gz /


RUN mkdir -p /hadoop_datas/hdfs/name && \
    mkdir -p /hadoop_datas/hdfs/data
    
ADD hadoop-config/core-site.xml   $HADOOP_HOME/etc/hadoop
ADD hadoop-config/hdfs-site.xml   $HADOOP_HOME/etc/hadoop
ADD hadoop-config/mapred-site.xml $HADOOP_HOME/etc/hadoop
ADD hadoop-config/yarn-site.xml   $HADOOP_HOME/etc/hadoop
ADD hadoop-config/hadoop-env.sh   $HADOOP_HOME/etc/hadoop
ADD hadoop-config/yarn-env.sh     $HADOOP_HOME/etc/hadoop


# 添加 supervisord 的配置文件
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf



# 设置开放的端口
EXPOSE 22

# hadoop FS
EXPOSE 9000

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
# 镜像创建成功后，启动容器
# docker run --name c_hadoop -h hadoop -p 22001:22 -p 9000:9000 -p 8088:8088 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50090:50090 -d -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
# docker exec -it c_hadoop /bin/bash