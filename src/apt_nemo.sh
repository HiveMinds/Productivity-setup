#!/bin/bash
install_nemo() {
	local LOG_PATH=$1
	installation_output=$(yes | sudo apt install nemo)
	#echo $installation_output > "${LOG_PATH}"

	# Always show hidden folders.
	gsettings set org.nemo.desktop show-desktop-icons true
	
	# Set the dark theme
	gsettings set org.gnome.desktop.interface gtk-theme Yaru-dark
	gsettings set org.gnome.desktop.interface cursor-theme Yaru-dark
	
	gsettings set org.nemo.icon-view captions "['size', 'type', 'date_accessed', 'date_modified']"
	
	# Also show files in the side panel of the file explorer
	#gsettings set org.nemo.sidebar-panels.tree show-only-directories false

}
install_nemo "$@"
