#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @file        : fzf-preview
# @created     : domingo mar 28, 2021 20:59:54 -05
#
# @description : Description
######################################################################

dir=$*

tree -C $(echo $dir | awk '{print $1 }')
