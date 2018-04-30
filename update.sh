#!/bin/bash
echo "欢迎使用一键搭建"
echo "'
==========================================================================
                      欢迎使用网页雷达一键搭建脚本
                    本系统只支持CentOS 7.x 64系统
		        即将搭建的是4.30版本
                    网页雷达透视地址：你的IP:20086
                                                    by 阿杰             
=========================================================================='"
echo "即将搭建的是4.30版本"
read -p "回车后开始安装"
echo "请输入你的内网ip" 
read -p "内网ip： " ip
cp /root/yijian/restart.sh /root/restart.sh
chmod +x restart.sh
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log

echo "ss搭建成功，请记住连接信息"
read -p "按回车键继续安装雷达系统，按Ctrl+C结束安装" 

curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
source ~/.bash_profile
nvm install v9.8.0
nvm alias default v9.8.0
yum -y install gcc-c++
yum -y install flex
yum -y install bison
wget http://www.tcpdump.org/release/libpcap-1.8.1.tar.gz
tar -zxvf libpcap-1.8.1.tar.gz
cd libpcap-1.8.1
./configure
make
make install

git clone https://github.com/hjhpjj666/yijian.git
cd yijian/
npm i
npm i -g pino
npm install -g forever
forever start index.js sniff eth0 $ip | pino

echo "搭建完成，请断开服务器连接！"
echo "你的网页雷达透视地址：你的IP:20086"
