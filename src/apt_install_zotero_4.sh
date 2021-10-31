#!/bin/bash
# Make some key accessible
modify_keyfile_permission() {
	local LOG_PATH=$1
	sudo chmod 644 /etc/apt/trusted.gpg.d/zotero.gpg
}
modify_keyfile_permission "$@"