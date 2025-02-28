#!/bin/bash

DownloadsFolder="/config/Downloads"
if [ ! -d "$DownloadsFolder" ]; then
    mkdir -p $DownloadsFolder
fi

install_extract_xiso() {
    URL="https://github.com/XboxDev/extract-xiso"
    FOLDER="/config/Downloads/extract-xiso"
    buildFolder=$FOLDER/build

    # Clone the repository
    git clone $URL $FOLDER
    chown -R abc:users $FOLDER

    # Build the project
    mkdir $buildFolder
    cd $buildFolder
    cmake ..
    make
    
    cp $FOLDER/build/extract-xiso /usr/local/bin/extract-xiso
    chmod +x /usr/local/bin/extract-xiso
}

# Configure extract-xiso
if [ ! -f "/usr/local/bin/extract-xiso" ]; then
    if [ ! -f "/config/Downloads/extract-xiso/build/extract-xiso" ]; then
        install_extract_xiso
    else
        cp /config/Downloads/extract-xiso/build/extract-xiso /usr/local/bin/extract-xiso
        chmod +x /usr/local/bin/extract-xiso
    fi
fi
