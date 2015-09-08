#!/bin/sh

status=$(homenetwork)
if [ "$status" == "Connected." ]; then
    sudo mount_rpi
fi
