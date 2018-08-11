SER_NAME=wesign-mss-xxx
cd /home/zxyy && \
TAG=`cat tags| grep ${SRV_NAME} |awk -F":" '{printf $3}'` && \
sudo ssh zxyy@172.24.0.211 -p 22 "docker ps">>1.txt && \

OLD_TAG=`cat 1.txt|grep ${SRV_NAME} |awk -F":" '{printf $3}'|awk '{printf $1}'` && \

if [ "$TAG" = "$OLD_TAG" ];then
echo "success" 
else
sudo docker login reg.signit.cn:5000 -u zhd -p whoami?zhd && \
sudo docker pull reg.signit.cn:5000/signit/${SRV_NAME}-app:${TAG}  >/dev/null 2>&1 && \


cd image && \
sudo docker save -o ${SRV_NAME}.image reg.signit.cn:5000/signit/${SRV_NAME}-app:${TAG}  >/dev/null 2>&1 && \
sudo scp -P22 ${SRV_NAME}.image zxyy@172.24.0.211:~/ && \
sudo ssh zxyy@172.24.0.211 -p 22 "docker load -i ${SRV_NAME}.image" && \
sudo ssh zxyy@172.24.0.211 -p 22 "cd wesign;sed -i "s/$OLD_TAG/$TAG/g"  ${SRV_NAME}-app.yml;docker-compose -f ${SRV_NAME}-app.yml up -d "

fi
