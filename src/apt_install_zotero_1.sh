#!/bin/bash
apt_install_zotero_1() {
	local LOG_PATH=$1
	installation_log=$(yes | sudo apt install zotero)
	echo $installation_log > "${LOG_PATH}"
}
apt_install_zotero_1 "$@"
