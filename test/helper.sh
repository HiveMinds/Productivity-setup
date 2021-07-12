#!/bin/bash

hardcode_user1_choice_example() {
	for i in "${!INSTALLATION_TYPES[@]}"; do
		# Append the installation type to the user selection log
		echo "installationType: ${INSTALLATION_TYPES[i]}" >> $LOG_LOCATION$SELECTED_SOFTWARE_FILENAME
		if [ "${INSTALLATION_TYPES[i]}" == apt ]; then
			write_package_to_selected_software_log "${INSTALLATION_TYPES[i]}" "${USER1_APT_PACKAGES[@]}"
		fi
		if [ "${INSTALLATION_TYPES[i]}" == snap ]; then
			write_package_to_selected_software_log "${INSTALLATION_TYPES[i]}" "${USER1_SNAP_PACKAGES[@]}"
		fi
		if [ "${INSTALLATION_TYPES[i]}" == custom ]; then
			write_package_to_selected_software_log "${INSTALLATION_TYPES[i]}" "${USER1_CUSTOM_PACKAGES[@]}"
		fi
		if [ "${INSTALLATION_TYPES[i]}" == needUserInput ]; then
			write_package_to_selected_software_log "${INSTALLATION_TYPES[i]}" "${USER1_NEEDUSERINPUT_PACKAGES[@]}"
		fi
		if [ "${INSTALLATION_TYPES[i]}" == deviceDependent ]; then
			write_package_to_selected_software_log "${INSTALLATION_TYPES[i]}" "${USER1_DEVICEDEPENDENT_PACKAGES[@]}"
		fi
	done
}

# Create user that installs all supported options
create_greedy_user() {
	cp $SUPPORTED_SOFTWARE_LIST_LOCATION $SELECTED_SOFTWARE_LIST_LOCATION
}

write_package_to_selected_software_log() {
	installation_type=$1
	shift # eat first argument
	packages=("$@")
	#echo "packages"
	#echo $packages
	# Loop through list of apt installations
	for j in "${!packages[@]}"; do
		#echo "package"
		#echo "${packages[j]}"
		# add the software package to the user selection log
		echo "$installation_type: "${packages[j]} >> $LOG_LOCATION$SELECTED_SOFTWARE_FILENAME
	done
}

# Makes the main script runnable, removes the log file and runs main file.
actual_result_has_any_allowed_result_in_tail() {
	# declare default function output
	test_result=false
	
	# get the actual result
	actual_result=$1
	shift # Shift all arguments to the left (original $1 gets lost)
	
	# get the list of allowed results and list size
	allowed_results=("$@") 
	list_size=${#allowed_results}

	# Only engage this function if the list size is greater than 1
	if [ $list_size -gt 1 ]; then echo "error";
	
		# if the actual result is in the acceptable list ensure function returns true
		for allowed_result in "${allowed_results[@]}"
		do
			if [ $test_result != true ]; then
				# compute lengths of result strings
				allowed_result_size=${#allowed_result}
				actual_result_size=${#actual_result}
				
				# TODO: remove this if condition and directly go to Else by switching lt to ge
				if [ $actual_result_size -lt $allowed_result_size ]; then echo "error";
					echo "The actual size is:"
					echo $actual_result_size
					echo "WHEREAS allowed_result_size=" 
					echo $allowed_result_size
					echo "so actual is smaller than allowed, so do nothing"
				else 
					# test if left string is in the tail of the allowed result string
					# TODO: include contains option in separate function
					temp_test_result=$(right_is_in_tail_of_left "$actual_result" "$allowed_result");
					if [ $(echo -n $temp_test_result | tail -c 4) == true ]; then
						test_result=true
					fi
				fi
			fi
		done
	fi
		
	# Ensure the last 4/5 characters of the output of this function contains the true false evaluation.
	echo $test_result
}

actual_result_has_any_allowed_result_in_head() {
	# declare default function output
	test_result=false
	
	# get the actual result
	actual_result=$1
	shift # Shift all arguments to the left (original $1 gets lost)
	
	# get the list of allowed results and list size
	allowed_results=("$@") 
	list_size=${#allowed_results}

	# Only engage this function if the list size is greater than 1
	if [ $list_size -gt 1 ]; then echo "error";
	
		# if the actual result is in the acceptable list ensure function returns true
		for allowed_result in "${allowed_results[@]}"
		do
			if [ $test_result != true ]; then
				# compute lengths of result strings
				allowed_result_size=${#allowed_result}
				actual_result_size=${#actual_result}
				
				# TODO: remove this if condition and directly go to Else by switching lt to ge
				if [ $actual_result_size -lt $allowed_result_size ]; then echo "error";
					echo "The actual size is:"
					echo $actual_result_size
					echo "WHEREAS allowed_result_size=" 
					echo $allowed_result_size
					echo "so actual is smaller than allowed, so do nothing"
				else 
					# test if left string is in the tail of the allowed result string
					# TODO: include contains option in separate function
					temp_test_result=$(right_is_in_head_of_left "$actual_result" "$allowed_result");
					if [ $(echo -n $temp_test_result | tail -c 4) == true ]; then
						test_result=true
					fi
				fi
			fi
		done
	fi

	# Ensure the last 4/5 characters of the output of this function contains the true false evaluation.
	echo "$test_result"
}

actual_result_contains_any_allowed_result() {
	# declare default function output
	test_result=false
	
	# get the actual result
	actual_result=$1
	shift # Shift all arguments to the left (original $1 gets lost)
	
	# get the list of allowed results and list size
	allowed_results=("$@") 
	list_size=${#allowed_results}

	# Only engage this function if the list size is greater than 1
	if [ $list_size -gt 1 ]; then echo "error";
	
		# if the actual result is in the acceptable list ensure function returns true
		for allowed_result in "${allowed_results[@]}"
		do
			if [ $test_result != true ]; then
				# compute lengths of result strings
				allowed_result_size=${#allowed_result}
				actual_result_size=${#actual_result}
				
				# TODO: remove this if condition and directly go to Else by switching lt to ge
				if [ $actual_result_size -lt $allowed_result_size ]; then echo "error";
					echo "The actual size is:"
					echo $actual_result_size
					echo "WHEREAS allowed_result_size=" 
					echo $allowed_result_size
					echo "so actual is smaller than allowed, so do nothing"
				else 
					# test if left string is in the tail of the allowed result string
					# TODO: include contains option in separate function
					temp_test_result=$(left_contains_right "$actual_result" "$allowed_result");
					if [ $(echo -n $temp_test_result | tail -c 4) == true ]; then
						test_result=true
					fi
				fi
			fi
		done
	fi
	
	# Ensure the last 4/5 characters of the output of this function contains the true false evaluation.
	echo $test_result
}

# Assumes the actual result is shorter than the allowed result
right_is_in_head_of_left() {
	left=$1
	right=$2
	right_size=${#right}

	# Output true or false to pass test result to parent function
	left_head_chars=$(echo -n $left | head -c $right_size)
	echo $(equal_strings "$left_head_chars" "$right")
}

# Assumes the actual result is shorter than the allowed result
right_is_in_tail_of_left() {
	left=$1
	right=$2
	right_size=${#right}
	left_tail_chars=$(echo -n $left | tail -c $right_size)

	# Output true or false to pass test result to parent function
	echo $(equal_strings "$left_tail_chars" "$right")
}

# Assumes both strings have equal lengths
equal_strings() {
	left=$1
	right=$2
	
	# Initialise the default test result to false
	test_result=false
	
	# Set the test result to true if the left and right string are equal
	if [ "$left" = "$right" ]; then
		echo "Strings are equal."
		test_result=true
	else
	    	echo "Strings are not equal."
	fi
	
	# Output true or false to pass the equality test result to parent function
	echo $test_result
}

left_contains_right() {
	# get the actual result
	left=$1
	right=$2
	
	# TODO: test if the two incoming strings are equal and return true if yes, false otherwise
	if [[ $left == *"$right"* ]]; then
		echo "It's in there!"
		test_result=true
	else
		test_result=false
	fi
	echo $test_result
}
