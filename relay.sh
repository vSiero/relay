#!/bin/bash
#set -o errexit
#set -o pipefail
#set -o nounset

#__ddir="$(cd "$(dirname "${BASH_SOURCE[0]}" && pwd)")"
#__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
#__base="$(basename ${__file} .sh)"


function usage {
    echo "Usage: relay.sh <on|off|status> <relay number>"
#    echo "Example: relay.sh on 1 2"
#    echo "Example: relay.sh off 1 2 4 5"
#    echo "Example: relay.sh on all"
#    echo "Example: relay.sh off all"
}

function r_status {
    if [ $(cat /sys/class/gpio/gpio22/value) = 0 ]; then r1=1; else r1=0; fi
    if [ $(cat /sys/class/gpio/gpio23/value) = 0 ]; then r2=1; else r2=0; fi
    if [ $(cat /sys/class/gpio/gpio24/value) = 0 ]; then r3=1; else r3=0; fi
    if [ $(cat /sys/class/gpio/gpio25/value) = 0 ]; then r4=1; else r4=0; fi
    echo "$r1 $r2 $r3 $r4"
}

function r_off {
case $1 in
	1)
	echo 22 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio22/direction 2>&1
	echo 1 > /sys/class/gpio/gpio22/value 2>&1
	;;
	2)
	echo 23 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio23/direction 2>&1
	echo 1 > /sys/class/gpio/gpio23/value 2>&1
	;;
	3)
	echo 24 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio24/direction 2>&1
	echo 1 > /sys/class/gpio/gpio24/value 2>&1
	;;
	4)
	echo 25 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio25/direction 2>&1
	echo 1 > /sys/class/gpio/gpio25/value 2>&1
	;;
	*)
	echo "no such relay $1"
	;;
esac
}

function r_on {
case $1 in
	1)
	echo 22 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio22/direction 2>&1
	echo 0 > /sys/class/gpio/gpio22/value 2>&1
	;;
	2)
	echo 23 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio23/direction 2>&1
	echo 0 > /sys/class/gpio/gpio23/value 2>&1
	;;
	3)
	echo 24 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio24/direction 2>&1
	echo 0 > /sys/class/gpio/gpio24/value 2>&1
	;;
	4)
	echo 25 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio25/direction 2>&1
	echo 0 > /sys/class/gpio/gpio25/value 2>&1
	;;
	*)
	echo "no such relay $1"
	;;
esac
}

function r_on_all {
	echo 22 > /sys/class/gpio/export 2>&1
	echo 23 > /sys/class/gpio/export 2>&1
	echo 24 > /sys/class/gpio/export 2>&1
	echo 25 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio22/direction 2>&1
	echo out > /sys/class/gpio/gpio23/direction 2>&1
	echo out > /sys/class/gpio/gpio24/direction 2>&1
	echo out > /sys/class/gpio/gpio25/direction 2>&1
	echo 0 > /sys/class/gpio/gpio22/value 2>&1
	echo 0 > /sys/class/gpio/gpio23/value 2>&1
	echo 0 > /sys/class/gpio/gpio24/value 2>&1
	echo 0 > /sys/class/gpio/gpio25/value 2>&1
}

function r_off_all {
	echo 22 > /sys/class/gpio/export 2>&1
	echo 23 > /sys/class/gpio/export 2>&1
	echo 24 > /sys/class/gpio/export 2>&1
	echo 25 > /sys/class/gpio/export 2>&1
	echo out > /sys/class/gpio/gpio22/direction 2>&1
	echo out > /sys/class/gpio/gpio23/direction 2>&1
	echo out > /sys/class/gpio/gpio24/direction 2>&1
	echo out > /sys/class/gpio/gpio25/direction 2>&1
	echo 1 > /sys/class/gpio/gpio22/value 2>&1
	echo 1 > /sys/class/gpio/gpio23/value 2>&1
	echo 1 > /sys/class/gpio/gpio24/value 2>&1
	echo 1 > /sys/class/gpio/gpio25/value 2>&1
}


# Script logic
# $# - returns number of positional parameters in decimal
if [ $# -lt 1 ] || [ $# -gt 5 ]
then
    usage
    exit
fi

case $1 in
    "on")
	if [ $2 = "all" ]; then
	    r_on_all
	else
	    cnt=1
	    for arg in "$@"
	    do
		if [ $cnt -gt 1 ]; then r_on $arg; fi; let "cnt+=1";
	    done
	fi
    ;;
    "off")
	if [ $2 = "all" ]; then
	    r_off_all
	else
	    cnt=1
	    for arg in "$@"
	    do
		if [ $cnt -gt 1 ]; then r_off $arg; fi; let "cnt+=1";
	    done
	fi
    ;;
    "status")
    r_status
    ;;
    *)
    r_status
    ;;
esac