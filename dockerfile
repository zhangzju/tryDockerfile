#Dockerfile
FROM ubuntu:14.04
#指定系统
MAINTAINER zhangzju <zhangwei_w8284@tp-link.com.cn>
#切换镜像源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && touch sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ trusty main restricted" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ trusty-updates main restricted" >> sources.list  \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ trusty universe" >> sources.list  \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ trusty-updates universe" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ trusty multiverse" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ trusty-updates multiverse" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu/ trusty-backports main restricted universe multiverse" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu trusty-security main restricted" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu trusty-security universe" >> sources.list \
    && echo "deb http://rdsource.tp-link.net/ubuntu trusty-security multiverse" >> sources.list
#切换架构
RUN dpkg --add-architecture i386 
#设置环境变量
ENV TERM linux
#安装依赖
RUN cp sources.list /etc/apt/sources.list \
    &&  apt-get update \
    &&  buildDeps='gcc g++ make tftp tftpd xinetd build-essential dos2unix lib32z1 zlib1g-dev gcc-4.7-multilib vim bison flex gawk libstdc++5:i386 libstdc++6:i386 texinfo tcl git gperf automake autoconf autotools-dev pkg-config libusb-dev libtool' \
    &&  apt-get install -y $buildDeps \
    &&  mkdir -p /opt/bba/
#指定工作路径
WORKDIR /opt/bba
#切换sh
RUN ln -fs /bin/bash /bin/sh
#BRCM
RUN wget https://launchpad.net/~dns/+archive/ubuntu/gnu/+files/automake_1.13.1-0gnu2~11.10_all.deb \
	&& dpkg -i automake_1.13.1-0gnu2~11.10_all.deb 
#添加mips toolchain，注意tar文件一定要放在dockerfile的同意路径下，名称要相同
COPY ./mips-linux-uclibc-4.3.6-v2.tgz /opt/bba
RUN mkdir /opt/trendchip \
	&& tar xvfz mips-linux-uclibc-4.3.6-v2.tgz \
    && mv mips-linux-uclibc-4.3.6-v2 /opt/trendchip
#链接perl 
RUN ln -s /usr/bin/perl /usr/local/bin/perl
#添加初始挂载点
VOLUME /opt/bba