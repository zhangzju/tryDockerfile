#Dockerfile
FROM ubuntu:16.04
#指定系统
MAINTAINER zhangzju <zhangwei_w8284@tp-link.com.cn>
#切换镜像源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && touch sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ xenial main restricted" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ xenial-updates main restricted" >> sources.list  \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ xenial universe" >> sources.list  \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ xenial-updates universe" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ xenial multiverse" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ xenial-updates multiverse" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ xenial-backports main restricted universe multiverse" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu xenial-security main restricted" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu xenial-security universe" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu xenial-security multiverse" >> sources.list
#切换架构
RUN dpkg --add-architecture i386 
#安装依赖
RUN cp sources.list /etc/apt/sources.list \
    &&  apt-get update \
    &&  buildDeps='make tftp tftpd xinetd build-essential dos2unix lib32z1 zlib1g-dev gcc-4.7-multilib vim bison flex gawk libstdc++5:i386 libstdc++6:i386 texinfo tcl git gperf automake' \
    &&  apt-get install -y $buildDeps \
    &&  mkdir -p /opt/bba/
#链接perl 
RUN ln -s /usr/bin/perl /usr/local/bin/perl
#添加初始挂载点
VOLUME /opt/bba