#!/bin/sh

if [ ! $(id -u) -eq 0]; then
    echo "Run as root."
    exit 1
fi

if [ -z "$1" ]; then
    echo "Usage: ./install.sh HOME"
    exit 1
else
    home="$1"
fi

PACKMAN="yaourt -S"
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

cp -r .config/ $home/
cp -r .data/ $home/
cp -r .bin/ $home/
cp -r .panel/ $home/
cp .*rc $home/
cp .X* $home/
cp .*colors $home/
