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

* [hadoop-ubuntu动态Hadoop版本环境](https://hub.docker.com/r/hyzhengwei/hadoop-ubuntu)
    * 以安装Apache Hadoop 2.6.5为例子
    * 开启OpenSSH服务
    * 服务器功能规划（以4台服务器举例）
        
        | NameNode | DataNode | SecordaryNameNode |
        |:--------:|:--------:|:-----------------:|
        |hadoop01  |          |                   |
        |          |hadoop02  |                   |
        |          |hadoop03  |                   |
        |          |          |hadoop04           |
    * 容器动态挂载的三个目录说明

        | 动态挂载目录 | 说明 |
        |:--------    |:-------- |
        |/hadoop      |Apache Hadoop软件所在的主目录|
        |/hadoop_datas|Hadoop数据目录。每个容器的目录路径应均不同|
        |/jdk         |Java JDK所在的主目录  |
    * 容器启动命令样例
        * hadoop01：docker run --name c_hadoop01 -h hadoop01 -p 22001:22 -p 9000:9000 -p 9001:9001 -p 8088:8088 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50090:50090 -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas01:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
        * hadoop02：docker run --name c_hadoop02 -h hadoop02 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas02:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
        * hadoop03：docker run --name c_hadoop03 -h hadoop03 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas03:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
        * hadoop04：docker run --name c_hadoop04 -h hadoop04 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas04:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
    * 容器进入命令样例
        * docker exec -it c_hadoop01 /bin/bash
        * docker exec -it c_hadoop02 /bin/bash
        * docker exec -it c_hadoop03 /bin/bash
        * docker exec -it c_hadoop04 /bin/bash
    * 配置IP、HostName、免密登录（所有容器均启动成功后）
        * 确认每台容器的IP，并配置在 /usr/bin/hadoop.init.config.sh 脚本中。
        * 执行同步配置命令：hadoop.sync.config.sh
        * 执行初始化配置命令：hadoop.init.config.sh 。在所有容器中均要执行，中间要输入多台容器的登录密码(默认为root)
    * 启动Hadoop集群
        * 主节点容器中执行初始化命令：hdfs namenode -format
        * 主节点容器中执行启动命令：start-all.sh
    * Hadoop服务验证：
        * http://127.0.0.1:50070 查看NameNode状态
        * http://127.0.0.1:8088  查看Yarn状态
