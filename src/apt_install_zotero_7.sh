#!/bin/bash
apt_install_zotero_7() {
	local LOG_PATH=$1
	
	# Create a directory in which the Zotero add-on repository can be stored
	mkdir -p src/submodules/zotero
	
	# Get the add-on source code.
	#git clone https://github.com/ethanwillis/zotero-scihub.git "src/submodules/zotero/zotero-scihub"
	git clone git@github.com:MohamedElashri/zotero-scihub-1.git "src/submodules/zotero/zotero-scihub"
	
	# Ensure the npm module is installed such that you can build the add-on from its source code.
	yes | sudo apt install npm
	
	# Go into the add-on source code and build the add-on.
	cd "src/submodules/zotero/zotero-scihub" && npm install
	npm run build
	
	# Go into the build output folder
	cd xpi
	
	# TODO: assert file exists
	
	# Rename the output file to a default add-on filename.
	mv "$PWD"/zotero*.xpi "$PWD"/"zotero-scihub-add-on.xpi"
	
	# get out of the builded directory and back to the root of this repository.
	cd ../../../../..
	echo "DONEPWD=$PWD"
	
}
apt_install_zotero_7 "$@"
