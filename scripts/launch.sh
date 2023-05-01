#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @file        : launch
# @created     : martes mar 23, 2021 13:18:06 -05
#
# @description : Description
######################################################################

app=$(echo "$PATH" | tr ":" "\n" | xargs -I{} -- find {} -maxdepth 1 -mindepth 1 -executable 2>/dev/null | sort -u | fzf)

eval "$app &"

echo "$app &"

zsh -c " eval '$app &' && sleep 5 "
