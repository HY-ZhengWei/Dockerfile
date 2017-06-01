# 动态HBase版本环境

# 设置继承镜像
FROM hyzhengwei/sshd-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-27


# 方式1：从HBase官网直接下载HBase包
# ADD http://apache.fayea.com/hbase/1.3.1/hbase-1.3.1-bin.tar.gz /

# 方式2：宿主机的HBase包拷贝到镜像中
# ADD hbase-1.3.1-bin.tar.gz /

# 方式3：HBase版本可由最终用户来决定。通过-v动态挂载
#       部分命令为：-v 宿主机HBase目录:/hbase -v 宿主机JDK目录:/jdk:ro
ENV HBASE_HOME  /hbase
ENV PATH $HBASE_HOME/bin:$PATH
ENV HBASE_CONF_DIR    $HBASE_HOME/conf
ENV HBASE_CONIFG_HY   /hbase-config


ADD hbase-config $HBASE_CONIFG_HY


# 辅助命令：设置HostName
ADD hbase.init.all.sh     /usr/bin
ADD hbase.init.hosts.sh   /usr/bin

RUN chmod 755 /usr/bin/hbase.*.sh


# 添加 supervisord 的配置文件
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf



# 设置开放的端口
EXPOSE 60000 60010 60020 60030
EXPOSE 16000 16020 16030



# 设置自启动命令
# 执行supervisord来同时执行多个命令，使用 supervisord 的可执行路径启动服务。
CMD ["/usr/bin/supervisord"]



# 编译创建镜像
# docker build -t hyzhengwei/hbase-ubuntu .

# 镜像创建成功后，启动HBase主容器
# docker run --name c_hbase01 -h hbase01 -p 60010:60010 -p 60000:60000 -p 60010:60010 -p 60030:60030 -d -v /Users/hy/WSS/WorkSpace_Docker/hbase-1.2.5:/hbase -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hbase-ubuntu
# docker run --name c_hbase02 -h hbase02 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hbase-1.2.5:/hbase -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hbase-ubuntu
# docker exec -it c_hbase01 /bin/bash



# 在所有容器均启动成功后，再在所有节点容器中均执行如下初始环境配置命令
# 执行前须确认IP地址的正确
# hbase.init.all.sh

# 在主节点容器上执行启动HBase集群命令
# start-hbase.sh

# 重启容器时hosts文件中的内容会丢失，所以要再次添加一次
# hbase.init.hosts.sh