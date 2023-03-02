#!/bin/bash
#**************************************
# @file    : wait-for-db.sh
# @author  : zhaoyuqiang
# @date    : 2022-01-19
#**************************************
yum install nc -y;

wait_for() {
    while ! nc -z $1 $2;
    do
      echo "wait for db";
      sleep 1;
    done;
}

#这里将接收两个参数：一个是db的主机名；另一个是端口号
host="$1"
port="$2"

#检查db模块是否已经启动
wait_for $host $port

echo "db is running!";
echo "start web service from here";