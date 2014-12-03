#!/bin/bash
# 1 -- colour to turn on
dir=`udevadm trigger --dry-run --verbose --subsystem-match=usb --attr-match=idVendor=1294 --attr-match=idProduct=1320 | head -1`
dev=`ls  $dir  | head -1`; # expected device file in form n-m:x.y
# trivial test if the first char is not a digit | regex may be considered a better way
if [[ ${dev:0:1} == [[:digit:]] ]]; then
  echo 1 > /sys/bus/usb/devices/$dev/$1
else
  echo No device detected
fi
