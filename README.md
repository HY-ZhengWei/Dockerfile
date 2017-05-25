# Dockerfile


* [base-ubuntu基础镜像](https://hub.docker.com/r/hyzhengwei/base-ubuntu)
    * 设置时区为：中国
    * 安装vi、ifconfig、netstat、telnet、ping命令
    * 安装supervisord服务管理工具 

* [jdk-ubuntu动态JDK版本环境](https://hub.docker.com/r/hyzhengwei/jdk-ubuntu)
    * 动态JDK版本环境。JDK版本可由最终用户来决定。通过-v动态挂载的方式添加到运行的容器中。
    * 容器运行命令样例：docker run --name c_jdk --rm -it -v JDK在宿主机的路径:/jdk:ro hyzhengwei/jdk-ubuntu
    
* [tomcat-ubuntu动态Tomcat版本环境](https://hub.docker.com/r/hyzhengwei/tomcat-ubuntu)
    * 动态Tomcat版本环境。Tomcat版本可由最终用户来决定。通过-v动态挂载的方式添加到运行的容器中。
    * 容器运行命令样例：run --name c_tomcat -p 8080:8080 -d -v 宿主机Tomcat目录:/tomcat -v JDK在宿主机的路径:/jdk:ro hyzhengwei/tomcat-ubuntu
    
* [sshd-ubuntu安装OpenSSH服务](https://hub.docker.com/r/hyzhengwei/sshd-ubuntu)
    * 安装OpenSSH服务，随时准备打开22管理远程管理端口
    * 容器运行命令样例：docker run --name c_sshd -p 22001:22 -d -v JDK在宿主机的路径:/jdk:ro hyzhengwei/sshd-ubuntu /usr/sbin/sshd -D

* [hadoop-ubuntu安装Apache Hadoop](https://hub.docker.com/r/hyzhengwei/hadoop-ubuntu)
    * 安装Apache Hadoop 2.6.5
    * 启动OpenSSH服务
    * 容器运行命令样例：docker run --name c_hadoop -h hadoop -p 22001:22 -p 9000:9000 -p 8088:8088 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50090:50090 -d -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
    * Hadoop服务验证：
        http://127.0.0.1:50070 查看NameNode状态
        http://127.0.0.1:8088  查看Yarn状态
    