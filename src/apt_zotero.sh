#!/bin/bash

source src/change_default_opening_application.sh

# Declare filenames of files that perform commands to install nordvpn
install_zotero() {
	
	# Source: https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-Raspberry-Pi-Elementary-OS-and-Linux-Mint.htm
	
	# Declare filenames of files that perform commands
	declare -a arr=(
		"custom_uninstall_zotero"
		#"apt_install_zotero_0" # wget curl installation
		#"apt_install_zotero_1" # check has root privilige
		#"apt_install_zotero_2" # architecture check
		#"apt_install_zotero_3" # specify keyring
		#"apt_install_zotero_4" # modify key
		#"apt_install_zotero_5" # eof reading
		"apt_0_update"
		#"apt_install_zotero_6" # installs apt zotero
		"apt_install_zotero_7" # Get and compile addon
		"apt_install_zotero_source"
		#"change_default_opening_application" # of xpi file with zotero
		#"apt_install_zotero_8" # opens addon .xpi
		#"apt_install_zotero_9" # export xpi file of addon to extension dir
		#"apt_install_zotero_10" # removes line from prefs.js
		#"apt_install_zotero_11" # removes line from prefs.js
		#"apt_install_zotero_12" # adds the addon to extensions.json
		"apt_install_zotero_13" # run the application for the first time
		# run zotero
		"apt_install_zotero_14" # set Zotero as a default application
		# TODO: detect if libreoffice is installed, and if yes, install the libreoffice plugin
		# TODO: detect if libreoffice is being installed, and if yes, do that first.
		# TODO: detect if brave is installed, and if yes, install the brave plugin
		# TODO: detect if brave is being installed, and if yes, install the brave plugin
		# TODO: specify pdf storage location
	)
	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
		echo "i=$i"
	done
}

test_zotero() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_zotero_postsetup.bats
}
