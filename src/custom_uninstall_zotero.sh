#!/bin/bash
# Source; https://docs.anaconda.com/anaconda/install/uninstall/
custom_uninstall() {
	local LOG_PATH=$1
	
	# TODO: detect whether database exists within the previous Zotero installation, if existant.
	# TODO: include prompt user with question whether previous Zotero installation database should be preserved.
	# TODO: ask if previous Zotero database should be restored.
	
	sudo rm -r "/home/$(whoami)/.zotero"
	sudo rm -r "/home/$(whoami)/Zotero"
	sudo rm -r "src/submodules/zotero"
}
custom_uninstall "$@"
