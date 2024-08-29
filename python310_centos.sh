#!/bin/bash

# 更新系统
sudo yum update -y

# 安装必要的依赖
sudo yum install -y zlib zlib-devel bzip2-devel openssl-devel ncurses-devel libuuid-devel sqlite-devel readline-devel tcl-devel tk-devel lzma gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel make gcc wget

# 下载并安装更新的OpenSSL
wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz
tar -xzvf openssl-1.1.1l.tar.gz
cd openssl-1.1.1l || exit
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
make && sudo make install

# 更新动态库链接
sudo cp /usr/bin/openssl /usr/bin/openssl.bak
sudo rm -f /usr/bin/openssl
sudo ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
sudo ln -s /usr/local/openssl/include/openssl /usr/include/openssl
sudo ln -s /usr/local/openssl/lib/libssl.so.1.1 /usr/lib64/libssl.so.1.1
sudo ln -s /usr/local/openssl/lib/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.1
sudo echo "/usr/local/ssl/lib" > /etc/ld.so.conf.d/openssl-1.1.1l.conf
sudo ldconfig  -v

openssl version

# 返回到用户主目录
cd ~ || exit

# 下载Python 3.10源代码
wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz

# 解压源代码
tar -xzvf Python-3.10.13.tgz

# 进入解压后的目录
cd Python-3.10.13 || exit

# 配置安装路径，指定OpenSSL路径
./configure --prefix=/usr/local --with-openssl=/usr/local/ssl

# 编译和安装
sudo make -j$(nproc)
sudo make install

# 创建软链接
sudo ln -s /usr/local/bin/python3.10 /usr/local/bin/python3
sudo ln -s /usr/local/bin/pip3.10 /usr/local/bin/pip3
sudo ln -s /usr/local/bin/python3.10 /usr/bin/python3
sudo ln -s /usr/local/bin/pip3.10 /usr/bin/pip3

# 验证安装和软链接是否成功
python3.10 --version
