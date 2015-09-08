#!/bin/sh

if [ ! $(id -u) -eq 0]; then
    echo "Run as root."
    exit 1
fi

TMP_FILE="/tmp/ft"

mkdir -p "$TMP_FILE"
cd $TMP_FILE
git clone https://github.com/Rolbrok/ft.git
cd ft
make
make install
cd -
