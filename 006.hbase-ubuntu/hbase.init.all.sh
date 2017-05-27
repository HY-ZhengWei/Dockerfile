#!/bin/bash


# 用预先设置好的HBase配置信息覆盖HBase包中的配置文件
cp $HBASE_CONIFG_HY/* $HBASE_CONF_DIR


# 设置host name
hbase.init.hosts.sh
