#!/bin/bash

set -e

#GCC_VERSION=$(curl -s https://ftp.gnu.org/gnu/gcc/ | grep -oP 'gcc-\K[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)
GCC_VERSION="5.4.0"
GCC_URL="https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2"
INSTALL_DIR="/usr/local"

sudo yum groupinstall -y "Development Tools"
sudo yum install -y gmp gmp-devel mpfr mpfr-devel libmpc libmpc-devel wget curl bison flex texinfo

cd /usr/local/src
wget $GCC_URL

tar -xjf "gcc-$GCC_VERSION.tar.bz2"
cd "gcc-$GCC_VERSION"

./contrib/download_prerequisites

mkdir build
cd build

../configure --enable-languages=c,c++ --disable-multilib --prefix=$INSTALL_DIR
make
sudo make install

sudo ldconfig

cd /usr/local/src
rm -rf "gcc-$GCC_VERSION"
rm "gcc-$GCC_VERSION.tar.bz2"

echo "GCC $GCC_VERSION has been installed successfully!"
