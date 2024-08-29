#!/bin/bash
dnf install -y wget make gcc bzip2-devel openssl-devel zlib-devel libffi-devel
wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz
sudo tar -xf Python-3.10.13.tgz
cd  Python-3.10.13 || exit
./configure --enable-optimizations
sudo make -j$(nproc)
sudo make install
sudo ln -s /usr/local/bin/python3.10 /usr/local/bin/python3
sudo ln -s /usr/local/bin/pip3.10 /usr/local/bin/pip3
sudo ln -s /usr/local/bin/python3.10 /usr/bin/python3
sudo ln -s /usr/local/bin/pip3.10 /usr/bin/pip3
python3 --version