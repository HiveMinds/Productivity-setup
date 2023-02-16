#!/bin/bash


# Configure firefox by adding extensions.
set_apt_firefox_policies() {
	manual_assert_file_exists policies.json
	sudo mkdir -p /etc/firefox/policies
	sudo cp policies.json /etc/firefox/policies/policies.json
	manual_assert_file_exists /etc/firefox/policies/policies.json
	#sudo rm /etc/firefox/policies/policies.json
}


# Configure Ublock Origin to remove unwanted information from websites.

#######################################
# 
# Local variables:
#  
# Globals:
#  
# Arguments:
#  
# Returns:
#  0 If function was evaluated succesfull.
# Outputs:
#  
# TODO(a-t-0):
#######################################
# Source: https://stackoverflow.com/questions/70597896/check-if-conda-env-exists-and-create-if-not-in-bash
find_in_conda_env(){
    conda env list | grep "${@}" >/dev/null 2>/dev/null
}


#######################################
# 
# Local variables:
#  
# Globals:
#  
# Arguments:
#  
# Returns:
#  0 If function was evaluated succesfull.
# Outputs:
#  
# TODO(a-t-0):
#######################################
conda_env_exists() {
	local some_envirionment="$1"
	if find_in_conda_env ".*$some_envirionment.*" ; then
   		echo "FOUND"
	else
		echo "NOTFOUND"
	fi
}

#######################################
# 
# Local variables:
#  
# Globals:
#  
# Arguments:
#  
# Returns:
#  0 If function was evaluated succesfull.
# Outputs:
#  
# TODO(a-t-0): refactor repository wide to download_repository_using_https.
# TODO(a-t-0): write tests for method.
#######################################
# Downloads a repository into the root directory of this repository if the
#+ destination folder does yet exist
#+ TODO: write test for method
download_repository() {
	git_username=$1
	reponame=$2
	repo_url="https://github.com/"$git_username"/"$reponame".git"
	#echo "repo_url=$repo_url"
	if [ ! -d "$reponame" ]; then
		git clone $repo_url &&
		set +e
	fi
}

#######################################
# Restores Ublock Origin backup using Selenium browser controller. 
# Local variables:
#  
# Globals:
#  
# Arguments:
#  
# Returns:
#  0 If function was evaluated succesfull.
# Outputs:
#  
# TODO(a-t-0):
#######################################
# source src/Selenium/get_gitlab_server_runner_token.sh && get_registration_token_with_python
restore_ublock_origin_settings() {
	
    local repo_name="restore-ublock-backup"
    local conda_env_name="restore-ublock-backup"
	
	set_apt_firefox_policies

    sudo rm -r "$repo_name"
	
	# Check if the repository exists
	download_repository "hiveminds" "$repo_name"
	
	# shellcheck disable=SC2034
	if [ "$(conda_env_exists $conda_env_name)" == "FOUND" ]; then
		eval "$(conda shell.bash hook)"
		cd restore-ublock-backup && conda deactivate && conda activate restore-ublock-backup && python -m src.restore_ublock_backup --b0
    else
		eval "$(conda shell.bash hook)"
		cd restore-ublock-backup && conda env create --file environment.yml && conda activate restore-ublock-backup && python -m src.restore_ublock_backup --b0
		
	fi
	cd ..
	# TODO: verify path
}