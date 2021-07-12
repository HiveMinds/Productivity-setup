#!/bin/bash


# If a modified social package is found in the input path, remove it. (If the unmodified package is in the file, it stays there).
remove_modified_social_package() {

	# Hardcoded variables:
	# FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE
	# FILEPATH_HOSTFILE_CONTAINS_MODIFIED_PACKAGE
	# FILEPATH_PACKAGE_INDICATOR_LINE_NR
	# OFFSET_PACKAGE_INDICATOR_LINE
	# TODO: compute offset automatically to make it package independent
	# FILEPATH_LINE_NR_PACKAGE_END_IN_HOSTFILE
	# FILEPATH_HOST_AFTER_MODIFIED_PACKAGE_REMOVAL
	
	# Input variables:
	# filepath_dummy_host
	
	# Relies on functions:
	# 2
	# 3
	# 8
	# 9
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_9_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_9_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_9_energizedprotection.sh
	source ./src/custom_install_9_energizedprotection.sh $package_type $filepath_dummy_host
	
	if [ "$package_type" == "social" ]; then
		local offset_package_indicator_line="$OFFSET_SOCIAL_PACKAGE_INDICATOR_LINE"
	elif [ "$package_type" == "porn" ]; then
		local offset_package_indicator_line="$OFFSET_PORN_PACKAGE_INDICATOR_LINE"
	elif [ "$package_type" == "additional" ]; then
		local offset_package_indicator_line="$OFFSET_ADDITIONAL_PACKAGE_INDICATOR_LINE"
	fi
	
	# Read if the target file contains the social package.
	target_contains_social_package=$(<"$FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE")
	
	# Read if the target file contains the modified social package.
	target_contains_modified_social_package=$(<"$FILEPATH_HOSTFILE_CONTAINS_MODIFIED_PACKAGE")
	
	# Check if an input file contains a modified social package.
	if [ "$target_contains_social_package" == "false" ] && [ "$target_contains_modified_social_package" == "true" ]; then
		
		# Get starting line line nr of the social package.
		start_line_nr=$(<"$FILEPATH_PACKAGE_INDICATOR_LINE_NR")
		
		# Check if the starting line nr is found, and whether the starting line nr offset (w.r.t. the
		# start of the social package) is found.
		if [ "$start_line_nr" != "" ] && [ "$offset_package_indicator_line" != "" ]; then
		
			# Compute the line in an input file at which the social package starts (= not starting line of social package).
			abs_start_line_nr="$((start_line_nr-offset_package_indicator_line))"
		
			# Compute the line in an input file  at which the social package ends.
			abs_end_line_nr=$(<"$FILEPATH_LINE_NR_PACKAGE_END_IN_HOSTFILE")
			
			# Create a separate file that has the modified social pack cut out of it.
			sed "${abs_start_line_nr},${abs_end_line_nr}d" "$filepath_dummy_host" > "$FILEPATH_HOST_AFTER_MODIFIED_PACKAGE_REMOVAL"
			
			# Copy the cut file back over the original input file.
			cp "$FILEPATH_HOST_AFTER_MODIFIED_PACKAGE_REMOVAL" "$filepath_dummy_host"
			
		fi
		
	fi
}


# Ensures this script executes the function above.
remove_modified_social_package "$@"