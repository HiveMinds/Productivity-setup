source src/change_default_opening_application.sh
# Specify with which programs extensions are opened by default.
set_default_opening_applications() {
	
	# Declare filenames of files that perform commands
	change_default_opening_application yml gedit $LOG_PATH
	change_default_opening_application txt gedit $LOG_PATH
}

test_language_tool() {
	# TODO: change to languagetool tests
	# ./test/libs/bats/bin/bats test/post_setup/test_custom_install_anaconda_postsetup.bats
    echo ""
}
