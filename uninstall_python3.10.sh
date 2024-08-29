#!/bin/bash

# 确认脚本以root用户或具有sudo权限的用户运行
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo privileges"
   exit 1
fi

# 查找Python 3.10的安装位置
PYTHON_BIN_PATH=$(which python3)

if [ -z "$PYTHON_BIN_PATH" ]; then
    echo "Python 3.10 is not installed."
    exit 1
fi

# 获取Python 3.10的安装目录
PYTHON_INSTALL_DIR=$(dirname $(dirname $PYTHON_BIN_PATH))

echo "Found Python 3.10 installation at: $PYTHON_INSTALL_DIR"

# 删除Python 3.10的二进制文件和库文件
rm -rf $PYTHON_INSTALL_DIR/bin/python3.10
rm -rf $PYTHON_INSTALL_DIR/lib/python3.10

# 删除可能的配置文件和目录
rm -rf ~/.local/lib/python3.10
rm -rf ~/.local/bin/python3.10

# 更新环境变量，删除与Python 3.10相关的路径
sed -i '/export PATH=.*python3.10/d' ~/.bashrc
sed -i '/export PATH=.*python3.10/d' ~/.bash_profile

# 重新加载配置文件
source ~/.bashrc

echo "Python 3.10 has been successfully uninstalled."

exit 0
