#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	#update=$(yes | sudo apt install -y anki) requires user action
	update=$(yes | sudo snap install anki-woodrow)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
