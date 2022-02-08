#!/bin/bash

LFS_DISK="$1"

sudo fdisk "$LFS_DISK" << EOF

o
n
p
1

+100M
N
a
n
p
2


N
p
w
EOF