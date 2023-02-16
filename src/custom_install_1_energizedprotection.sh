#!/bin/bash


# Unpacks the downloaded social package zip to a file.
unpack_zip_file_of_social_package() {

	# Hardcoded variables:
	# LOGFILE_PATH_1
	# FILEPATH_DOWNLOADED_PACKAGE_GZ
	# FILEPATH_UNPACKED_PACKAGE
	
	# Input variables:
	# social package
	
	# Relies on functions:
	# 0. Download host gz (directly).
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_0_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_0_energizedprotection"".txt"
	fi
	
	chmod +x ./src/custom_install_0_energizedprotection.sh
	source ./src/custom_install_0_energizedprotection.sh $package_type $filepath_dummy_host
	
	# Execute the command to unpack the package gz file and store the log output in a variable.
	local unpack_command_log_output=$(gzip -d -c "$FILEPATH_DOWNLOADED_PACKAGE_GZ" > "$FILEPATH_UNPACKED_PACKAGE")
	
	# Export the unpack_command_log_output to a log file.
	echo "$unpack_command_log_output" > "${LOGFILE_PATH_1}"
}


# Ensures this script executes the function above.
unpack_zip_file_of_social_package "$@"