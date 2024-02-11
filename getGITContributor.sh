#!/bin/bash

######################
#Author: Praveen
#Date:11-02-2024
#Version:v1.0
#
#
#This script will fetch the list of users who have the pull permission
#export username & token before executing the script
#This script expects two arguments - Owner and Repo name
######################

#Helper function will exit the script if no of argument does not equal two
function helper {
local arguments_expected=2
if [ "$arg_count" -ne "$arguments_expected" ]; then
    echo "This script expects two arguments - Owner and Repo Name"
    exit 1
fi
}

#get command line arguments
OWNER=$1
REPO=$2

#get argument count
arg_count=$#

#calls a helper function
helper

#executes curl and get username whose pull permission is true
user=`curl -s -u "$username:$token" "https://api.github.com/repos/$OWNER/$REPO/collaborators" |jq ".[] | select(.permissions.pull==true) | .login"`
echo "users:$user"
