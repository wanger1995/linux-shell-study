#!/bin/bash
function run() 
{
    MSS_NAME=$1 && \
    TAG=$2 && \
    cd ~/.docker-compose/wesign-enterprise && \
    TAG_OLD=`cat wesign-mss-${MSS_NAME}-app.yml |grep image | awk -F ":" '{printf $4}' |awk -F '"' '{printf $1}'` && \
    

    sed -i "s/${TAG_OLD}/${TAG}/g" wesign-mss-${MSS_NAME}-app.yml && \
    docker stop `docker ps | grep ${MSS_NAME} |awk '{printf $1}'` >/dev/null 2>&1
    docker-compose -f wesign-mss-${MSS_NAME}-app.yml up -d >>update.log
    if [ $? -eq 0 ] 
    then
        echo -e "\t\033[32;49;1m ${MSS_NAME} updated successful  \033[39;49;0m"
    else 
        echo -e "\t\033[31;49;1m ${MSS_NAME} updated faild,cat update.log  \033[39;49;0m"
    fi
}



run api 1.2.1.RELEASE && \
run developer 1.0.3.RELEASE && \
run open 1.0.1.RELEASE && \
run link 1.1.4.RELEASE && \
run enterprise 1.1.4.RELEASE && \
run policy 1.0.4.RELEASE 
