#!/bin/bash
source src/hardcoded_variables.txt

source src/apt_autokey_gtk.sh
source src/apt_github.sh
source src/apt_brave.sh
source src/apt_keepass2.sh
source src/apt_nordvpn.sh
source src/apt_openvpn3.sh
source src/apt_privoxy.sh
source src/apt_signal.sh
source src/apt_searchmonkey.sh
source src/apt_texlive_xetex.sh
source src/apt_texmaker.sh
source src/apt_wine.sh
source src/apt_zotero.sh
source src/snap_anki.sh
source src/snap_notepad_plus_plus.sh
source src/custom_anaconda.sh
source src/custom_install_energizedprotection.sh
source src/custom_language_tool.sh

install_user_choices() {
	selected_software_packages=($(read_software_packages "selected")) # outer brackets to store as list
	
	# loop through selected packages
	for i in "${!selected_software_packages[@]}"; do
		if [ "${selected_software_packages[i]}" == anaconda ]; then
			$(install_anaconda) # install user choice: anaconda
		elif [ "${selected_software_packages[i]}" == anki ]; then
			$(install_anki) # install user choice: anki
		elif [ "${selected_software_packages[i]}" == autokey-gtk ]; then
			$(install_autokey_gtk) # install user choice: autokey_gtk
		elif [ "${selected_software_packages[i]}" == brave ]; then
			$(install_brave) # install user choice: brave
		elif [ "${selected_software_packages[i]}" == energizedprotection_social ]; then
			$(install_energizedprotection social) # install user choice: energizedprotection social package
		elif [ "${selected_software_packages[i]}" == energizedprotection_porn ]; then
			$(install_energizedprotection porn) # install user choice: energizedprotection porn package
		elif [ "${selected_software_packages[i]}" == energizedprotection_additional ]; then
			$(install_energizedprotection additional) # install user choice: energizedprotection porn package
		elif [ "${selected_software_packages[i]}" == github ]; then
			$(install_github) # install user choice: github
		elif [ "${selected_software_packages[i]}" == keepass2 ]; then
			$(install_keepass2) # install user choice: keepass2
		elif [ "${selected_software_packages[i]}" == language_tool ]; then
			$(install_language_tool) # install user choice: wine
		elif [ "${selected_software_packages[i]}" == nordvpn ]; then
			$(install_nordvpn) # install user choice: nordvpn
		elif [ "${selected_software_packages[i]}" == notepad++ ]; then
			$(install_notepad_plus_plus) # install user choice: notepad_plus_plus
		elif [ "${selected_software_packages[i]}" == openvpn3 ]; then
			$(install_openvpn3) # install user choice: openvpn3
		elif [ "${selected_software_packages[i]}" == privoxy ]; then
			$(install_privoxy) # install user choice: privoxy
		elif [ "${selected_software_packages[i]}" == searchmonkey ]; then
			$(install_searchmonkey) # install user choice: searchmonkey
		elif [ "${selected_software_packages[i]}" == signal ]; then
			$(install_signal) # install user choice: signal
		elif [ "${selected_software_packages[i]}" == texlive-xetex ]; then
			$(install_texlive_xetex) # install user choice: texlive_xetex
		elif [ "${selected_software_packages[i]}" == texmaker ]; then
			$(install_texmaker) # install user choice: texmaker
		elif [ "${selected_software_packages[i]}" == wine ]; then
			$(install_wine) # install user choice: wine
		elif [ "${selected_software_packages[i]}" == zotero ]; then
			$(install_zotero) # install user choice: zotero
		fi
	done
}

test_user_choice_installation() {
	selected_software_packages=($(read_software_packages "selected")) # outer brackets to store as list
	
	# loop through selected packages
	for i in "${!selected_software_packages[@]}"; do
		if [ "${selected_software_packages[i]}" == anaconda ]; then
			test_anaconda
		elif [ "${selected_software_packages[i]}" == anki ]; then
			test_anki
		elif [ "${selected_software_packages[i]}" == autokey-gtk ]; then
			test_autokey_gtk
		elif [ "${selected_software_packages[i]}" == energizedprotection_social ]; then
			test_energizedprotection social
		elif [ "${selected_software_packages[i]}" == energizedprotection_porn ]; then
			test_energizedprotection porn
		elif [ "${selected_software_packages[i]}" == energizedprotection_additional ]; then
			test_energizedprotection additional
		elif [ "${selected_software_packages[i]}" == github ]; then
			test_github
		elif [ "${selected_software_packages[i]}" == keepass2 ]; then
			test_keepass2
		elif [ "${selected_software_packages[i]}" == notepad++ ]; then
			test_notepad_plus_plus
		elif [ "${selected_software_packages[i]}" == openvpn3 ]; then
			test_openvpn3
		elif [ "${selected_software_packages[i]}" == privoxy ]; then
			test_privoxy
		elif [ "${selected_software_packages[i]}" == searchmonkey ]; then
			test_searchmonkey
		elif [ "${selected_software_packages[i]}" == signal ]; then
			test_signal
		elif [ "${selected_software_packages[i]}" == texlive-xetex ]; then
			test_texlive_xetex
		elif [ "${selected_software_packages[i]}" == texmaker ]; then
			test_texmaker
		elif [ "${selected_software_packages[i]}" == wine ]; then
			test_wine
		elif [ "${selected_software_packages[i]}" == zotero ]; then
			test_zotero
		fi
		
	done
}
