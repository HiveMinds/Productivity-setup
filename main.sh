#!/bin/bash
. src/hardcoded_variables.txt
. src/ask_user_choice.sh
. src/install_user_choice.sh
. src/helper.sh

autokey_flag='false'
brave_flag='false'
github_flag='false'
keepass2_flag='false'
nordvpn_flag='false'
openvpn3_flag='false'
privoxy_flag='false'
searchmonkey_flag='false'
signal_flag='false'
texlive_flag='false'
texmaker_flag='false'
wine_flag='false'
zotero_flag='false'
anki_flag='false'
notepadpp_flag='false'
anaconda_flag='false'
energized_pro_flag='false'
energized_pro_social_flag='false'
energized_pro_porn_flag='false'
energized_pro_additional_flag='false'
language_tool_flag='false'


print_usage() {
	printf "\nUsage: write:"
	printf "\n\n    ./main.sh \nTo decide with a y/n whether you want to install a package for each supported software package."
	printf "\n\n    ./main.sh --install <list of packages separated by spaces (example on nextline)>"
	#printf "\n./install_gitlab -w\n to do an installation of the GitLab runner that waits untill the GitLab server is running."
	printf "\n    ./main.sh --install autokey zotero"
	printf "\nTo install the autokey software and zotero."
	printf "\n\n    ./main.sh -h\n    ./main.sh --help\nTo see this menu.\n\n"
	printf "The supported package argument list is:\n"
	printf "anaconda\n"
	printf "anki\n"
	printf "autokey-gtk\n"
	printf "brave\n"
	printf "energizedprotection_social\n"
	printf "energizedprotection_porn\n"
	printf "energizedprotection_additional\n"
	printf "github\n"
	printf "keepass2\n"
	printf "language_tool\n"
	printf "nordvpn\n"
	printf "notepad++\n"
	printf "openvpn3\n"
	printf "privoxy\n"
	printf "searchmonkey\n"
	printf "signal\n"
	printf "texlive-xetex\n"
	printf "texmaker\n"
	printf "wine\n"
	printf "zotero\n"
	printf "\n\n"
}

eat_argument_list() {
	# create array
	local -n arr=$1             # use nameref for indirection
	shift # eat the reference variable to get the original remaining argument list
	arr=() # innitialise array with branches
	
	# Loop through the remaining arguments
	while [ "${1:-}" != "" ]; do
		case "$1" in
			"autokey")
				shift # eat the remaining argument list element
				arr+=("autokey") # add autokey to array
				;;
			"brave")
				shift # eat the remaining argument list element
				arr+=("") # add to 	 array
				;;
			"github")
				shift # eat the remaining argument list element
				arr+=("github") # add to 	 array
				;;
			"keepass2")
				shift # eat the remaining argument list element
				arr+=("keepass2") # add to 	 array
				echo "Error keepass currently not supported. See: https://github.com/HiveMinds/Productivity-setup/issues/46"
				exit 5
				;;
			"nordvpn")
				shift # eat the remaining argument list element
				arr+=("nordvpn") # add to 	 array
				;;
			"openvpn3")
				shift # eat the remaining argument list element
				arr+=("openvpn3") # add to 	 array
				;;
			"privoxy")
				shift # eat the remaining argument list element
				arr+=("privoxy") # add to 	 array
				;;
			"searchmonkey")
				shift # eat the remaining argument list element
				arr+=("searchmonkey") # add to 	 array
				;;
			"signal")
				shift # eat the remaining argument list element
				arr+=("signal") # add to 	 array
				;;
			"texlive")
				shift # eat the remaining argument list element
				arr+=("texlive") # add to 	 array
				;;
			"texmaker")
				shift # eat the remaining argument list element
				arr+=("texmaker") # add to 	 array
				;;
			"wine")
				shift # eat the remaining argument list element
				arr+=("wine") # add to 	 array
				;;
			"zotero")
				shift # eat the remaining argument list element
				arr+=("zotero") # add zotero to array
				;;
			"anki")
				shift # eat the remaining argument list element
				arr+=("anki") # add to 	 array
				;;
			"notepad")
				shift # eat the remaining argument list element
				arr+=("notepad") # add to 	 array
				;;
			"anaconda")
				shift # eat the remaining argument list element
				arr+=("anaconda") # add to 	 array
				;;
			"ep_soc")
				shift # eat the remaining argument list element
				arr+=("ep_soc") # add to 	 array
				;;
			"ep_pn")
				shift # eat the remaining argument list element
				arr+=("ep_pn") # add to 	 array
				;;
			"ep_extra")
				shift # eat the remaining argument list element
				arr+=("ep_extra") # add to 	 array
				;;
			"language_tool")
				shift # eat the remaining argument list element
				arr+=("language_tool") # add to 	 array
				;;
		esac
	done
}

_setArgs(){
	while [ "${1:-}" != "" ]; do
		case "$1" in
			"--install")
				shift
				eat_argument_list package_list "$@"
				declare -p package_list
				;;
			"-h" | "--help")
				help_flag=true
				;;
		esac
		shift
	done
}
_setArgs  "$@"

if [ "$help_flag" == "true" ]; then
	print_usage
fi


echo "package_list=${package_list[@]}"

# get list of all possible installation types and pass it to the prompt.
function run_prompt_user_choice() {
	supported_installation_categories=$(read_categories "supported")
	
	if [ "${package_list[0]}" != "" ]; then
		# Export the user choices.
		selected_software_packages=$(cli_args_to_package_list "${package_list[@]}")
	else
		echo "ask user"
		# Assumption: this writes the selected packages to a selected_packages_list.txt 
		selected_software_packages=$(prompt_user_choice "install" $supported_installation_categories)
	fi
	
	echo "The selected_software_packages for installation are:"
	echo $selected_software_packages
	
	# install selected packages.
	# shellcheck disable=SC2091
	install_user_choices
	
	# test selected packages.
	test_user_choice_installation
}
sudo chmod +x src/*.sh
run_prompt_user_choice "$@"
