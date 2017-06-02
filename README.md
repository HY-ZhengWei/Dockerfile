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
    * 容器动态挂载的两个目录说明

        | 动态挂载目录 | 说明 |
        |:--------   |:-------- |
        |/tomcat     |Apache Tomcat软件所在的主目录|
        |/jdk        |Java JDK所在的主目录|
    * 容器运行命令样例：docker run --name c_tomcat -p 8080:8080 -d -v 宿主机Tomcat目录:/tomcat -v JDK在宿主机的路径:/jdk:ro hyzhengwei/tomcat-ubuntu
    
* [sshd-ubuntu安装OpenSSH服务](https://hub.docker.com/r/hyzhengwei/sshd-ubuntu)
    * 安装OpenSSH服务，随时准备打开22管理远程管理端口
    * 容器运行命令样例：docker run --name c_sshd -p 22001:22 -d -v JDK在宿主机的路径:/jdk:ro hyzhengwei/sshd-ubuntu /usr/sbin/sshd -D

* [hadoop-ubuntu动态Hadoop版本环境](https://hub.docker.com/r/hyzhengwei/hadoop-ubuntu)
    * 以安装Apache Hadoop 2.6.5为例子
    * 开启OpenSSH服务
    * 服务器功能规划（以4台服务器完全分布式举例）
        
        | NameNode | DataNode | SecordaryNameNode |
        |:--------:|:--------:|:-----------------:|
        |hadoop01  |          |                   |
        |          |hadoop02  |                   |
        |          |hadoop03  |                   |
        |          |          |hadoop04           |
    * 服务器的IP规划（可在hadoop.init.hosts.sh脚本中修改）
        
        | 服务器名称 | IP地址 |
        |:--------:|:-------- |
        |hadoop01|172.17.0.2|
        |hadoop02|172.17.0.3|
        |hadoop03|172.17.0.4|
        |hadoop04|172.17.0.5|
    * 容器动态挂载的三个目录说明

        | 动态挂载目录 | 说明 |
        |:--------    |:-------- |
        |/hadoop      |Apache Hadoop软件所在的主目录|
        |/hadoop_datas|Hadoop数据目录。每个容器的目录路径应均不同|
        |/jdk         |Java JDK所在的主目录|
    * 容器启动命令样例
        ```sh
        docker run --name c_hadoop01 -h hadoop01 -p 22001:22 -p 9000:9000 -p 9001:9001 -p 8088:8088 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50090:50090 -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas01:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
        docker run --name c_hadoop02 -h hadoop02 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas02:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
        docker run --name c_hadoop03 -h hadoop03 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas03:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
        docker run --name c_hadoop04 -h hadoop04 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hadoop-2.6.5:/hadoop -v /Users/hy/WSS/WorkSpace_Docker/hadoop_datas04:/hadoop_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hadoop-ubuntu
        ```
    * 容器进入命令样例
        ```sh
        docker exec -it c_hadoop01 /bin/bash
        docker exec -it c_hadoop02 /bin/bash
        docker exec -it c_hadoop03 /bin/bash
        docker exec -it c_hadoop04 /bin/bash
        ```
    * 配置IP、HostName、免密登录（所有容器均启动成功后）
        * 确认每台容器的IP，并配置在 /usr/bin/hadoop.init.all.sh 脚本中。
        * 确认每台容器的IP，并配置在 /usr/bin/hadoop.init.hosts.sh 脚本中。
        * 执行同步配置命令：hadoop.sync.config.sh  （可选）
        * 执行初始化配置命令：hadoop.init.all.sh 。在所有容器中均要执行(默认为root)
            ```sh
            docker exec c_hadoop01 hadoop.init.all.sh
            docker exec c_hadoop02 hadoop.init.all.sh
            docker exec c_hadoop03 hadoop.init.all.sh
            docker exec c_hadoop04 hadoop.init.all.sh
            ```
    * 启动Hadoop集群
        * 主节点容器中执行初始化命令：hdfs namenode -format
        * 主节点容器中执行启动命令：start-all.sh
    * Hadoop服务验证：
        * http://127.0.0.1:50070 查看NameNode状态
        * http://127.0.0.1:8088  查看Yarn状态
    * 重启容器时hosts文件中的内容会丢失，所以要再次添加一次
        ```sh
        docker start c_hadoop01
        docker start c_hadoop02
        docker start c_hadoop03
        docker start c_hadoop04
        
        docker exec c_hadoop01 hadoop.init.hosts.sh
        docker exec c_hadoop02 hadoop.init.hosts.sh
        docker exec c_hadoop03 hadoop.init.hosts.sh
        docker exec c_hadoop04 hadoop.init.hosts.sh
        
        docker exec c_hadoop01 start-all.sh
        ```
    * 停止容器、删除容器
        ```sh
        docker stop `docker ps -q -f name=c_hadoop*`
        docker rm   `docker ps -a -q -f name=c_hadoop*`
        ```
        
        
        
* [hbase-ubuntu动态HBase版本环境](https://hub.docker.com/r/hyzhengwei/hbase-ubuntu)
    * 以安装Apache HBase 1.2.5为例子
    * 开启OpenSSH服务
    * 服务器的IP规划（可在hbase.init.hosts.sh脚本中修改）
        
        | 服务器名称 | IP地址 |
        |:--------: |:-------- |
        |zookeeper01|172.17.0.6 |
        |zookeeper02|172.17.0.7 |
        |zookeeper03|172.17.0.8 |
        |hbase01    |172.17.0.9 |
        |hbase02    |172.17.0.10|
    * 容器动态挂载的两个目录说明

        | 动态挂载目录 | 说明 |
        |:--------   |:-------- |
        |/hbase      |Apache HBase软件所在的主目录|
        |/jdk        |Java JDK所在的主目录|
    * 服务器的端口规划
        
        | 端口 | 说明 |
        |:--------: |:-------- |
        | 60000 |IPC |
        | 60010 |http服务端口 |
        | 60020 |IPC |
        | 60030 |http服务端口 |
        | 16000 | |
        | 16020 | |
        | 16030 | |
    * 容器启动命令样例
        ```sh
        docker run --name c_hbase01 -h hbase01 -p 60000:60000 -p 60010:60010 -p 60030:60030 -p 16000:16000 -p 16020:16020 -p 16030:16030 -p 2181:2181 -d -v /Users/hy/WSS/WorkSpace_Docker/hbase-1.2.5:/hbase -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hbase-ubuntu
        docker run --name c_hbase02 -h hbase02 -P -d -v /Users/hy/WSS/WorkSpace_Docker/hbase-1.2.5:/hbase -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/hbase-ubuntu
        ```
    * 容器进入命令样例
        ```sh
        docker exec -it c_hbase01 /bin/bash
        docker exec -it c_hbase02 /bin/bash
        ```
    * 配置IP、HostName、免密登录（所有容器均启动成功后）
        * 确认每台容器的IP，并配置在 /usr/bin/hbase.init.all.sh 脚本中。
        * 确认每台容器的IP，并配置在 /usr/bin/hbase.init.hosts.sh 脚本中。
        * 执行初始化配置命令：hbase.init.all.sh 。在所有容器中均要执行(默认为root)
            ```sh
            # 使用HBase自带的Zookeeper
            docker exec c_hbase01 hbase.init.all.sh hbase
            docker exec c_hbase02 hbase.init.all.sh hbase
            ```
            ```sh
            # 独立部署Zookeeper
            docker exec c_hbase01 hbase.init.all.sh zookeeper
            docker exec c_hbase02 hbase.init.all.sh zookeeper
            ```
    * 启动HBase集群
        * 主节点容器中执行启动命令：hbase-start.sh
    * HBase服务验证：
        * http://127.0.0.1:60010 查看HBase状态
    * 重启容器时hosts文件中的内容会丢失，所以要再次添加一次
        ```sh
        # 使用HBase自带的Zookeeper
        docker start c_hbase01
        docker start c_hbase02
        
        docker exec c_hbase01 hbase.init.hosts.sh hbase
        docker exec c_hbase02 hbase.init.hosts.sh hbase
        
        docker exec c_hbase01 start-hbase.sh
        ```
        ```ssh
        # 独立部署Zookeeper
        docker start c_hbase01
        docker start c_hbase02
        
        docker exec c_hbase01 hbase.init.hosts.sh zookeeper
        docker exec c_hbase02 hbase.init.hosts.sh zookeeper
        
        docker exec c_hbase01 start-hbase.sh
        ```
    * 停止容器、删除容器
        ```sh
        docker stop `docker ps -q -f name=c_hbase*`
        docker rm   `docker ps -a -q -f name=c_hbase*`
        ```
        
        
        
* [zookeeper-ubuntu动态Zookeeper版本环境](https://hub.docker.com/r/hyzhengwei/zookeeper-ubuntu)
    * 以安装Apache Zookeeper 3.4.10为例子
    * 开启OpenSSH服务
    * 服务器的IP规划（可在zookeeper.init.hosts.sh脚本中修改）
        
        | 服务器名称 | IP地址 |
        |:--------: |:-------- |
        |zookeeper01|172.17.0.6 |
        |zookeeper02|172.17.0.7 |
        |zookeeper03|172.17.0.8 |
    * 容器动态挂载的两个目录说明

        | 动态挂载目录 | 说明 |
        |:--------   |:-------- |
        |/zookeeper      |Apache Zookeeper软件所在的主目录|
        |/zookeeper_datas|Zookeeper数据目录。每个容器的目录路径应均不同且均有一个内容不同的myid文件|
        |/jdk            |Java JDK所在的主目录|
    * 服务器的端口规划
        
        | 端口 | 说明 |
        |:--------: |:-------- |
        | 2181 |对客户端提供服务的端口 |
        | 2888 |follower用来连接到leader，只在leader上监听该端口 |
        | 3888 |用于leader选举的 |
    * 容器启动命令样例
        ```sh
        docker run --name c_zookeeper01 -h zookeeper01 -p 2181:2181 -p 2888:2888 -p 3888:3888 -d -v /Users/hy/WSS/WorkSpace_Docker/zookeeper-3.4.10:/zookeeper -v /Users/hy/WSS/WorkSpace_Docker/zookeeper_datas01:/zookeeper_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/zookeeper-ubuntu
        docker run --name c_zookeeper02 -h zookeeper02 -P -d -v /Users/hy/WSS/WorkSpace_Docker/zookeeper-3.4.10:/zookeeper -v /Users/hy/WSS/WorkSpace_Docker/zookeeper_datas02:/zookeeper_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/zookeeper-ubuntu
        docker run --name c_zookeeper03 -h zookeeper03 -P -d -v /Users/hy/WSS/WorkSpace_Docker/zookeeper-3.4.10:/zookeeper -v /Users/hy/WSS/WorkSpace_Docker/zookeeper_datas03:/zookeeper_datas -v /Users/hy/WSS/WorkSpace_Docker/jdk1.8.0:/jdk:ro hyzhengwei/zookeeper-ubuntu
        ```
    * 容器进入命令样例
        ```sh
        docker exec -it c_zookeeper01 /bin/bash
        docker exec -it c_zookeeper02 /bin/bash
        docker exec -it c_zookeeper03 /bin/bash
        ```
    * 配置IP、HostName、免密登录（所有容器均启动成功后）
        * 确认每台容器的IP，并配置在 /usr/bin/zookeeper.init.all.sh 脚本中。
        * 确认每台容器的IP，并配置在 /usr/bin/zookeeper.init.hosts.sh 脚本中。
        * 执行初始化配置命令：zookeeper.init.all.sh 。在所有容器中均要执行(默认为root)
            ```sh
            docker exec c_zookeeper01 zookeeper.init.all.sh
            docker exec c_zookeeper02 zookeeper.init.all.sh
            docker exec c_zookeeper03 zookeeper.init.all.sh
            ```
    * 启动Zookeeper节点（每个节点均要执行）
        * 请确保动态挂载的/zookeeper_datas目录中有myid文件
        * 容器中执行启动命令（后台模式）：zkServer.sh start
        * 容器中执行启动命令（前台模式）：zkServer.sh start-foreground
        ```sh
        docker exec c_zookeeper01 zkServer.sh start
        docker exec c_zookeeper02 zkServer.sh start
        docker exec c_zookeeper03 zkServer.sh start
        ```
    * Zookeeper服务验证：
        * 查看状态（应有一个leader、两个follower）
        ```sh
        docker exec c_zookeeper01 zkServer.sh status
        docker exec c_zookeeper02 zkServer.sh status
        docker exec c_zookeeper03 zkServer.sh status
        ```
        * zkCli.sh -server  172.17.0.6:2181 ,172.17.0.7:2181 ,172.17.0.8:2181  客户端连接
    * 重启容器时hosts文件中的内容会丢失，所以要再次添加一次
        ```sh
        docker start c_zookeeper01
        docker start c_zookeeper02
        docker start c_zookeeper03
        
        docker exec c_zookeeper01 zookeeper.init.hosts.sh
        docker exec c_zookeeper02 zookeeper.init.hosts.sh
        docker exec c_zookeeper03 zookeeper.init.hosts.sh
        
        docker exec c_zookeeper01 zkServer.sh start
        docker exec c_zookeeper02 zkServer.sh start
        docker exec c_zookeeper03 zkServer.sh start
        ```
    * 停止容器、删除容器
        ```sh
        docker stop `docker ps -q -f name=c_zookeeper*`
        docker rm   `docker ps -a -q -f name=c_zookeeper*`
        ```