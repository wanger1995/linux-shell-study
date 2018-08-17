#!/bin/bash
funcion run {
TAG_OLD=`cat wesign-mss-certificate-app.yml |grep image | awk -F ":" '{printf $4}' |awk -F '"' '{printf $1}'` && \
MSS_NAME=$1 && \
TAG=$2 && \
cd ~/.docker-compose/wesign-enterprise && \
sed -i "s/${TAG_OLD}/${TAG}/g" wesign-mss-${MSS_NAME}-app.yml && \
docker stop `docker ps | grep $MSS_NAME |awk '{printf $1}'` && \
docker-compose -f wesign-mss-${MSS}-app.yml up -d 
}

run api 1.2.1.RELEASE
run 