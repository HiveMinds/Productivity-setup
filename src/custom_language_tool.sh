#!/bin/bash
# Declare filenames of files that perform commands to install anki
install_language_tool() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_0_update"
                "apt_1_upgrade"
                "custom_0_clone_language_tool_repo"
				"apt_install_maven"
				#"custom_2_run_maven_test" # takes too long
				"custom_3_build_language_tool"
				"custom_4_move_snapshot_to_etc"
				"custom_5_create_language_tool_cli_shell_script"
				"custom_5_create_language_tool_native_shell_script"
				"apt_install_maven"
				"apt_install_make"
				"apt_install_gcc"
				"apt_install_flex"
				"custom_6_clone_opendetex_repo"
				"custom_7_make_opendetex"
				"custom_8_make_install_opendetex"
				"custom_9_create_latexgrammar_cli_shell_script"
				"custom_9_create_latexgrammar_native_shell_script"
				"apt_install_make_icedtea_netx"
                )

	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
	
	echo "Now you can run languagetool on the detexified/normal/pdf text of a .tex file using the following command:" >&2
	echo "sudo /etc/language_tool/latex_grammar_cli.sh ~/Documents/some_tex_file.tex" >&2
	echo "for the LanguageTool command line interface, and:" >&2
	echo "sudo /etc/language_tool/latex_grammar_native.sh ~/Documents/some_tex_file.tex" >&2
	echo "for the LanguageTool GUI." >&2
	echo "You can also directly inspect a .tex file instead of the detexified text, using:" >&2
	echo "java -jar /etc/language_tool/LanguageTool-5.4-SNAPSHOT/languagetool.jar ~/Documents/some_tex_file.tex" >&2
	echo "Or:" >&2
	echo '/etc/language_tool/language_tool_native.sh ~/Documents/some_tex_file.tex' >&2
	echo "Where you have to change ~/Documents/some_tex_file.tex to the path of the .tex file you want to inspect." >&2
	
}

test_language_tool() {
	# TODO: change to languagetool tests
	./test/libs/bats/bin/bats test/post_setup/test_custom_install_anaconda_postsetup.bats
}
