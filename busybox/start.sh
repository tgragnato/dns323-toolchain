#!/bin/sh
path=/mnt/HD_a2/Nas_Prog/busybox

if [ ! -e "/dev/ptmx" ]; then
	/mnt/HD_a2/Nas_Prog/busybox/mknod -m 0666 /dev/ptmx c 5 2 
fi

if [ ! -d "/dev/pts" ]; then
	mkdir -p /dev/pts
fi

mount | grep devpts 1>/dev/null 2>/dev/null

if [ $? -ne 0 ]; then
	mount -t devpts devpts /dev/pts
fi

/mnt/HD_a2/Nas_Prog/busybox/telnetd -l /mnt/HD_a2/Nas_Prog/busybox/sh
