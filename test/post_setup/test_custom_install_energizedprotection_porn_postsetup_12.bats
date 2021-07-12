#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh

#---------------------------------------------------------------------------------------------------------------------------
@test "Testing adult content site is blocked." {
	
	result=fail
	run wget --spider https://www.0-0.org
	assert_failure 
}

@test "Testing the Electronic Frontier Foundation is accessible." {
	result=fail
	wget --spider https://coveryourtracks.eff.org/
	if [ $? -eq 0 ]; then
		result=accessible
	fi
	assert_equal $result accessible
}