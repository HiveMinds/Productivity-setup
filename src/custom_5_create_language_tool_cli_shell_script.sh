#!/bin/bash


# Downloads the social package with wget.
clone_language_tool_repo() {
	
	local LOG_PATH=$1
	
	local create_target_file=$(sudo touch $LANGUAGE_TOOL_TARGET_DIR/$LANGUAGE_TOOL_CLI_CONTROL_SCRIPTNAME)
	local make_readable=$(sudo chmod 777 $LANGUAGE_TOOL_TARGET_DIR/$LANGUAGE_TOOL_CLI_CONTROL_SCRIPTNAME)
	
	command_one="java -jar $LANGUAGE_TOOL_TARGET_DIR/$LANGUAGE_TOOL_SNAPSHOT_DIRNAME/$LANGUAGE_TOOL_CLI_TARGET_FILENAME "
	#command_two='"${@:1}"'
	command_two='$1'
	echo "command_one:$command_one" >&2
	echo "command_two:$command_two" >&2
	
	echo "$command_one$command_two" > "$LANGUAGE_TOOL_TARGET_DIR/$LANGUAGE_TOOL_CLI_CONTROL_SCRIPTNAME"
}


# Ensures this script executes the function above.
clone_language_tool_repo "$@"