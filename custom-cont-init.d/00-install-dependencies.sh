#!/bin/bash

DEPENDENCIES=(
  "git"
  "cmake"
  "ninja-build"
  "build-essential"
  "wget"
  "jq"
  "p7zip-full"
  "p7zip-rar"
)

# Install dependencies
apt update
apt upgrade -y
apt install -y "${DEPENDENCIES[@]}"
