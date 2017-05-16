# 动态Tomcat版本环境。Tomcat版本可由最终用户来决定。通过-v动态挂载的方式添加到运行的容器中。

# 设置继承镜像
FROM hyzhengwei/jdk-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-16


# 方式1：远程官网下载并安装Tomcat
# ADD http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz /
# RUN tar zxvf /apache-tomcat-7.0.77.tar.gz
# RUN rm -f /apache-tomcat-7.0.77.tar.gz

# 方式2：Tomcat版本可由最终用户来决定。通过-v动态挂载
#       部分命令为：-v 宿主机Tomcat目录:/tomcat -v 宿主机JDK目录:/jdk:ro
ENV TOMCAT_HOME   /tomcat
ENV CATALINA_HOME /tomcat
ENV CATALINA_BASE /tomcat
ENV PATH $PATH:$TOMCAT_HOME/lib:$TOMCAT_HOME/bin



# 设置开放的端口
EXPOSE 8080


# WORKDIR $TOMCAT_HOME


# 设置自启动命令
ENTRYPOINT chmod -R 755 $TOMCAT_HOME/bin && \
           $TOMCAT_HOME/bin/startup.sh && \
           tail -f 1000 $TOMCAT_HOME/logs/catalina.out



# 编译创建镜像
# docker build -t hyzhengwei/tomcat-ubuntu .
# 镜像创建成功后，启动容器
# docker run --name c_tomcat -p 8080:8080 -d -v /Users/hy/WSS/WorkSpace_Docker/apache-tomcat-8.5.15:/tomcat -v /Users/hy/WSS/WorkSpace_Docker/jdk1.7.0_80:/jdk:ro hyzhengwei/tomcat-ubuntu
# docker exec -it c_tomcat /bin/bash