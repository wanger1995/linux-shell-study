
#!/bin/bash
#ping域名测试
#需在本地目录创建pings的文件，存放待ping的host
#author hjf

for host_s in $(cat ./database_host)
do
    ping -c 1 $host_s >/dev/null 2>&1
    if [[ $? == 0 ]];
    then
        echo -e "$host_s  is ok"
    else
        echo -e "error : $host_s not know"
    fi
done
