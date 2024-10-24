#!/bin/bash

BOOTSTRAP_URL="http://mirror.rackspace.com/archlinux/iso/latest/archlinux-bootstrap-x86_64.tar.zst"
wget $BOOTSTRAP_URL -O ~/archlinux-bootstrap.tar.zst

mkdir ~/arch-uml

tar -I zstd -xvf ~/archlinux-bootstrap.tar.zst -C ~/arch-uml --strip-components=1

rm ~/archlinux-bootstrap.tar.zst
echo "Arch Linux bootstrap downloaded and extracted to ~/arch-uml"
