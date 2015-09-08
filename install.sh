#!/bin/sh

if [ ! $(id -u) -eq 0]; then
    echo "Run as root."
    exit 1
fi

PACKMAN="pacman -S"

TMP_FOLDER="/tmp/ft"

mkdir -p "$TMP_FOLDER"
cd $TMP_FOLDER
git clone https://github.com/Rolbrok/ft.git
cd ft
make
make install
cd -

for line in $(cat depends.txt); do
    $PACKMAN $line
done
