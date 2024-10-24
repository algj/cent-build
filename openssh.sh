#!/bin/bash

set -e

OPENSSH_VERSION=$(curl -s https://api.github.com/repos/openssh/openssh-portable/tags | grep 'name' | head -n 1 | cut -d '"' -f 4)
OPENSSH_URL="https://github.com/openssh/openssh-portable/archive/refs/tags/$OPENSSH_VERSION.tar.gz"
INSTALL_DIR="/usr/local"

sudo yum groupinstall -y "Development Tools"
sudo yum install -y perl wget curl

cd /usr/local/src
wget $OPENSSH_URL

tar -xzf $OPENSSH_VERSION.tar.gz
cd openssh-portable-$OPENSSH_VERSION

./configure --prefix=$INSTALL_DIR
make -j$(nproc)
sudo make install

sudo ldconfig

cd /usr/local/src
rm -rf openssh-portable-$OPENSSH_VERSION
rm $OPENSSH_VERSION.tar.gz

echo "OpenSSH $OPENSSH_VERSION has been installed successfully!"
