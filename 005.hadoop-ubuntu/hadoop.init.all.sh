#!/bin/bash


# 用预先设置好的Hadoop配置信息覆盖Hadoop包中的配置文件
cp $HADOOP_CONIFG_HY/* $HADOOP_CONF_DIR


# 设置host name
hadoop.init.hosts.sh


# 无密码登录
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa

sshpass -p root ssh-copy-id -i hadoop01 
sshpass -p root ssh-copy-id -i hadoop02
sshpass -p root ssh-copy-id -i hadoop03
sshpass -p root ssh-copy-id -i hadoop04
