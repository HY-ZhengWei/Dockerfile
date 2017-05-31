#!/bin/bash


# 设置host name
echo "172.17.0.2  hadoop01"    >> /etc/hosts

echo "172.17.0.6  zookeeper01" >> /etc/hosts
echo "172.17.0.7  zookeeper02" >> /etc/hosts
echo "172.17.0.8  zookeeper03" >> /etc/hosts

echo "172.17.0.9  hbase01"     >> /etc/hosts
echo "172.17.0.10 hbase02"     >> /etc/hosts
