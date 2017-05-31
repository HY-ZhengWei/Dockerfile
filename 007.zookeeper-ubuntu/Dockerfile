# 动态Zookeeper版本环境

# 设置继承镜像
FROM hyzhengwei/sshd-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-31


# 方式1：从Zookeeper官网直接下载Zookeeper包
# ADD http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz /

# 方式2：宿主机的Zookeeper包拷贝到镜像中
# ADD zookeeper-3.4.10.tar.gz /

# 方式3：Zookeeper版本可由最终用户来决定。通过-v动态挂载
#       部分命令为：-v 宿主机Zookeeper目录:/zookeeper -v 宿主机Zookeeper进程myid目录:/zookeeper_datas -v 宿主机JDK目录:/jdk:ro
ENV ZOOKEEPER_HOME  /zookeeper
ENV PATH $ZOOKEEPER_HOME/bin:$PATH
ENV ZOOKEEPER_DATAS       /zookeeper_datas
ENV ZOOKEEPER_CONF_DIR    $ZOOKEEPER_HOME/conf
ENV ZOOKEEPER_CONIFG_HY   /zookeeper-config


ADD zookeeper-config $ZOOKEEPER_CONIFG_HY


# 辅助命令：设置HostName
ADD zookeeper.init.all.sh     /usr/bin
ADD zookeeper.init.hosts.sh   /usr/bin

RUN chmod 755 /usr/bin/zookeeper.*.sh


# 添加 supervisord 的配置文件
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf



# 设置开放的端口
EXPOSE 2181 2182 2183



# 设置自启动命令
# 执行supervisord来同时执行多个命令，使用 supervisord 的可执行路径启动服务。
CMD ["/usr/bin/supervisord"]



# 编译创建镜像
# docker build -t hyzhengwei/zookeeper-ubuntu .

# 镜像创建成功后，启动Zookeeper容器
# docker run --name c_zookeeper01 -h zookeeper01 -P -d -v /Users/hy/WSS/WorkSpace_Docker/zookeeper-3.4.10:/zookeeper -v /Users/hy/WSS/WorkSpace_Docker/zookeeper_datas01:/zookeeper_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/zookeeper-ubuntu
# docker run --name c_zookeeper02 -h zookeeper02 -P -d -v /Users/hy/WSS/WorkSpace_Docker/zookeeper-3.4.10:/zookeeper -v /Users/hy/WSS/WorkSpace_Docker/zookeeper_datas02:/zookeeper_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/zookeeper-ubuntu
# docker run --name c_zookeeper03 -h zookeeper03 -P -d -v /Users/hy/WSS/WorkSpace_Docker/zookeeper-3.4.10:/zookeeper -v /Users/hy/WSS/WorkSpace_Docker/zookeeper_datas03:/zookeeper_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/zookeeper-ubuntu
# docker exec -it c_zookeeper01 /bin/bash



# 在所有容器均启动成功后，再在所有节点容器中均执行如下初始环境配置命令
# 执行前须确认IP地址的正确
# zookeeper.init.all.sh

# 在节点容器上执行启动Zookeeper命令
# zkServer.sh start
# zkServer.sh start-foreground

# 重启容器时hosts文件中的内容会丢失，所以要再次添加一次
# zookeeper.init.hosts.sh