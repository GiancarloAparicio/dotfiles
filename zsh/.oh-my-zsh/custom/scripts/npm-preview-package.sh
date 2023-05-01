#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @created     : domingo abr 04, 2021 08:11:46 -05
#
# @description : 
######################################################################

list_packages_cached=$HOME/.oh-my-zsh/custom/files/npm-list-packages.txt
package=$1

name=$(cat $list_packages_cached | jq --raw-output ".[] | select(.name==\"$package\") | .name")
description=$(cat $list_packages_cached | jq --raw-output ".[] | select(.name==\"$package\") | .description")
version=$(cat $list_packages_cached | jq --raw-output ".[] | select(.name==\"$package\") | .version")
keywords=$(cat $list_packages_cached | jq --raw-output ".[] | select(.name==\"$package\") | .keywords")

echo -e "Name: $name \nDescription: $description \nVersion: $version \nKeywords: $keywords"
