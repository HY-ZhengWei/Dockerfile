#!/bin/bash


scp -r $HADOOP_HOME/etc/hadoop/*  root@hadoop02:$HADOOP_HOME/etc/hadoop
scp -r $HADOOP_HOME/etc/hadoop/*  root@hadoop03:$HADOOP_HOME/etc/hadoop
scp -r $HADOOP_HOME/etc/hadoop/*  root@hadoop04:$HADOOP_HOME/etc/hadoop

scp -r /usr/bin/hadoop.*.sh       root@hadoop02:/usr/bin
scp -r /usr/bin/hadoop.*.sh       root@hadoop03:/usr/bin
scp -r /usr/bin/hadoop.*.sh       root@hadoop04:/usr/bin
