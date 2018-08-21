#!/bin/bash
function run() 
{
    MSS_NAME=$1 && \
    TAG=$2 && \
    cd ~/.docker-compose/wesign-enterprise && \
    TAG_TMP=`cat wesign-mss-${MSS_NAME}-app.yml |grep image | awk -F ":" '{printf $4}' |awk -F '"' '{printf $1}'` && \
    TAG_OLD=`echo ${TAG_TMP:0-13:14}` && \
    sudo  docker login reg.signit.cn:5000 -u zhd --password  whoami?zhd >/dev/null && \
    CON_ID=`docker ps | grep ${MSS_NAME} |awk '{printf $1}'` 
    if [ "$TAG" == "$TAG_OLD" ]
    then

        sudo docker stop ${CON_ID} >/dev/null 2>>~/error.log
        sudo docker-compose -f wesign-mss-${MSS_NAME}-app.yml rm --force >>~/update.log 2>>~/error.log && \
        sudo docker-compose -f wesign-mss-${MSS_NAME}-app.yml up -d >>~/update.log 2>>~/error.log
    else
        
        sed -i "s/${TAG_OLD}/${TAG}/g" `grep ${TAR_OLD} -rl wesign-mss-${MSS_NAME}-app.yml` && \
        sudo docker stop ${CON_ID} >>~/update.log 2>>~/error.log && \
        sudo docker-compose -f wesign-mss-${MSS_NAME}-app.yml up -d >>~/update.log 2>>~/error.log 
    fi 

    if [ $? -eq 0 ] 
    then
        echo -e "\t\033[32;49;1m ${MSS_NAME} updated successful  \033[39;49;0m"
    else 
        echo -e "\t\033[31;49;1m ${MSS_NAME} updated faild,cat ~/update.log  \033[39;49;0m"
    fi
}

run api 1.2.1.RELEASE && \
run certificate 1.0.4.RELEASE && \
run converter 1.0.3.RELEASE
run enterprise 1.1.3.RELEASE && \
run envelope 1.2.4.RELEASE && \
run eureka 1.0.1.RELEASE && \
run file 1.0.2.RELEASE && \
run form 1.0.5.RELEASE && \
run identity 1.0.6.RELEASE && \
run link 1.0.4.RELEASE && \
run policy 1.0.4.RELEASE && \
run pusher 1.0.2.RELEASE && \
run seal 1.1.3.RELEASE && \
run user 1.0.6.RELEASE && \
run verifier 1.0.3.RELEASE 



 