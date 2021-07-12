#!/bin/bash
apt_add_signal_repo_to_repo_list() {
	local LOG_PATH=$1
	
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.
	should_add_signal_to_repo_list=false

	# 2. Add our repository to your list of repositories
	# if /etc/apt/sources.list.d/signal-xenial.list file does not yet exist
	if [ ! -f /etc/apt/sources.list.d/signal-xenial.list ]; then
	    should_add_signal_to_repo_list=true
	else
		# the file exists, read its content to a variable
		var=$(</etc/apt/sources.list.d/signal-xenial.list)

		# if file content does not contain the required string
		if [[ $var != "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" ]]; then
			should_add_signal_to_repo_list=true
		fi	
	fi
		
	# if the signal list of repos does not contain the right string, overwrite the file
	if [[ $should_add_signal_to_repo_list == true ]]; then
		
		# removed the append argument (-a) as this scripts is oppinionated and thinks the 
		# signal repository list should only contain one url, and that is the one specified here:
		update=$(echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list)
		# export overwriting command output to log file
		echo $update > "${LOG_PATH}"
	else
		echo "The signal repository was already added to the list of signal repositories." > "${LOG_PATH}"
	fi
}
apt_add_signal_repo_to_repo_list "$@"
