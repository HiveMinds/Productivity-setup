#!/bin/bash
. src/hardcoded_variables.txt
. src/ask_user_choice.sh
. src/install_user_choice.sh
. src/helper.sh

# get list of all possible installation types and pass it to the prompt.
function run_prompt_user_choice() {
	supported_installation_categories=$(read_categories "supported")
	selected_software_packages=$(prompt_user_choice "install" $supported_installation_categories)
	
	echo "The selected_software_packages for installation are:"
	echo $selected_software_packages
	
	# install selected packages.
	# shellcheck disable=SC2091
	$(install_user_choices)
	
	# test selected packages.
	test_user_choice_installation
}
run_prompt_user_choice "$@"
