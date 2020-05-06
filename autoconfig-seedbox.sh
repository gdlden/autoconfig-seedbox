#!/bin/bash

#给出第一个参数为客户端用户名
#给出第二个参数为下载客户端的密码
#给出第三个参数为rss链接
#给出第四个参数为系统用户名
#给出第五个参数为系统用户密码
#给出第六个参数为客户端的地址 比如http://127.0.0.1:2017
#for arm

#autoconfig t-rss
cd /home/$4 &&
mkdir -p /home/$4/t-rss &&
mkdir -p /home/$4/t-rss/.RSS-saved && 
cd /home/$4/t-rss && chmod 777 .RSS-saved &&
wget https://github.com/capric98/t-rss/releases/download/v0.5.4beta/t-rss_linux_arm.zip && unzip t-rss_linux_arm.zip 

cat << EOF > config.yml
#t-rssd 配置文件demo
hd4fans: 
#rss链接
  rss: rsslink
  quota: 
    num: 3     
  interval: 60 
  client:
    local_qB: 
      type: qBittorrent 
      host: http://127.0.0.1:2017
      username: user
      password: passwd
      dlLimit: 20M
      upLimit: 12M
EOF
sed -i -e "4c\  rss: $3" config.yml && sed -i -e "11c\      host: $6" config.yml && sed -i -e "12c\      username: $1" config.yml && sed -i -e "13c\      password: $2" config.yml &&
echo $4 | sudo -S apt-get -y install screen &&
screen -dmS t-rss && screen -S t-rss -X stuff $"/home/$4/t-rss/t-rss -config /home/$4/t-rss/config.yml -debug\n"