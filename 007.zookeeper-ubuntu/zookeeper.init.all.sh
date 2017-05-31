#!/bin/bash


# 用预先设置好的Zookeeper配置信息覆盖Zookeeper包中的配置文件
cp $ZOOKEEPER_CONIFG_HY/* $ZOOKEEPER_CONF_DIR


# 设置host name
zookeeper.init.hosts.sh
