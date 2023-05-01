#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @file        : preview-fzf-repo
# @created     : miércoles mar 31, 2021 09:26:01 -05
#
# @description : Helper muestra una vista previa con los datos de un repositorio a clonar
######################################################################

repo=$1
file_repo_cached="$HOME/.oh-my-zsh/custom/files/repo_cached.txt"

# Is public repository
is_public=$(cat $file_repo_cached | grep "/$repo" | awk '{ print $(NF-1) }' | sed 's/public/true/' | sed 's/private/false/')
if [[ $is_public == "fork" ]]; then
	is_public=$(cat $file_repo_cached | grep "/$repo" | awk '{ print $(NF-2) }' | sed 's/public/true/' | sed 's/private/false/')
fi

# Is fork repository
is_fork=$(cat $file_repo_cached | grep "/$repo" | awk '{ print $(NF-1) }')
if [[ $is_fork == "fork" ]]; then
	is_fork="true"
else
	is_fork="false"
fi

# Get last commit
last_commit=$(cat $file_repo_cached | grep "/$repo" | awk '{ print $(NF) }' | tr 'T' ' ' | awk '{ print $1 }')

# Get description
description=$(cat $file_repo_cached | grep "/$repo" | awk '{$1=""; $NF=""; $(NF-1)=""; print }')

echo -e "Is public: $is_public \nIs fork: $is_fork \nLast commit: $last_commit \nDescription: $description"
