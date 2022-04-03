#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb

if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS"
    sudo chown -v $USER "$LFS"
fi

mkdir -pv $LFS/source $LFS/tools $LFS/boot $LFS/etc $LFS/bin $LFS/lib $LFS/sbin $LFS/usr $LFS/var

case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac

cp -rf *.sh packages.csv "$LFS/source" ; cd "$LFS/source" ; export PATH="$LFS/tools/bin:$PATH"

source download.sh

# binutils
# source packagesinstall.sh binutils
for packages in gcc linux-api-header glibc libstdc++; do
    source packagesinstall.sh $packages
done