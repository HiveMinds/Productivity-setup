#!/bin/bash


# Count the total nr of lines in an incoming file and export it.
count_nr_of_lines() {

	# Hardcoded variables:
	# filepath_dummy_host----filepath_dummy_host
	# FILEPATH_NR_LINES_HOSTFILE
	
	# Input variables:
	# None
	
	# Relies on functions:
	# None
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_3_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_3_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_3_energizedprotection.sh
	source ./src/custom_install_3_energizedprotection.sh $package_type $filepath_dummy_host
	
	# Throw an error with exit status 1 if the file does not exist.
	if [ ! -f "$filepath_dummy_host" ] ; then
	    exit 1
	fi
	
	# Read content from the input file.
	local hostfile_text=$(<"$filepath_dummy_host")
	
	# Count the number of lines in that file.
	local nr_lines_hostfile=$(echo "$hostfile_text" | wc -l)
	
	# Write the result of the content check to a log file.
	echo "$nr_lines_hostfile" > "${FILEPATH_NR_LINES_HOSTFILE}"
}


# Ensures this script executes the function above.
count_nr_of_lines "$@"