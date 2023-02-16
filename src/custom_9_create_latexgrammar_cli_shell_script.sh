#!/bin/bash

# Downloads the social package with wget.
create_language_tool_shell_script() {
	
	local LOG_PATH=$1
	
	local create_target_file=$(sudo touch $LANGUAGE_TOOL_TARGET_DIR/$LATEX_GRAMMAR_CLI_SCRIPTNAME)
	local make_readable=$(sudo chmod 777 $LANGUAGE_TOOL_TARGET_DIR/$LATEX_GRAMMAR_CLI_SCRIPTNAME)
	
	command_one="java -jar $LANGUAGE_TOOL_TARGET_DIR/$LANGUAGE_TOOL_SNAPSHOT_DIRNAME/$LANGUAGE_TOOL_CLI_TARGET_FILENAME "
	command_one="sudo mkdir $LANGUAGE_TOOL_TARGET_DIR/tmp"
	#command_two="cd $LANGUAGE_TOOL_TARGET_DIR/tmp"
	
	command_three_p0="detex -n "
	#command_three_p1='${@:1}'
	command_three_p1='$1'
	command_three_p2=' > '$LANGUAGE_TOOL_TARGET_DIR'/tmp/out.txt && '$LANGUAGE_TOOL_TARGET_DIR'/'$LANGUAGE_TOOL_CLI_CONTROL_SCRIPTNAME' '
	command_four='"'
	command_five='-d WHITESPACE_RULE  '$LANGUAGE_TOOL_TARGET_DIR'/tmp/out.txt'
	command_six='"'
	
	
	echo "command_one:$command_one" >&2
	#echo "command_two:$command_two" >&2
	echo "command_three_p0:$command_three_p0" >&2
	echo "command_three_p1:$command_three_p1" >&2
	echo "command_three_p2:$command_three_p2" >&2
	
	echo "$command_one" > "$LANGUAGE_TOOL_TARGET_DIR/$LATEX_GRAMMAR_CLI_SCRIPTNAME"
	#echo "$command_two" >> "$LANGUAGE_TOOL_TARGET_DIR/$LATEX_GRAMMAR_CLI_SCRIPTNAME"
	echo "$command_three_p0$command_three_p1$command_three_p2$command_four$command_five$command_six" >> "$LANGUAGE_TOOL_TARGET_DIR/$LATEX_GRAMMAR_CLI_SCRIPTNAME"
}


# Ensures this script executes the function above.
create_language_tool_shell_script "$@"