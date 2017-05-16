# Dockerfile


* [base-ubuntu基础镜像](https://hub.docker.com/r/hyzhengwei/base-ubuntu)
    * 设置时区为：中国
    * 安装vi、ifconfig、netstat、telnet命令

* [jdk-ubuntu动态JDK版本环境](https://hub.docker.com/r/hyzhengwei/jdk-ubuntu/)
    * 动态JDK版本环境。JDK版本可由最终用户来决定。通过-v动态挂载的方式添加到运行的容器中。
    * 容器运行命令样例：docker run --name c_jdk --rm -it -v JDK在宿主机的路径:/jdk:ro hyzhengwei/jdk-ubuntu
    