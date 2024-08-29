#!/bin/bash

# 安装必要的依赖
sudo yum install -y gcc zlib-devel wget make gcc

# 下载并解压 OpenSSL 最新版本
wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz
tar -xzvf openssl-1.1.1l.tar.gz
cd openssl-1.1.1l || exit

# 配置安装路径
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib

# 编译并安装
make && sudo make install

# 更新动态库链接
sudo echo "/usr/local/openssl/lib" > /etc/ld.so.conf.d/openssl-1.1.1l.conf
sudo ldconfig

# 验证 OpenSSL 更新是否成功
/usr/local/openssl/bin/openssl version
