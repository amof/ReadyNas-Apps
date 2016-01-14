#!/bin/sh
pathToSeafile = /home/seafile #you must change it accordingly to your installation

# ldconfig - configure dynamic linker run-time bindings 
cmd="sudo ldconfig"

su - root -c "$cmd"

#Launch/Stop Seafile Server

cmd="bash -c 'cd ${pathToSeafile};" #

case $1 in
	"start")
		echo "Starting server..."
		cmd="$cmd seafile-admin start'"
		;;
	"stop")
		echo "Stopping server ..."
		cmd="$cmd seafile-admin stop'"
		;;
	*)
		echo "Use : seafile_lanch.sh start|stop";
esac

su - root -c "$cmd"
