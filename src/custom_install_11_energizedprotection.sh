#!/bin/bash


# Appends the new social pack if the unmodified social package is not yet included.
append_new_social_package_to_host_file() {

	# Hardcoded variables:
	# FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE
	# FILEPATH_UNPACKED_PACKAGE
	
	# Input variables:
	# filepath_dummy_host
	
	# Relies on functions:
	# 2
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_10_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_10_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_10_energizedprotection.sh
	source ./src/custom_install_10_energizedprotection.sh $package_type $filepath_dummy_host
	
	# Receive a filepath to which the newly downloaded social package is appended if it is not already included.
	local filepath_dummy_host=$2
	
	# Read input/target file content from file into variable.
	target_contains_unmodified_social_package=$(<"$FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE")
	
	# Check if the input/target file already contains the social package. If not, it may have previously contained the
	# modified social package, but that has already been deleted from the input/target file if it was contained.
	if [ "$target_contains_unmodified_social_package" == "false" ]; then
		
		# make target writable
		sudo chmod 777 $filepath_dummy_host
		
		# Append the new social package to the input/target file variable.
		sudo cat "$FILEPATH_UNPACKED_PACKAGE" >> "${filepath_dummy_host}"
		
	fi

	# Ensure the hostfile becomes immutable.
	# sudo chattr +i /etc/hosts

}


# Ensures this script executes the function above.
append_new_social_package_to_host_file "$@"