#!/bin/bash

DownloadsFolder="/config/Downloads"
if [ ! -d "$DownloadsFolder" ]; then
    mkdir -p $DownloadsFolder
fi

download_cerbiostool() {
    repo="https://github.com/Team-Resurgent/CerbiosTool"
    latest_release_url=$(curl -s "https://api.github.com/repos/${repo#*github.com/}/releases/latest" | jq -r '.assets[] | select(.name | contains("linux")) | .browser_download_url')
    wget -P "$DownloadsFolder" "$latest_release_url"
    for file in "$DownloadsFolder"/*CerbiosTool*; do
        extract_folder="$DownloadsFolder/cerbiostool"
        mkdir -p "$extract_folder"
        7z x "$file" -o"$extract_folder"
        chown -R abc:users "$extract_folder"
        rm -rf "$file"
        ln -sf "$extract_folder/cerbiostool" "/config/Desktop/cerbiostool"
    done
}

# Download and configure CerbiosTool
if [ ! -f "/config/Desktop/cerbiostool" ]; then
    if [ ! -f "/config/Downloads/cerbiostool/cerbiostool" ]; then
        download_cerbiostool
    else
        ln -sf "/config/Downloads/cerbiostool/cerbiostool" "/config/Desktop/cerbiostool"
    fi
fi
