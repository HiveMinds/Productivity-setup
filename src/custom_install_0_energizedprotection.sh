#!/bin/bash


# Downloads the social package with wget.
download_social_package() {
	
	# Hardcoded variables:
	# LOGFILE_PATH_0
	# TODO:  PACKAGE_GZ_LINK----local url_to_package_gz
	
	# Input variables:
	# social package 
	
	# Relies on functions:
	# None.
	
	local package_type=$1
	
	if [ "$package_type" == "social" ]; then
		local url_package_gz=$URL_SOCIAL_PACKAGE_GZ
	elif [ "$package_type" == "porn" ]; then
		local url_package_gz=$URL_PORN_PACKAGE_GZ
	elif [ "$package_type" == "additional" ]; then
		local url_package_gz=$URL_ADDITIONAL_PACKAGE_GZ
	fi
	
	local filepath_downloaded_package_gz=$FILEPATH_DOWNLOADED_PACKAGE_GZ
	
	# Execute the command to download the package and store the log output in a variable.
	local wget_command_log_output=$(wget --no-check-certificate -O "$filepath_downloaded_package_gz" "$url_package_gz")
	
	# Export the wget_command_log_output to a log file.
	echo "$wget_command_log_output" > "${LOGFILE_PATH_0}"
}


# Ensures this script executes the function above.
download_social_package "$@"