#!/bin/sh

# termino i processi
killall dbclient
sleep 1
killall dropbear
sleep 1
killall dropbearconvert
sleep 1
killall dropbearkey
sleep 1

# elimino i symlink 
rm -f /usr/bin/dbclient
rm -f /usr/bin/dropbear
rm -f /usr/bin/dropbearconvert
rm -f /usr/bin/dropbearkey