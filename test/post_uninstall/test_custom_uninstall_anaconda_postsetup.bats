#!./test/libs/bats/bin/bats
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

source src/hardcoded_variables.txt
source test/helper.sh

@test "Test the conda command is not recognized" {
	# check if conda is installed
	run bash -c "conda -V"
	assert_failure
	assert_output -p "conda: command not found"
}

@test "Test if the home/$USER/anaconda3 folder is deleted." {
	# does not assert file but bath, hence also supports asserting dirs
	assert_file_not_exist /home/$USER/anaconda3
}

@test "Test if the home/$USER/anaconda folder is deleted." {
	# does not assert file but bath, hence also supports asserting dirs
	assert_file_not_exist /home/$USER/anaconda
}

@test "Checking anaconda content is removed from the /home/$USER/.bashrc content" {
	filepath=/home/$USER/.bashrc
	assert_file_exist $filepath
	
	# verify that querying the starting line that indicates the anaconda content is in the .bashrc returns nothing.
	starting_line_query=$(grep -n "posix" $filepath)
	run bash -c "grep -n \"# >>> conda initialize >>>\" $filepath"
	assert_failure
	
	# verify that querying the ending line that indicates the anaconda content is in the .bashrc returns nothing.
	run bash -c "grep -n \"# <<< conda initialize <<<\" $filepath"
	assert_failure
}