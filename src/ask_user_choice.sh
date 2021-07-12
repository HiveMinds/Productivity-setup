#!/bin/bash
source src/hardcoded_variables.txt
read_categories() {
	data_source=$1
	if [[ $data_source == "selected" ]]; then
		echo $(awk '/installationType:/ {print $2}' $SELECTED_SOFTWARE_LIST_LOCATION)
	fi
	if [[ $data_source == "supported" ]]; then
		echo $(awk '/installationType:/ {print $2}' $SUPPORTED_SOFTWARE_LIST_LOCATION)
	fi
	
}


read_software_packages() {
	data_source=$1
	
	# get all supported installation categories
	installation_types=($(read_categories $data_source)) # outer brackets to convert string to list
	
	software_packages=""
	for i in "${!installation_types[@]}"; do
	    software_packages+=$(read_software_packages_per_category $data_source "${installation_types[i]}")" "
	done
	echo $software_packages
}

read_software_packages_per_category() {
	data_source=$1
	installation_type=$2
	
	if [ $data_source == "selected" ]; then
		echo $(awk '/'$installation_type':/ {print $2}' $SELECTED_SOFTWARE_LIST_LOCATION)
	fi
	if [ $data_source == "supported" ]; then
		echo $(awk '/'$installation_type':/ {print $2}' $SUPPORTED_SOFTWARE_LIST_LOCATION)
	fi
}

prompt_user_choice() {
	# determine whether the user is installing or uninstalling
	activity=$1
	shift # eat first argument
	
	# read incoming list of installation types that are tested
	installation_types=("$@")
	
	# clear output log
	source src/helper.sh
	$(remove_log_file $SELECTED_SOFTWARE_FILENAME)
	
	# create output log file
	$(create_log_file $SELECTED_SOFTWARE_FILENAME $LOG_LOCATION)
	
	# initialise lists of softwares that are evaluated
	supported_software_packages=""
	selected_software_packages=""
	
	# loop through each installation type
	for i in "${!installation_types[@]}"; do

		# Append the installation type to the user selection log
		echo "installationType: ${installation_types[i]}" >> $LOG_LOCATION$SELECTED_SOFTWARE_FILENAME
		
		# read the possible software packages per installation type
		new_software=$(read_software_packages_per_category "supported" "${installation_types[i]}")
		
		# Convert software packages from string to list
		new_software_list=($new_software)
		
		# Loop through list of software packages
		for j in "${!new_software_list[@]}"; do
		
			# Ask the user if they want to install this software package
			user_input=$(ask_if_user_wants_some_software_package $activity ${new_software_list[j]})
			
			# add the software package to the list or not, depending on user choice
			if [ $(echo -n $user_input | tail -c 4) == true ]; then
				
				# add the software package to the variable list
		    		selected_software_packages+=${new_software_list[j]}" "
		    		
		    		# add the software package to the user selection log
		    		echo "${installation_types[i]}: "${new_software_list[j]} >> $LOG_LOCATION$SELECTED_SOFTWARE_FILENAME
	    		fi
    		done
	done
	
	echo "The selected software packages are:"
	echo $selected_software_packages
	
	# TODO: ask verification of correctness of list to user.
}

ask_if_user_wants_some_software_package() {
	activity=$1
	software_package=$2
	if [ ${#software_package} -ge 1 ]; then
		while true; do
			if [ "$activity" == "install" ]; then
				read -p "Do you wish to install: $software_package?" yn
			elif [ "$activity" == "uninstall" ]; then
				read -p "Do you wish to uninstall: $software_package?" yn
		    fi
		    case $yn in
			[Yy]* ) echo "true"; break;;
			[Nn]* ) echo "false"; break;;
			* ) echo "Please answer yes or no.";;
		    esac
		done
	else
		echo "false"
	fi
}
