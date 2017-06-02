#!/bin/bash


# 设置host name
echo "172.17.0.2  hadoop01"    >> /etc/hosts

echo "172.17.0.6  hbase01"     >> /etc/hosts
echo "172.17.0.7  hbase02"     >> /etc/hosts


if [ "$1" = "hbase" ]; then

    exit

elif [ "$1" = "zookeeper" ]; then

    echo "172.17.0.8  zookeeper01" >> /etc/hosts
    echo "172.17.0.9  zookeeper02" >> /etc/hosts
    echo "172.17.0.10 zookeeper03" >> /etc/hosts

else  
    echo "Please select initialization zookeeper mode <hbase | zookeeper>."
    exit
fi




