#!/bin/bash

FILE="/home/"$USER"/Desktop"
function usage()
{
	echo "use -f to specify the file. Your path is 'home/user/[yourfile]'"
	echo "use -s to display the results to stdout"
}

function commands()
{
        while true
        do
        date
        echo "--------------memory utilization---------------"
        ps -eo pid,ppid,cmd,%mem --sort=-%mem |head -n 10
        echo ""
        echo "-------------------free space-------------------"
        df -h 
        echo ""
        echo "------------------system load---------------------"
        uptime
	echo "---------------nums of zombie processes------------------"
	ps -aux |grep "defunct" |wc -l
        echo "______________________________________________________________________"
        echo "reload per 10s"
        echo "press ctrl c to terminate the execution"
        sleep 10s
        done
}

while getopts f:s param ; do
case $param in
	f)
        echo "press ctrl c to terminate the execution"

	 commands > $FILE/$2
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
