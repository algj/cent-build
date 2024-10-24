#!/bin/bash

set -e

OPENSSL_VERSION=$(curl -s https://api.github.com/repos/openssl/openssl/releases/latest | grep 'tag_name' | cut -d '"' -f 4)
OPENSSL_URL="https://github.com/openssl/openssl/releases/download/$OPENSSL_VERSION/$OPENSSL_VERSION.tar.gz"
INSTALL_DIR="/usr/local"

sudo yum groupinstall -y "Development Tools"
sudo yum install -y perl wget curl

cd /usr/local/src
wget $OPENSSL_URL

tar -xzf $OPENSSL_VERSION.tar.gz
cd $OPENSSL_VERSION

./config --prefix=$INSTALL_DIR -fPIC
make -j$(nproc)
sudo make install

sudo cp ./libssl.so* /usr/local/lib/
sudo cp ./libcrypto.so* /usr/local/lib/

sudo ldconfig

openssl version

cd /usr/local/src
rm -rf openssl-$OPENSSL_VERSION
rm openssl-$OPENSSL_VERSION.tar.gz

echo "OpenSSL $OPENSSL_VERSION has been installed successfully!"
