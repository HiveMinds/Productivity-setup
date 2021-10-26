#!/bin/bash
apt_install_zotero() {
	local LOG_PATH=$1
	installation_log=$(yes | sudo apt install zotero)
	echo $installation_log > "${LOG_PATH}"
}
apt_install_zotero "$@"
