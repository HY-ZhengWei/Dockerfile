#!/bin/bash


# 用预先设置好的Hadoop配置信息覆盖Hadoop包中的配置文件
cp $HADOOP_CONIFG_HY/* $HADOOP_CONF_DIR


# 设置host name
echo "172.17.0.2  hadoop01" >> /etc/hosts
echo "172.17.0.3  hadoop02" >> /etc/hosts
echo "172.17.0.4  hadoop03" >> /etc/hosts
echo "172.17.0.5  hadoop04" >> /etc/hosts


# 无密码登录
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa

ssh-copy-id -i hadoop01 
ssh-copy-id -i hadoop02
ssh-copy-id -i hadoop03
ssh-copy-id -i hadoop04
