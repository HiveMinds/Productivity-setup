#!/bin/bash
apt_remove_firefox_browser() {
	local LOG_PATH=$1
	
	while true; do
		read -p "Do you wish to remove firefox?(y/n)" yn
		case $yn in
		[Yy]* ) removal=$(sudo apt remove firefox); break;;
		[Nn]* ) echo ""; break;;
		* ) echo "Please answer yes or no." >&2;;
		esac
	done
	
	echo $removal > "${LOG_PATH}"
}
apt_remove_firefox_browser "$@"
