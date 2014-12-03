#!/bin/bash
case $1 in
    resume)

    dir=`udevadm trigger --dry-run --verbose --subsystem-match=usb --attr-match=idVendor=1294 --attr-match=idProduct=1320 | head -1`
    dev=`ls  $dir  | head -1`
    if [[ ${dev:0:1} == [[:digit:]] ]]; then
        /usr/local/sbin/bind_unbind_usb_driver.sh $dev usbhid usbled
    fi
;;
    *)
;;
esac
