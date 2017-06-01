#!/bin/bash


# 用预先设置好的Zookeeper配置信息覆盖Zookeeper包中的配置文件
cp $ZOOKEEPER_CONIFG_HY/* $ZOOKEEPER_CONF_DIR


# 设置host name
zookeeper.init.hosts.sh


# 无密码登录
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa

sshpass -p root ssh-copy-id -i zookeeper01 
sshpass -p root ssh-copy-id -i zookeeper02
sshpass -p root ssh-copy-id -i zookeeper03
