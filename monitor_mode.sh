#!/bin/bash

# Retrieve information
WHOAMI=`whoami`
WIFLAN=`iw dev | grep -i interface | cut -d " " -f 2 | head -n 1`

# Start of the script

if [ "$WHOAMI" != "root" ] ; then
	echo -e "\033[0;31m[!]\033[0m Script needs to run as root!"
	exit 0;
fi

if [ ! "$WIFLAN" ]; then
   echo -e "\033[0;31m[!]\033[0m No available WiFi interface has been found!"
   exit 0;
fi

if [ -n "$1" ]; then
	INTERFACE=$1
else
	echo -e "\033[0;34m[+]\033[0m No WiFi interface provided as an argument. Detecting interfaces automatically..."
	INTERFACE=$WIFLAN
	echo -e "\033[0;34m[+]\033[0m Detected interface $INTERFACE"
fi

echo -e "\033[0;34m[+]\033[0m Bringing WiFi interface down..."
ip link set $INTERFACE down

echo -e "\033[0;34m[+]\033[0m Setting WiFi interface in monitor mode..."
iw $INTERFACE set monitor control

echo -e "\033[0;34m[+]\033[0m Bringing WiFi interface up..."
ip link set $INTERFACE up

echo -e "\033[0;34m[+]\033[0m Monitor interface ready!"