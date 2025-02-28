#!/bin/bash

URL="https://github.com/al3xtjames/PS3Dec"
FOLDER="/config/Downloads/ps3dec"
buildFolder="$FOLDER/build"

# Check if already cloned
if [ -d "$FOLDER" ]; then
    if [ -f "/usr/local/bin/ps3dec" ]; then
        exit 1
    else
        if [ -f "$buildFolder/Release/PS3Dec" ]; then
            cp $buildFolder/Release/PS3Dec /usr/local/bin/ps3dec
            chmod +x /usr/local/bin/ps3dec
            exit 1
        else
            git clone --recurse-submodules $URL $FOLDER
            mkdir -p $buildFolder
            cd $buildFolder
            cmake -G Ninja ..
            ninja
            cp $buildFolder/Release/PS3Dec /usr/local/bin/ps3dec
            chmod +x /usr/local/bin/ps3dec
            exit 1
        fi
    fi
fi

# Clone the repository
git clone --recurse-submodules $URL $FOLDER

# Build the project
mkdir -p $buildFolder
cd $buildFolder
cmake -G Ninja ..
ninja

cp $FOLDER/build/Release/PS3Dec /usr/local/bin/ps3dec
chmod +x /usr/local/bin/ps3dec
