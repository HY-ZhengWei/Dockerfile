# 安装JDK

# 设置继承镜像
FROM hyzhengwei/base-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-13


RUN apt-get update
RUN apt-get install -y openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin
# ADD jdk1.8.0 /jdk1.8.0



# 编译创建镜像
# docker build -t hyzhengwei/jdk-ubuntu .
# 镜像创建成功后，启动容器
# docker run -it c_jdk --rm -it hyzhengwei/jdk-ubuntu