#!/bin/bash

message=$@
reg_exp="\*? .*-.{2} (.*?) .*"

if [[ $message =~ $reg_exp ]]; then
	echo ${BASH_REMATCH[1]} | awk '{print $1}'
fi
