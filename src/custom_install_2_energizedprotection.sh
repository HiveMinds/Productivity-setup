#!/bin/bash


# Checks if the unmodified social package is in the target file and export the true-false boolean as string to a file.
file_contains_unmodified_social_package() {

	# Hardcoded variables:
	# FILEPATH_UNPACKED_PACKAGE
	# FILEPATH_HOST
	# FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE
	
	# Input variables:
	# filepath_dummy_host----filepath_dummy_host
	
	# Relies on functions:
	# 0. Download  host gz (indirectly).
	# 1. Unpack (directly).

	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_1_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_1_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_1_energizedprotection.sh
	source ./src/custom_install_1_energizedprotection.sh $package_type $filepath_dummy_host
	
	# Read the downloaded and unmodified social package file content.
	local package_text=$(<"$FILEPATH_UNPACKED_PACKAGE")
	
	# Read the target file content to variable by default, read input file content to variable if it is not empty.
	if [ "$filepath_dummy_host" == "" ]; then
		local hostfile_text=$(<"$FILEPATH_HOST")
	else
		local hostfile_text=$(<"$filepath_dummy_host")
	fi
		
	# Check if the file content already contains the social package and store the boolean conclusion as a string.
	if [[ "$hostfile_text" == *"$package_text"* ]]; then
		local hostfile_contains_package=true
	else 
		local hostfile_contains_package=false
	fi
	
	# Write true or false to the log file belonging to this function, indicating if the target/input file already contains the social package.
	echo $hostfile_contains_package > "${FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE}"
}


# Ensures this script executes the function above.
file_contains_unmodified_social_package "$@"