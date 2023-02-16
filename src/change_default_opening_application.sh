#!/bin/bash
source src/helper.sh

# Changes the default application with which a file is opened.
change_default_opening_application() {
	local LOG_PATH=$1
		
	#Source: https://askubuntu.com/questions/1030281/change-default-applications-from-script
	# test if file exists
	default_application_config_filepath="/home/$(whoami)/.config/mimeapps.list"
	if [ -f "$default_application_config_filepath" ] ; then
	    
		# Check if the file contains the application/x-xpinstall line
		substring="x-xpinstall"
		if [ "$(file_contains_string "$substring" "$default_application_config_filepath")" == "FOUND" ]; then
			# If yes, get the line number
			
			line_nr=$(get_line_nr "\${substring}" $default_application_config_filepath)
			
			# Replace that line number with:
			#application/x-xpinstall=zotero.desktop;
			replace_line_in_file_with_string "$line_nr" "$default_application_config_filepath" "application/x-xpinstall=zotero.desktop;"
		else
			
			#If no, append the line:
			#application/x-xpinstall=zotero.desktop;
			echo "application/x-xpinstall=zotero.desktop;" >> "$default_application_config_filepath"
			echo "File found but the line was not found. Appended the line"
		fi
	else
		echo "ERROR: did not find the file that contains the default applciations to open various file types/extensions."
		exit
		# TODO: use find function to find the file if it is not found at the default location.
		# sudo find / -name "mimeapps.list"
	fi
	
}
change_default_opening_application "$@"
