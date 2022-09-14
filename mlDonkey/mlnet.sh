#!/bin/sh

export MLDONKEY_DIR="/mnt/HD_b2/BT"
export TMPDIR="/mnt/HD_b2/BT/temp"

MLNETBINDIR="/mnt/HD_a2/fun_plug.d/bin"
MLNETLOG="/mnt/HD_a2/fun_plug.d/log/mlnet.log"

echo "Sto per eseguire la sequenza di avvio di mlnet..."

#controlla se sta già girando
if [ -n "$(pidof mlnet)" ]; then
	echo "mlnet is already runnning"
else
	#controlla se vi sono file residui delle scorse esecuzioni
	if [ -e ${MLDONKEY_DIR}/mlnet.pid ]; then
		rm ${MLDONKEY_DIR}/mlnet.pid
	fi
	if [ -e ${MLDONKEY_DIR}/files.ini.tmp ]; then
		rm ${MLDONKEY_DIR}/files.ini.tmp
	fi

	${MLNETBINDIR}/mlnet > ${MLNETLOG} 2>&1 &
	echo "mlnet avviato. controlla ${MLNETLOG} per maggiori dettagli"
	
	chmod 777 ${MLDONKEY_DIR}/incoming/ 
	chmod 777 ${MLDONKEY_DIR}/incoming/*
fi
