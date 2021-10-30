#!/bin/bash

sudo mkdir -p src/submodules/zotero
# 1. Clone the Zotero source code, Zotero XPI build scripts, and standalone client build scripts:
git clone --recursive https://github.com/zotero/zotero "src/submodules/zotero/zotero-client"
git clone --recursive https://github.com/zotero/zotero-build "src/submodules/zotero/zotero-build"
git clone --recursive https://github.com/zotero/zotero-standalone-build "src/submodules/zotero/zotero-standalone-build"


# 2. Change to the source code repo and install Node.js modules using Node 8 or later:
cd "src/submodules/zotero/zotero-client"
npm i


# 3. Run the JS build process (Babel, etc.):
npm run build
# This will compile source files into a build/ directory. You can also run npm start to automatically rebuild as you change files, but it may be simpler to run npm run build in a single line with dir_build below.


# 4. Change to the zotero-standalone-build directory and check your system for the necessary tools:
cd ../zotero-standalone-build

# 4.5 Install some prerequisites before the checker.
# Install mozilla archive tools:
./fetch_mar_tools

# Install python 3.6 to install aws:
yes | sudo apt-get update
yes | sudo apt-get install python3.6

# Install aws:
# Source: https://linuxhint.com/install_aws_cli_ubuntu/
yes | sudo apt-get install awscli

scripts/check_requirements
# This script checks all requirements for the official Zotero distribution system. If you're only creating a custom build, you only need the build requirements listed at the top, not the distribution requirements.


# 5. Download the Firefox runtime and PDF tools for the desired platform(s) (m=Mac, w=Windows, l=Linux):
# TODO: determine OS and change the l(L) to m for Mac, w for Windows.
./fetch_xulrunner.sh -p l
#This will download Firefox runtime files to the xulrunner/ subdirectory and modify them for use with Zotero.
#Note: Due to the way Firefox is packaged, fetch_xulrunner.sh can retrieve Mac builds only on macOS.


# 6. Download the modified Poppler PDF tools that are bundled with Zotero:
./fetch_pdftools


# 7. Build Zotero:
scripts/dir_build


# 8. Run the Zotero build (From: .../zotero-standalone-build/)
#staging/Zotero_linux-x86_64/zotero

# Source: https://forums.zotero.org/discussion/72795/unable-to-launch-zotero-5-on-ubuntu-16-04-error-involves-libgtk-3
#sudo apt install libgtk2.0-0
# sudo apt-get install --reinstall libgtk2.0-0
# sudo apt-get install --reinstall libgtk-3-0

# Source: https://forums.zotero.org/discussion/78784/cant-start-zotero-at-all
#sudo apt install mlocate
#locate libgtk-x11
# Source: https://askubuntu.com/questions/836142/error-while-loading-shared-libraries-libgtk-x11-2-0-so-0-no-such-file-or-direc/836144#836144
#sudo apt install libgtk2.0-0:i386
#staging/Zotero_linux-i686/zotero

# Note: changed:
#for arch in "i686" "x86_64"; do
# to:
#for arch in "x86_64"; do
# in build.sh
# and ran with:
#staging/Zotero_linux-x86_64/zotero
# WORKS!
timeout 20s staging/Zotero_linux-x86_64/zotero
cd ../../../../
echo "PWD=$PWD"