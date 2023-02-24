#!/bin/bash
source src/helper.sh

# Changes the default application with which a file is opened.
change_default_opening_application() {
	local file_extension
	file_extension="$1"
	local program_name
	program_name="$2"
	local LOG_PATH="$3"
		
	local x_extension
	x_extension=$(extension_to_mimeapps_extension "$file_extension")
	local application_type
	application_type=$(extension_to_mimeapps_application_type "$file_extension")
	local x_program_name

	x_program_name=$(program_name_to_mimeapps_program_name "$program_name")

	#Source: https://askubuntu.com/questions/1030281/change-default-applications-from-script
	# test if file exists
	local default_application_config_filepath
	default_application_config_filepath="/home/$(whoami)/.config/mimeapps.list"
	if [[ -f "$default_application_config_filepath" ]]; then
	    
		# Check if the file contains the application/x-xpinstall line
		if [[ "$(file_contains_string "$x_extension" "$default_application_config_filepath")" == "FOUND" ]]; then
			line_nr=$(get_line_nr "${x_extension}" $default_application_config_filepath)
			replace_line_in_file_with_string "$line_nr" "$default_application_config_filepath" "$application_type/$x_extension=$x_program_name;"
		else
			echo "$application_type/$x_extension=$program_name;" >> "$default_application_config_filepath"
		fi
	else
		echo "ERROR: did not find the file that contains the default applciations to open various file types/extensions."
		exit
		# TODO: use find function to find the file if it is not found at the default location.
		# sudo find / -name "mimeapps.list"
	fi
	
	# TODO: assert mimeapps list contains expected content/line.
}


extension_to_mimeapps_application_type() {
	local file_extension
	file_extension="$1"

	if [[ "$file_extension" == "yml" ]] || [[ "$file_extension" == "yaml" ]]; then
		echo "application"
	elif [[ "$file_extension" == "xpi" ]]; then
		echo "application"
	elif [[ "$file_extension" == "txt" ]]; then
		echo "text"
	else
		echo "Error, do not yet know x-code for file extension:$file_extension"
		exit 6
	fi
}

extension_to_mimeapps_extension() {
	local file_extension
	file_extension="$1"

	if [[ "$file_extension" == "yml" ]] || [[ "$file_extension" == "yaml" ]]; then
		echo "x-yaml"
	elif [[ "$file_extension" == "xpi" ]]; then
		echo "x-xpinstall"
	elif [[ "$file_extension" == "txt" ]]; then
		echo """plain"""
	else
		echo "Error, do not yet know x-code for file extension:$file_extension"
		exit 6
	fi
}

program_name_to_mimeapps_program_name() {
	local program_name
	program_name="$1"

	if [[ "$program_name" == "gedit" ]]; then
		echo "org.gnome.gedit.desktop"
	elif [[ "$program_name" == "vscode" ]]; then
		echo "vscode"
	else
		echo "Error, do not yet know x-code for program_name:$program_name"
		exit 6
	fi
}
# change_default_opening_application "$@"

