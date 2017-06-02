#!/bin/bash



# 使用HBase自带的zookeeper
if [ "$1" = "hbase" ]; then

    cp $HBASE_CONIFG_HY/* $HBASE_CONF_DIR

# 使用独立部署的zookeeper
elif [ "$1" = "zookeeper" ]; then

    cp ${HBASE_CONIFG_HY}_zookeeper/* $HBASE_CONF_DIR
    
else  
  echo "Please select initialization zookeeper mode <hbase | zookeeper>."
  exit
fi



# 设置host name
hbase.init.hosts.sh $1


# 无密码登录
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa

sshpass -p root ssh-copy-id -i hbase01 
sshpass -p root ssh-copy-id -i hbase02

if [ "$1" = "zookeeper" ]; then

sshpass -p root ssh-copy-id -i zookeeper01
sshpass -p root ssh-copy-id -i zookeeper02
sshpass -p root ssh-copy-id -i zookeeper03

fi
