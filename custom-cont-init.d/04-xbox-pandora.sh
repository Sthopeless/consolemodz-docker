#!/bin/bash

DownloadsFolder="/config/Downloads"
if [ ! -d "$DownloadsFolder" ]; then
    mkdir -p $DownloadsFolder
fi

download_pandora() {
    repo="https://github.com/Team-Resurgent/Pandora"
    latest_release_url=$(curl -s "https://api.github.com/repos/${repo#*github.com/}/releases/latest" | jq -r '.assets[] | select(.name | contains("linux")) | .browser_download_url')
    wget -P "$DownloadsFolder" "$latest_release_url"
    for file in "$DownloadsFolder"/*Pandora*; do
        extract_folder="$DownloadsFolder/pandora"
        mkdir -p "$extract_folder"
        7z x "$file" -o"$extract_folder"
        chown -R abc:users "$extract_folder"
        rm -rf "$file"
        ln -sf "$extract_folder/pandora" "/config/Desktop/pandora"
    done
}

# Download and configure Pandora
if [ ! -f "/config/Desktop/pandora" ]; then
    if [ ! -f "/config/Downloads/pandora/pandora" ]; then
        download_pandora
    else
        ln -sf "/config/Downloads/pandora/pandora" "/config/Desktop/pandora"
    fi
fi
