#!/bin/bash

FILE="/home/"$USER"/Desktop"
function usage()
{
	echo "use -f to specify the file. Your path is 'home/user/[yourfile]'"
	echo "use -s to display the results to stdout"
}

function commands(){
        while true
        do
        date
        

        #ps -eo pid,ppid,cmd,%mem --sort=-%mem |head -n 10
	c1=$(ps -eo %mem --sort=-%mem | awk 'NR==2 {print "max mem usage:"$1"%"}')
        
        #df -h 
	c2=$(df -h --output=size --total | awk 'END {print "total space:" $1}')
        
        #uptime
	c3=$(uptime |tr -d \, |awk '{print "1m 5m 15m load avarage:"$8,$9,$10}')
	
	#c4=$(ps -aux |grep "defunct" |wc -l)
	c4=$(ps -aux|grep -v grep|grep "defunct" |awk '{print "pid of zombieS:" $2}')

	echo $c1,$c2,$c3,$c4
      echo "________-_______________________________________________________________________________________"

        sleep 10s
        done
}

while getopts f:s param ; do
case $param in
	f)
        echo "press ctrl c to terminate the execution"

	 #commands 2>&1 1> $FILE/$2
	 commands &> $FILE/$2

	;;
	s)
	 commands
	;;
	*)
	echo "invalid argument"
	;;
esac
done

shift $((OPTIND-1))
usage
