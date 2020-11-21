#!/bin/bash

XENFORO_DIR="."
XENFORO_ZIP="./xenforo.zip"

function install() {
    echo "protecting xenforo zip by moving it temporarily into /tmp"
    mv $XENFORO_ZIP /tmp/xenforo.zip

    if [ -f "admin.php" ]; then
        echo "Removing existing xenforo dir"
        git clean -xdf;
    fi

    mv /tmp/xenforo.zip $XENFORO_ZIP


    unzip $XENFORO_ZIP -d $XENFORO_DIR
    cp -r $XENFORO_DIR/upload/** $XENFORO_DIR/
    rm -Rf $XENFORO_DIR/upload XF2-INSTALL-UPGRADE.txt
    echo "Xenforo unzipped into $XENFORO_DIR"


    echo "Setting correct file permissions - requires sudo!"

    if [ "$(uname)" == "Darwin" ]; then
        sudo chown -R $(whoami):staff ./
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        sudo chown -R $(whoami):$(whoami) ./
    fi

    sudo chmod 0755 $XENFORO_DIR;
    sudo chmod 0777 $XENFORO_DIR/data $XENFORO_DIR/internal_data
}

if [[ ! -f $XENFORO_ZIP ]]; then
    echo "xenforo.zip not present, please dowload from the account panel"
    exit;
fi

if [ -f "admin.php" ]; then
    echo "Xenforo 2 seems to already unpacked"
    echo "Do you wish to wipe and unpack xenforo?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) install; break;;
            No ) exit;;
        esac
    done
else
    install
fi
