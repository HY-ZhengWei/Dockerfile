# 安装Tomcat-7.0.77

# 设置继承镜像
FROM hyzhengwei/jdk-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-14


ENV TOMCAT_HOME   /apache-tomcat-7.0.77
ENV CATALINA_HOME /apache-tomcat-7.0.77
ENV CATALINA_BASE /apache-tomcat-7.0.77
ENV PATH $PATH:$TOMCAT_HOME/lib:$TOMCAT_HOME/bin
ADD http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz /
RUN tar zxvf /apache-tomcat-7.0.77.tar.gz
RUN rm -f /apache-tomcat-7.0.77.tar.gz
RUN chmod -R 755 $TOMCAT_HOME/bin


# 设置开放的端口
EXPOSE 8080


WORKDIR $TOMCAT_HOME


# 设置自启动命令
ENTRYPOINT $TOMCAT_HOME/bin/startup.sh && tail -f 1000 $TOMCAT_HOME/logs/catalina.out



# 编译创建镜像
# docker build -t hyzhengwei/tomcat-ubuntu .
# 镜像创建成功后，启动容器
# docker run --name c_tomcat -p 8080:8080 -d hyzhengwei/tomcat-ubuntu
# docker exec -it c_tomcat /bin/bash