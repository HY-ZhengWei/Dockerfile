# 动态JDK版本环境。JDK版本可由最终用户来决定。通过-v动态挂载的方式添加到运行的容器中。

# 设置继承镜像
FROM hyzhengwei/base-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-16


# 方式1：安装OpenJDK
# RUN apt-get update
# RUN apt-get install -y openjdk-8-jdk
# ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# 方式2：将宿主机的JDK拷贝到镜像中
# ADD jdk1.8.0 /jdk1.8.0

# 方式3：JDK版本可由最终用户来决定。通过-v动态挂载
#       部分命令为：-v 宿主机JDK目录:/jdk:ro
ENV JAVA_HOME /jdk
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin


# 设置自启动命令
# CMD ["/run.sh"]


# 编译创建镜像
# docker build -t hyzhengwei/jdk-ubuntu .
# 镜像创建成功后，启动容器
# docker run --name c_jdk --rm -it -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/jdk-ubuntu