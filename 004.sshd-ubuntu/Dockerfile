# 安装OpenSSH服务，随时准备打开22管理远程管理端口

# 设置继承镜像
FROM hyzhengwei/jdk-ubuntu

# 维护者信息
MAINTAINER ZhengWei<HY.ZhengWei@qq.com> 2017-05-16


RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# 设置sshd服务允许root用户登陆
RUN sed -i 's/^PermitRootLogin/#PermitRootLogin/' /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "root:root" | chpasswd

# 在首次执行ssh 127.0.0.1时，不用再输入yes(参见ssh的参数StrictHostKeyChecking说明)
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config


# ADD run.sh /run.sh
# RUN chmod 755 /run.sh
# run.sh
#   #!/bin/bash
#   /usr/sbin/sshd -D

# 设置开放的端口
EXPOSE 22

# 设置自启动命令
# CMD ["/run.sh"]



# 编译创建镜像
# docker build -t hyzhengwei/sshd-ubuntu .
# 镜像创建成功后，启动容器
# docker run --name c_sshd -p 22001:22 -d -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/sshd-ubuntu /usr/sbin/sshd -D
# docker exec -it c_sshd /bin/bash