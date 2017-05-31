#!/bin/bash


# 用预先设置好的HBase配置信息覆盖HBase包中的配置文件
cp $HBASE_CONIFG_HY/* $HBASE_CONF_DIR


# 设置host name
hbase.init.hosts.sh


# 无密码登录
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa

ssh-copy-id -i hbase01 
ssh-copy-id -i hbase02
