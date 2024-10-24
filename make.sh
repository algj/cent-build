#!/bin/bash

MAKE_VERSION=$(curl -s https://ftp.gnu.org/gnu/make/ | grep -oP 'make-\K[0-9]+\.[0-9]+' | sort -V | tail -n 1)
MAKE_TAR="make-${MAKE_VERSION}.tar.gz"

echo "Downloading GNU Make ${MAKE_VERSION}..."
wget https://ftp.gnu.org/gnu/make/${MAKE_TAR}

echo "Extracting GNU Make..."
tar -xvf ${MAKE_TAR}

cd "make-${MAKE_VERSION}"

echo "Configuring and compiling GNU Make..."
./configure
make
sudo make install

bash -c "make --version"

cd ..
rm -rf "make-${MAKE_VERSION}" ${MAKE_TAR}

echo "GNU Make ${MAKE_VERSION} installed successfully!"
