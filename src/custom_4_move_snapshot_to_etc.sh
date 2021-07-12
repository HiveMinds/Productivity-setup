#!/bin/bash


# Downloads the social package with wget.
clone_language_tool_repo() {
	
	local LOG_PATH=$1
	
	local create_target_dir=$(sudo mkdir -p $LANGUAGE_TOOL_TARGET_DIR)
	
	local create_language_tool=$(sudo mv $LANGUAGE_TOOL_SNAPSHOT_PATH $LANGUAGE_TOOL_TARGET_DIR)
	echo "create_language_tool:$create_language_tool" >&2
	
	# Export the wget_command_log_output to a log file.
	echo $create_language_tool > "${LOG_PATH}"
}


# Ensures this script executes the function above.
clone_language_tool_repo "$@"