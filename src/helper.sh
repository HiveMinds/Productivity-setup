#!/bin/bash
run_main_functions() {
	local SCRIPT_NAME=$1
	local EXTRA_ARGUMENT=$2
	SCRIPT_PATH=src/"$SCRIPT_NAME".sh
	local LOG_PATH=$LOG_LOCATION"$SCRIPT_NAME".txt
	
	chmod +x $SCRIPT_PATH
	
	# Remove old log files if exist
	if [ -f "$LOG_PATH" ] ; then
	    rm "$LOG_PATH"
	fi
	
	# run the function that updates apt
	if [ "$EXTRA_ARGUMENT" == "" ]; then
		source ./$SCRIPT_PATH $LOG_PATH
	else
		source ./$SCRIPT_PATH $LOG_PATH $EXTRA_ARGUMENT
	fi
}

install_energized_protection_social_package() {
	local script_name=$1
	local filepath_host=$2
	local package_type="social"
	local script_path=src/"$script_name".sh
	
	# run the function that installs something
	if [ "$filepath_host" == "" ]; then
		source ./$script_path $package_type
	else
		source ./$script_path $package_type $filepath_host
	fi
}

install_energized_protection_porn_package() {
	local script_name=$1
	local filepath_host=$2
	local package_type="porn"
	local script_path=src/"$script_name".sh
	
	# run the function that installs something
	if [ "$filepath_host" == "" ]; then
		source ./$script_path $package_type
	else
		source ./$script_path $package_type $filepath_host
	fi
}

install_energized_protection_additional_package() {
	local script_name=$1
	local filepath_host=$2
	local package_type="additional"
	local script_path=src/"$script_name".sh
	
	# run the function that installs something
	if [ "$filepath_host" == "" ]; then
		source ./$script_path $package_type
	else
		source ./$script_path $package_type $filepath_host
	fi
}

execute_files() {
	filenames_without_extension=("$@")
	
	# Loop through files that perform commands
	for i in "${filenames_without_extension[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

write_to_log() {

	# read incoming arguments
	dest_dir=$1
	dest_file=$2
	dest_path=$dest_dir$dest_file
	
	shift # eat first argument
	shift # eat second argument
	
	# create empty file (overwrite previous content if it exists)
	> $dest_path
	
	# append remaining args to file
	for i in "$*"; do
		cat <<< "$i" >> $dest_path
	done
}

append_to_log() {
	echo ""
}

remove_logs() {
	sudo rm -r src/logs/*
}

remove_log_file() {
	log_filename=$1
	if [ -f "src/logs/$log_filename" ] ; then
	    sudo rm -r src/logs/$log_filename
	fi
}
remove_log_file "$@"

create_log_file() {
	log_filename=$1
	log_dirname=$2
	mkdir -p $log_dirname
	touch src/logs/$log_filename
}

read_user_key_from_log() {
	value=$(<src/logs/D_26_add_user_to_taskserver.txt)
	RESULT=${value:14:36}
	echo $RESULT
}
