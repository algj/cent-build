#!/bin/bash

LATEST_KERNEL=$(curl -s https://www.kernel.org | grep -oP '(?<=<strong>)[^<]+(?=</strong>)' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1)

if [ -z "$LATEST_KERNEL" ]; then
    echo "Error fetching kernel version."
    exit 1
fi

MAJOR_VERSION=$(echo $LATEST_KERNEL | cut -d '.' -f 1)
DOWNLOAD_URL="https://cdn.kernel.org/pub/linux/kernel/v${MAJOR_VERSION}.x/linux-${LATEST_KERNEL}.tar.xz"

wget $DOWNLOAD_URL

if [ $? -eq 0 ]; then
    echo "Kernel downloaded: linux-$LATEST_KERNEL"
else
    echo "Download failed."
fi

tar -xvf linux-$LATEST_KERNEL.tar.xz
rm -rf linux-$LATEST_KERNEL.tar.xz
