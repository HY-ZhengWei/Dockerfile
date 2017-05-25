# 概述：中国时区、安装基础命令
# 设置系统时间区为中国
# 安装vi、ifconfig、netstat、telnet、ping命令

# 设置继承镜像
FROM ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-14

RUN apt-get update
RUN apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata
RUN apt-get install -y vim
RUN apt-get install -y telnet/xenial
RUN apt-get install -y net-tools
RUN apt-get install -y iputils-ping



# 编译创建镜像
# docker build -t hyzhengwei/base-ubuntu .
# 镜像创建成功后，启动容器
# docker run --name c_base --rm -it hyzhengwei/base-ubuntu