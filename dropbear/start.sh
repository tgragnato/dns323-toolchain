#!/bin/sh
path=/mnt/HD_a2/Nas_Prog/dropbear

# symlink ai file eseguibili
if [ ! -e "/usr/bin/dbclient" ]; then
	ln -s ${path}/dbclient /usr/bin/dbclient
fi
if [ ! -e "/usr/bin/dropbear" ]; then
	ln -s ${path}/dropbear /usr/bin/dropbear
fi
if [ ! -e "/usr/bin/dropbearconvert" ]; then
	ln -s ${path}/dropbearconvert /usr/bin/dropbearconvert
fi
if [ ! -e "/usr/bin/dropbearkey" ]; then
	ln -s ${path}/dropbearkey /usr/bin/dropbearkey
fi

# creo i device mancanti
if [ ! -e "/dev/urandom" ]; then
	mknod /dev/urandom c 1 8
fi
if [ ! -e "/dev/ptmx" ]; then
	mknod -m 0666 /dev/ptmx c 5 2
fi
if [ ! -d "/dev/pts" ]; then
	mkdir -p /dev/pts
fi
mount | grep devpts 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	mount -t devpts devpts /dev/pts
fi

# genero le chiavi mancanti
if [ ! -e "/etc/dropbear_dsa_host_key" ]; then
	/usr/bin/dropbearkey -t dss -f /etc/dropbear_dsa_host_key
fi
if [ ! -e "/etc/dropbear_rsa_host_key" ]; then
	/usr/bin/dropbearkey -t rsa -f /etc/dropbear_rsa_host_key
fi

# eseguo il demone
/usr/bin/dropbear -E 1>${path}/dropbear.log 2>&1 &