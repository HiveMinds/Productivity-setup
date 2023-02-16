#!/bin/bash
# Get a list of files (that the zotero installation presumably uses).
cat << EOF | sudo tee /etc/apt/sources.list.d/zotero.list
deb https://github.com/retorquere/zotero-deb/releases/download/apt-get/ ./
EOF