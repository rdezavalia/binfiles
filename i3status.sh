#!/bin/bash
#===============================================================================
#
#          FILE:  i3status.sh
#
#         USAGE:  ./i3status.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Ramiro de Zavalia (rdz), r.dezavalia@tiba.com
#       COMPANY:
#       VERSION:  1.0
#       CREATED:  20120305 14:50
#      REVISION:  ---
#===============================================================================


if [ "$HOSTNAME" == "pc-rdz-linux" ]; then
    I3STATUS="i3status -c $HOME/.i3/i3status.work.conf"
else
    I3STATUS="i3status -c $HOME/.i3/i3status.conf"
fi

$I3STATUS | while :
do
    read line
    hostname=$(hostname)
    freemem=$(($(awk '/MemFree/ {print $2}' /proc/meminfo)/1024))
    echo " [$hostname] | Mem: $freemem MB | $line"
done

