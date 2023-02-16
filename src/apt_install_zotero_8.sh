#!/bin/bash
apt_install_zotero_8() {
	local LOG_PATH=$1
	
	# TODO: assert file exists
	#zotero "src/submodules/zotero-scihub-1.3.0.xpi"
	xdg-open "src/submodules/zotero-scihub/xpi/*.xpi"
}
apt_install_zotero_8 "$@"
